readonly WARNINGS_LOG_PATH="/tmp/setup-warnings.log"
export WARNINGS_LOG_PATH

warn() {
  echo "WARN: $*"
  echo "WARN: $*" >>"$WARNINGS_LOG_PATH"
}

export -f warn
