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
  else
    echo "error: unable to discover clipboard" 1>&2
  fi
}

function clipboard-set () {
  if [[ -x "$(command -v termux-clipboard-set)" ]]; then
    termux-clipboard-set "$@"
  else
    echo "error: unable to discover clipboard" 1>&2
  fi
}
