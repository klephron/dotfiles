DISTRO=$(cat /etc/*-release | grep ^NAME | cut -c 6- | tr -d '"')
HAS_APT= $([[ -z "$(command -v apt)" ]] && echo 0 || echo 1)
HAS_CURL=$([[ -z "$(command -v curl)" ]] && echo 0 || echo 1)
ARCH=x86_64

if [ "$HAS_APT" -eq "0" ]; then
  echo "warn: not installing. \`apt\` is not present"
  exit 0
fi

if [ "$HAS_CURL" -eq "0" ]; then
  echo "warn: not installing. \`curl\` is not present"
  exit 0
fi

echo "TODO: not finished"

# curl -s https://github.com/MordechaiHadad/bob/releases/latest \
# | grep "box-linux-$ARCH.zip" \
# | cut -d : -f 2,3 \
# | tr -d \" \
# | wget -qi -
