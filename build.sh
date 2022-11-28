#!/bin/bash

set -e

BUILD_DIR="/builder/build"
PACKAGES_DIR="/packages"
AUR_URL="https://aur.archlinux.org"

function main {
  init_pacman_keys
  build_aur_packages "$@"
}

function init_pacman_keys {
  pacman-key --init
}

function build_aur_packages {
  cd $BUILD_DIR

  for package in "$@"; do
    if su builder -c "git clone \"${AUR_URL}/${package}.git\""; then
      (
        cd "$package"

        su builder -c "makepkg --noconfirm -s"

        mv ./*.pkg.tar.zst $PACKAGES_DIR
      )
    else
      echo "Package '$package' doesn't exists. Skipping..." || continue
    fi
  done
}

main "$@"
