#!/bin/bash

set -e

BUILD_DIR="/builder/build"
PACKAGES_DIR="/packages"

function main {
  init_pacman_keys_and_update
  install_necessary_packages
  create_rootless_user
  create_needed_folders
  own_folders_for_rootles_user
  strip_pacman_keys
}

function init_pacman_keys_and_update {
  pacman-key --init && pacman --noconfirm -Syu
}

function install_necessary_packages {
  pacman --noconfirm -S git
}

function create_rootless_user {
  useradd -M builder
}

function create_needed_folders {
  mkdir -p $BUILD_DIR $PACKAGES_DIR
}

function own_folders_for_rootles_user {
  chown -R builder $BUILD_DIR $PACKAGES_DIR
}

function strip_pacman_keys {
  rm -rf /etc/pacman.d/gnupg/{openpgp-revocs.d/,private-keys-v1.d/,pubring.gpg~,gnupg.S.}*
}

main
