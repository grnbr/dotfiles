import logging

from setups_py.shared.jobs.manage_configs import apply_configs

logger = logging.getLogger(__name__)

CONFIGS = [
    "kitty",
    "gtk-3.0",
    "gtk-4.0",
    "environment.d",
    "dunst",
    "xdg-desktop-portal",
    "rofi",
    "zathura",
]


def configure() -> None:
    logger.info("Applying main configs...")

    apply_configs(*CONFIGS)
