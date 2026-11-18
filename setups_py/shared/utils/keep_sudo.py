import subprocess
import threading
import time


def keep_sudo() -> None:
    subprocess.run(["sudo", "-v"], check=True)
    threading.Thread(target=_refresh_sudo, daemon=True).start()


def _refresh_sudo() -> None:
    while True:
        subprocess.run(["sudo", "-n", "true"], check=True)
        time.sleep(60)
