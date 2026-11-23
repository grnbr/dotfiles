import logging
import subprocess

logger = logging.getLogger(__name__)

PACKAGES = {
    "system": [],
    "cli": [
        "wl-clipboard",
    ],
    "utils": [
        "waybar",
        "grim",
        "slurp",
        "satty",
    ],
}


def install_wayland_packages() -> None:
    logger.info("==> Installing Wayland packages...")

    subprocess.run(
        ["sudo", "pacman", "-S", "--needed", "--noconfirm", *_all_packages()],
        check=True,
    )


def uninstall_wayland_packages() -> None:
    logger.info("==> Uninstalling Wayland packages...")

    subprocess.run(
        ["sudo", "pacman", "-Rns", "--noconfirm", *_all_packages()],
        check=True,
    )


def _all_packages() -> list[str]:
    return [pkg for group in PACKAGES.values() for pkg in group]
