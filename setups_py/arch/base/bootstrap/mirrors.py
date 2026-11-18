import shutil
import subprocess

COUNTRIES = ["Germany", "Finland", "Netherlands", "Poland", "Czechia", "Kazakhstan"]


def bootstrap_mirrors() -> None:
    print("[bootstrap] Setting up mirrors...")
    _ensure_reflector()
    subprocess.run(
        [
            "sudo",
            "reflector",
            "--country",
            ",".join(COUNTRIES),
            "--latest",
            "30",
            "--protocol",
            "https",
            "--download-timeout",
            "10",
            "--save",
            "/etc/pacman.d/mirrorlist",
        ],
        check=True,
    )


def _ensure_reflector() -> None:
    if shutil.which("reflector") is None:
        print("[bootstrap] Installing reflector...")
        subprocess.run(
            ["sudo", "pacman", "-Sy", "--noconfirm", "reflector"], check=True
        )
