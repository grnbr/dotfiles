vpn() {
  case "$1" in
    start) sudo systemctl start sing-box ;;
    restart) sudo systemctl restart sing-box ;;
    stop) sudo systemctl stop sing-box ;;
    status) sudo systemctl status sing-box ;;
    log) sudo journalctl -u sing-box.service -f ;;
    *) echo "usage: vpn {start|restart|stop|status|log}"
  esac
}

_vpn() {
  local -a cmds
  cmds=(
    'start:Start sing-box'
    'restart:Restart sing-box'
    'stop:Stop sing-box'
    'status:Show status'
    'log:Follow logs'
  )

  _describe 'vpn commands' cmds
}

compdef _vpn vpn
