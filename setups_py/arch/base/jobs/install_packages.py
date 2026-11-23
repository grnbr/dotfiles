import logging
import subprocess

logger = logging.getLogger(__name__)

PACKAGES = {
    "system": [],
    "apps": [
        "firefox",
        "gnome-calculator",
        "gnome-sound-recorder",
        "rhythmbox",
        "loupe",
        "libreoffice",
        "flatpak",
        "blueman",
        "network-manager-applet",
    ],
    "utils": [
        "dunst",
        "rofi",
    ],
    "audio": [
        "pavucontrol",
        "playerctl",
    ],
}


def install_packages() -> None:
    logger.info("==> Installing packages...")

    packages = [pkg for group in PACKAGES.values() for pkg in group]

    subprocess.run(
        ["sudo", "pacman", "-S", "--needed", "--noconfirm", *packages],
        check=True,
    )
