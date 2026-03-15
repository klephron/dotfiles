#!/usr/bin/env bash

set -euo pipefail

if ! command -v xdg-user-dirs-update >/dev/null 2>&1; then
  echo "command xdg-user-dirs-update does not exist"
  exit 1
fi

if [[ -v XDG_DESKTOP_DIR ]]; then
  mkdir -p "$XDG_DESKTOP_DIR"
  xdg-user-dirs-update --set DESKTOP "$XDG_DESKTOP_DIR"
fi

if [[ -v XDG_DOCUMENTS_DIR ]]; then
  mkdir -p "$XDG_DOCUMENTS_DIR"
  xdg-user-dirs-update --set DOCUMENTS "$XDG_DOCUMENTS_DIR"
fi

if [[ -v XDG_DOWNLOAD_DIR ]]; then
  mkdir -p "$XDG_DOWNLOAD_DIR"
  xdg-user-dirs-update --set DOWNLOAD "$XDG_DOWNLOAD_DIR"
fi

if [[ -v XDG_MUSIC_DIR ]]; then
  mkdir -p "$XDG_MUSIC_DIR"
  xdg-user-dirs-update --set MUSIC "$XDG_MUSIC_DIR"
fi

if [[ -v XDG_PICTURES_DIR ]]; then
  mkdir -p "$XDG_PICTURES_DIR"
  xdg-user-dirs-update --set PICTURES "$XDG_PICTURES_DIR"
fi

if [[ -v XDG_PUBLICSHARE_DIR ]]; then
  mkdir -p "$XDG_PUBLICSHARE_DIR"
  xdg-user-dirs-update --set PUBLICSHARE "$XDG_PUBLICSHARE_DIR"
fi

if [[ -v XDG_TEMPLATES_DIR ]]; then
  mkdir -p "$XDG_TEMPLATES_DIR"
  xdg-user-dirs-update --set TEMPLATES "$XDG_TEMPLATES_DIR"
fi

if [[ -v XDG_VIDEOS_DIR ]]; then
  mkdir -p "$XDG_VIDEOS_DIR"
  xdg-user-dirs-update --set VIDEOS "$XDG_VIDEOS_DIR"
fi

xdg-user-dirs-update
