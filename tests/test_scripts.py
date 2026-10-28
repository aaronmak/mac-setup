"""Run setup scripts against fake tools and temporary home directories."""
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]


class ScriptTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.repo = self.root / "repo"
        self.repo.mkdir()
        for script in ROOT.glob("*.sh"):
            shutil.copy2(script, self.repo)
        shutil.copytree(ROOT / "lib", self.repo / "lib")
        self.bin = self.root / "bin"
        self.bin.mkdir()
        self.prefix = self.root / "homebrew"
        (self.prefix / "bin").mkdir(parents=True)
        self.home = self.root / "home"
        self.home.mkdir()
        self.log = self.root / "commands"
        self.env = dict(os.environ, HOME=str(self.home),
                        PATH=f"{self.bin}:/usr/bin:/bin", LOG=str(self.log),
                        PREFIX=str(self.prefix), FAIL="", GIT_EXEC=str(self.root / "git-core"))
        Path(self.env["GIT_EXEC"]).mkdir()
        self.tool("brew", '''
if [[ $1 == shellenv ]]; then
    print -r -- "export PATH='$PREFIX/bin:$PATH'"
elif [[ $1 == --prefix ]]; then
    print -r -- "$PREFIX"
elif [[ $* == $FAIL ]]; then
    exit 42
elif [[ $* == 'install git' ]]; then
    touch "$GIT_EXEC/git-credential-osxkeychain"
    chmod +x "$GIT_EXEC/git-credential-osxkeychain"
fi
''')
        self.tool("git", '''
if [[ $1 == --exec-path ]]; then
    print -r -- "$GIT_EXEC"
elif [[ $1 == clone ]]; then
    mkdir -p "${@[-1]}/.git"
fi
''')
        for name in ("sudo", "mas", "pipx", "npm"):
            self.tool(name, '[[ $* != $FAIL ]] || exit 42\n')
        self.tool("curl", "exit 0\n")
        self.tool("install", "exit 0\n", self.prefix / "opt/fzf")

    def tool(self, name, body, directory=None):
        target = (directory or self.bin) / name
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_text('#!/bin/zsh -f\nprint -r -- "' + name +
                          ' $*" >> "$LOG"\n' + body)
        target.chmod(0o755)
        return target

    def run_script(self, name, *args, code=0):
        result = subprocess.run(["/bin/zsh", "-f", str(self.repo / name), *args],
                                env=self.env, input="y\n", text=True,
                                capture_output=True, timeout=15, cwd=self.root)
        self.assertEqual(result.returncode, code, result.stdout + result.stderr)
        return result

    def commands(self):
        return self.log.read_text() if self.log.exists() else ""

    def test_nvim_rerun_preserves_checkout(self):
        self.run_script("nvim.sh")
        self.run_script("nvim.sh")
        self.assertEqual(self.commands().count("git clone"), 1)

    def test_nvim_install_failure_stops_before_clone(self):
        self.env["FAIL"] = "install neovim"
        self.run_script("nvim.sh", code=42)
        self.assertNotIn("git clone", self.commands())

    def test_git_helper_in_exec_path_needs_no_install(self):
        self.tool("git-credential-osxkeychain", "exit 0", Path(self.env["GIT_EXEC"]))
        self.run_script("git.sh")
        self.assertNotIn("brew", self.commands())

    def test_git_helper_on_path_needs_no_install(self):
        self.tool("git-credential-osxkeychain", "exit 0")
        self.run_script("git.sh")
        self.assertEqual(self.commands(), "")

    def test_missing_git_helper_installs_git(self):
        self.run_script("git.sh")
        self.assertIn("brew install git", self.commands())

    def test_git_install_failure_propagates(self):
        self.env["FAIL"] = "install git"
        self.run_script("git.sh", code=42)

    def test_brew_rerun_repairs_checksum_link(self):
        link = self.prefix / "bin/sha256sum"
        link.symlink_to("/missing/old-target")
        self.run_script("brew.sh")
        self.run_script("brew.sh")
        self.assertEqual(os.readlink(link), str(self.prefix / "bin/gsha256sum"))
        self.assertEqual(self.commands().count("git clone"), 2)
        self.assertNotIn("sudo", self.commands())

    def test_brew_preserves_regular_checksum_file(self):
        target = self.prefix / "bin/sha256sum"
        target.write_text("keep me")
        self.run_script("brew.sh", code=1)
        self.assertEqual(target.read_text(), "keep me")

    def test_brew_failure_stops_later_installs(self):
        self.env["FAIL"] = "install coreutils"
        self.run_script("brew.sh", code=42)
        self.assertNotIn("brew install moreutils", self.commands())

    def prepare_bootstrap(self):
        # Replace only system lookup paths in the test copy to isolate it from
        # any Homebrew installation on the host machine.
        candidate = self.prefix / "bin/brew"
        helper = self.repo / "lib/homebrew.sh"
        helper.write_text(helper.read_text().replace("/opt/homebrew/bin/brew", str(candidate))
                          .replace("/usr/local/bin/brew", str(candidate)))
        (self.bin / "brew").rename(self.root / "brew-template")
        self.env["BREW_TEMPLATE"] = str(self.root / "brew-template")
        self.tool("curl", '''
[[ $* == *Homebrew/install* ]] || exit 0
cat <<'INSTALLER'
test "$NONINTERACTIVE" = 1 || exit 90
cp "$BREW_TEMPLATE" "$PREFIX/bin/brew"
INSTALLER
''')

    def test_bootstrap_path_reaches_following_modules(self):
        self.prepare_bootstrap()
        self.run_script("install.sh", "brew", "npm")
        self.assertIn("brew cleanup", self.commands())
        self.assertIn("npm install", self.commands())
        # The following module must receive the environment from the parent.
        self.tool("npm", '[[ $(command -v brew) == "$PREFIX/bin/brew" ]] || exit 91\n')
        self.run_script("install.sh", "brew", "npm")

    def test_bootstrap_download_failure_propagates(self):
        self.prepare_bootstrap()
        self.tool("curl", "exit 43\n")
        self.run_script("brew.sh", code=43)
        self.assertFalse((self.prefix / "bin/brew").exists())

    def test_app_failure_stops_before_app_store(self):
        self.env["FAIL"] = "install --cask xquartz"
        self.run_script("brew-apps.sh", code=42)
        self.assertNotIn("mas install", self.commands())

    def test_download_pipeline_failure_stops_before_cleanup(self):
        self.tool("curl", "exit 43\n")
        self.run_script("brew.sh", code=43)
        self.assertNotIn("brew cleanup", self.commands())

    def test_app_rerun_preserves_fonts_checkout(self):
        fonts = self.home / "code/personal/fonts"
        (fonts / ".git").mkdir(parents=True)
        self.tool("install.sh", "exit 0\n", fonts)
        self.run_script("brew-apps.sh")
        self.run_script("brew-apps.sh")
        self.assertNotIn("git clone", self.commands())

    def test_font_installer_failure_propagates(self):
        fonts = self.home / "code/personal/fonts"
        (fonts / ".git").mkdir(parents=True)
        self.tool("install.sh", "exit 44\n", fonts)
        self.run_script("brew-apps.sh", code=44)
        self.assertNotIn("brew cleanup", self.commands())

    def test_installer_stops_on_module_failure(self):
        self.env["FAIL"] = "install neovim"
        result = self.run_script("install.sh", "nvim", "npm", code=42)
        self.assertIn("Module nvim failed", result.stderr)
        self.assertNotIn("npm install", self.commands())

    def test_removed_dock_module_is_rejected_before_changes(self):
        self.run_script("install.sh", "arrange-dock", code=2)
        self.assertEqual(self.commands(), "")
        result = self.run_script("install.sh", "--help")
        self.assertNotIn("arrange-dock", result.stdout)


if __name__ == "__main__":
    unittest.main()
