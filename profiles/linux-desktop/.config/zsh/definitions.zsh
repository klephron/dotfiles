# gentoo
alias gentoo-sysupdate="sudo emerge --sync && sudo emerge -aDNuv @world --exclude=\"\`awk 'END{print RS}\$0=\$0' ORS=\" \" /etc/portage/package.exclude_desktop\`\""
alias gentoo-sysupdateall="sudo emerge --sync && sudo emerge -aDNuv @world"

alias gentoo-sysupdate.emerge="sudo emerge -aDNuv @world --exclude=\"\`awk 'END{print RS}\$0=\$0' ORS=\" \" /etc/portage/package.exclude_desktop\`\""
alias gentoo-sysupdateall.emerge="sudo emerge -aDNuv @world"

alias gentoo-ntp-sync="sudo ntpdate -b -u 0.gentoo.pool.ntp.org"

function gentoo-restart () {
  sudo rc-service $1 restart
}

# archlinux
alias pacupdate="sudo pacman -Syu"
alias pacrmorph="sudo pacman -Rns \$(pacman -Qdtq)"
alias paclist="LC_ALL=C.UTF-8 pacman -Qi | awk '/^Name/{name=\$3} /^Installed Size/{print \$4\$5, name}' | LC_ALL=C.UTF-8 sort -h" alias yayn="yay --answerdiff none --answerclean none --answeredit none"
alias yayni="yayn --ignore \$(< /etc/pacman-ignore.txt tr '\\n' ',' | sed 's/,$//')"

# ownership
alias chownr="sudo chown $(whoami):$(whoami) -R ."

# dirstack
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# Xorg
alias 2160p="sed -i --follow-symlinks -E 's/^Xft.dpi:.*/Xft.dpi:144/' ~/.Xresources && xrdb ~/.Xresources && autorandr --load 1080-1.25_2160 && xrandr --output eDP --filter bilinear && echo 'awesome.restart()' | awesome-client"
alias 1080p="sed -i --follow-symlinks -E 's/^Xft.dpi:.*/Xft.dpi:96/' ~/.Xresources && xrdb ~/.Xresources && autorandr --load 1080 && xrandr --output eDP --filter bilinear && echo 'awesome.restart()' | awesome-client"

# ssh
alias ssh="TERM=tmux-256color COLORTERM=truecolor ssh"

function sshnc() {
  ssh -o StrictHostKeyChecking=no \
      -o UserKnownHostsFile=/dev/null \
      -o GlobalKnownHostsFile=/dev/null \
      "$@"
}

function sshdev () {
  local remote=$1
  local user=$2
  local root=${3:-root}

  # tried with sshpass, doesn't login as expected
  sshnc -t -p 2222 "${root}@${remote}" "sudo -i -u ${user}"
}

# docker
alias dockerip='docker inspect -f "{{ .Name}} {{ .NetworkSettings.IPAddress }}"'
alias dockerips='docker inspect -f "{{.Config.Image}} {{.Name}} {{.NetworkSettings.IPAddress}}" $(docker ps -q) \
  | awk "{gsub(/^\//, \"\", \$2); print}"'

# ls & grep
if [[ -x "$(command -v eza)" ]]; then
  alias ls="eza -F --sort Name"
else
  alias ls="ls --color -Fh"
fi

alias ll="ls -l"
alias lsa="ls -a"
alias lla="ls -la"
alias info='info --vi-keys'
alias grep="grep --color=auto"

# clipboard
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

alias ci="clipboard-get"
alias co="clipboard-set"

# python
alias py="python"
function venv () {
  source $1/bin/activate
}

# asdf
function asdf-latest () {
  for tool in $(asdf plugin list); do
    asdf install "${tool}" latest  \
      &&  asdf global "${tool}" latest  \
      &&  echo "${tool} set globally"
  done
}

# exercises
alias awkexercises="$HOME/venvs/awkexercises/bin/awkexercises"
alias sedexercises="$HOME/venvs/sedexercises/bin/sedexercises"

# encrypfs wrappers
ecrfs-wp-gen() {
  local output_file="$1"
  local output_dir=$(dirname "$output_file")
  local password

  if [[ -z "$output_file" ]]; then
    echo "Usage: $0 <path-to-wrapped-passphrase-output>" >&2
    return 1
  fi

  if [[ ! -d "$output_dir" ]]; then
    mkdir -p "$output_dir" || {
      echo "Error: Cannot create directory: $output_dir" >&2
      return 1
    }
  fi

  stty -echo
  printf "Passphrase: " >&2
  read password
  stty echo
  printf "\n" >&2

  ( head -c 48 /dev/random | base64; echo "$password" ) \
      | ecryptfs-wrap-passphrase "$output_file" >/dev/null

  unset password
}

ecrfs-wp-ins() {
  local wrapped_file="$1"
  local password

  if [[ -z "$wrapped_file" ]]; then
    echo "Usage: $0 <path-to-wrapped-passphrase>" >&2
    return 1
  fi

  if [[ ! -f "$wrapped_file" ]]; then
    echo "Error: Wrapped-passphrase file not found: $wrapped_file" >&2
    return 1
  fi

  stty -echo
  printf "Passphrase: " >&2
  read password
  stty echo
  printf "\n" >&2

  output=$(echo "$password" | ecryptfs-insert-wrapped-passphrase-into-keyring "$wrapped_file" - 2>&1)
  sig=$(echo "$output" | sed -n 's/.*\[\([^]]*\)\].*/\1/p')

  if [[ -z "$sig" ]]; then
    echo "Error: Could not extract signature" >&2
    return 1
  fi

  echo "$sig"
}

ecrfs-wp-mount() {
  local wrapped_file="$1"
  local encrypted_dir="$2"
  local mount_point="$3"
  local sig

  if [[ -z "$wrapped_file" ]] || [[ -z "$encrypted_dir" ]] || [[ -z "$mount_point" ]]; then
    echo "Usage: $0 <wrapped-passphrase-file> <encrypted-dir> <mount-point>" >&2
    return 1
  fi

  if [ ! -f "$wrapped_file" ]; then
    echo "Error: Wrapped passphrase file not found: $wrapped_file" >&2
    exit 1
  fi

  if [ ! -d "$encrypted_dir" ]; then
    mkdir -p "$encrypted_dir" || {
      echo "Error: Cannot create encrypted directory: $encrypted_dir" >&2
      return 1
    }
  fi

  if [ ! -d "$mount_point" ]; then
    mkdir -p "$mount_point" || {
      echo "Error: Cannot create mount point: $mount_point" >&2
      return 1
    }
  fi

  sig=$(ecrfs-wp-ins "$wrapped_file")

  if [[ -z "$sig" ]]; then
    return 1
  fi

  sudo mount -i -t ecryptfs "$encrypted_dir" "$mount_point" \
    -o "ecryptfs_sig=$sig,ecryptfs_cipher=aes,ecryptfs_key_bytes=32,ecryptfs_unlink_sigs"
}


ecrfs-wp-umount() {
  local mount_point="$1"

  if [[ -z "$mount_point" ]]; then
    echo "Usage: $0 <mount-point>" >&2
    return 1
  fi

  sudo umount "$mount_point"
}

ecrfs-wp-rewrap() {
  local wrapped_file="$1"

  if [[ -z "$wrapped_file" ]]; then
    echo "Usage: $0 <path-to-wrapped-passphrase-output>" >&2
    return 1
  fi

  ecryptfs-rewrap-passphrase "$wrapped_file"
}

# other
alias l="clear"
alias o="xdg-open"
alias ta="tmux attach || tmux"
alias jl="lazygit"
alias jd="lazydocker"
alias v="nvim"
alias k="kubectl"
