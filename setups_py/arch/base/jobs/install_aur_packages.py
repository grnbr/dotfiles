import logging
import shutil
import subprocess
from pathlib import Path

logger = logging.getLogger(__name__)

BUILD_DIR = Path.home() / ".local" / "yay"

AUR_PACKAGES = [
    "brave-bin",
]


def install_aur_packages() -> None:
    if not _has_yay():
        _install_yay()

    logger.info("Installing AUR packages...")

    subprocess.run(
        ["yay", "-S", "--noconfirm", "--needed", *AUR_PACKAGES],
        check=True,
    )


def _has_yay() -> bool:
    return shutil.which("yay") is not None


def _install_yay() -> None:
    logger.info("Installing yay...")

    subprocess.run(
        ["sudo", "pacman", "-S", "--needed", "--noconfirm", "git", "base-devel"],
        check=True,
    )

    shutil.rmtree(BUILD_DIR, ignore_errors=True)

    subprocess.run(
        ["git", "clone", "https://aur.archlinux.org/yay.git", str(BUILD_DIR)],
        check=True,
    )

    subprocess.run(
        ["makepkg", "-si", "--noconfirm"],
        cwd=BUILD_DIR,
        check=True,
    )
