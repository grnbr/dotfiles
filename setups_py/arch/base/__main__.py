import subprocess

from setups_py.arch.base.bootstrap.mirrors import bootstrap_mirrors
from setups_py.shared.utils.keep_sudo import keep_sudo


def main() -> None:
    keep_sudo()
    bootstrap_mirrors()
    update_system()


def update_system() -> None:
    print("Updating system...")
    _enable_multilib()
    subprocess.run(["sudo", "pacman", "-Syu", "--noconfirm"], check=True)


def _enable_multilib() -> None:
    subprocess.run(
        ["sudo", "sed", "-i", r"/\[multilib\]/,/Include/s/^#//", "/etc/pacman.conf"],
        check=True,
    )


if __name__ == "__main__":
    main()
