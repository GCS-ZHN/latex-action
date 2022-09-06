#!/bin/sh

set -e

root_file="$1"
working_directory="$2"
compiler="$3"
args="$4"
extra_system_packages="$5"
extra_font_packages="$6"

if [ -n "$extra_system_packages" ]; then
  apt-get update
  for pkg in $extra_system_packages; do
    echo "Install $pkg by apt"
    apt-get -y install "$pkg"
  done
fi

if [ -n "$working_directory" ]; then
  cd "$working_directory"
fi

if [ -n "$extra_font_packages" ]; then
  unzip "$extra_font_packages.zip" && \
  mv "$extra_font_packages" /usr/share/fonts/extra_fonts/ && \
  fc-cache -fv && \
  fc-list :lang=zh-cn | sort
fi

"$compiler" $args "$root_file"
