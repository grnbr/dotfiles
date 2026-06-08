for f in "$HOME/dotfiles/src/shell/modules/dev"/*.zsh(.N); do
  source "$f"
done

########## Pnpm ##########
alias dev="pnpm dev"
alias lint="pnpm lint"
alias gena="pnpm generate:api"
alias stylelint="pnpm stylelint"

########## Postgres ##########
alias pgroot="sudo -iu postgres"
pg() {
  sudo -iu postgres psql "$@"
}

alias jwtgen="node -e \"console.log(require('crypto').randomBytes(32).toString('hex'))\""
