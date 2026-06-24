alias se='sudoedit'
alias shu='read "ans?Are you sure you want to shutdown? (y/N) " && [[ $ans == [Yy] ]] && shutdown now'
alias reb='read "ans?Are you sure you want to reboot? (y/N) " && [[ $ans == [Yy] ]] && reboot'
alias cl='clear'
alias wl='wl-copy'
alias pwdc="pwd | wl-copy"
alias free='free -h'
alias ut7='sudo umount /dev/disk/by-id/usb-Samsung_PSSD_T7_Touch_S5KENJ0TB00202E-0:0-part1 && echo "T7 Touch safely unmounted."'

alias ten="trans :ru"
alias тру="trans ru:en"
alias brin='setsid brave-browser --incognito >/dev/null 2>&1 &'
alias frin='setsid firefox --private-window >/dev/null 2>&1 &'
alias gin='setsid google-chrome --incognito >/dev/null 2>&1 &'
alias lv='NVIM_APPNAME=nvim-lazy nvim'
alias ni='NVIM_APPNAME=nvim-ide nvim'
alias kv='NVIM_APPNAME=nvim-kickstarter nvim'
alias vi='nvim'

alias gcl="wl-copy < /mnt/linuxdisk/my-stuff/programming/jobs/cover-letter.txt"
alias gclen="wl-copy < /mnt/linuxdisk/my-stuff/programming/jobs/cover-letter-en.txt"
alias opfls='~/.local/bin/open_folders.sh'
