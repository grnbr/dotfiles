FROM archlinux

RUN pacman -Syu --noconfirm sudo python uv \
    && useradd -m tester \
    && echo "tester ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/tester

USER tester
WORKDIR /dotfiles
