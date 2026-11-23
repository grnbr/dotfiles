import logging
import subprocess

logger = logging.getLogger(__name__)

PACKAGES = {
    "system": [
        "xorg-server",
        "xorg-xinit",
    ],
    "cli": [
        "xclip",
    ],
    "utils": [],
}


def install_x11_packages() -> None:
    logger.info("==> Installing X11 packages...")

    subprocess.run(
        ["sudo", "pacman", "-S", "--needed", "--noconfirm", *_all_packages()],
        check=True,
    )


def uninstall_x11_packages() -> None:
    logger.info("==> Uninstalling X11 packages...")

    subprocess.run(
        ["sudo", "pacman", "-Rns", "--noconfirm", *_all_packages()],
        check=True,
    )


def _all_packages() -> list[str]:
    return [pkg for group in PACKAGES.values() for pkg in group]
