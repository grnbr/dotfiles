import logging
import subprocess

from setups_py.arch.base.jobs.bootstrap_mirrors import bootstrap_mirrors
from setups_py.arch.base.jobs.enable_multilib import enable_multilib
from setups_py.arch.base.jobs.install_aur_packages import install_aur_packages
from setups_py.arch.base.jobs.install_packages import install_packages
from setups_py.arch.shared.packages.install_main_packages import install_main_packages
from setups_py.shared.utils.keep_sudo import keep_sudo
from setups_py.shared.utils.setup_logging import setup_logging

logger = logging.getLogger(__name__)


def main() -> None:
    setup_logging()
    keep_sudo()
    bootstrap_mirrors()

    update_system()

    install_main_packages()
    install_packages()

    install_aur_packages()

    print("Setup finished ฅ^•ﻌ•^ฅ")


def update_system() -> None:
    logger.info("Updating system...")
    enable_multilib()
    subprocess.run(["sudo", "pacman", "-Syu", "--noconfirm"], check=True)


if __name__ == "__main__":
    main()
