function restart () {
  sudo rc-service $1 restart
}

function venv () {
  source $1/bin/activate
}

function asdf-latest () {
  for tool in $(asdf plugin list); do
    asdf install "${tool}" latest  \
      &&  asdf global "${tool}" latest  \
      &&  echo "${tool} set globally"
  done
}

function clipboard-get () {
  if [[ -x "$(command -v termux-clipboard-get)" ]]; then
    termux-clipboard-get "$@"
  elif [[ $XDG_SESSION_TYPE == "wayland" ]] && [[ -x "$(command -v wl-paste)" ]]; then
    wl-paste "$@"
  else
    echo "error: unable to discover clipboard" 1>&2
  fi
}

function clipboard-set () {
  if [[ -x "$(command -v termux-clipboard-set)" ]]; then
    termux-clipboard-set "$@"
  elif [[ $XDG_SESSION_TYPE == "wayland" ]] && [[ -x "$(command -v wl-copy)" ]]; then
    wl-copy "$@"
  else
    echo "error: unable to discover clipboard" 1>&2
  fi
}
