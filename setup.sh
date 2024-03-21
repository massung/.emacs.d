#!/usr/bin/env bash
set -e

PACKAGES=(
    "https://github.com/syohex/emacs-git-gutter"
    "https://github.com/jrblevin/markdown-mode"
    "https://github.com/milkypostman/powerline"
    "https://github.com/slime/slime"
    "https://gitlab.com/aimebertrand/timu-rouge-theme"
)

# create the packages subdirectory if needed
mkdir -p p

# test for each package already existing
for PKG in "${PACKAGES[@]}"; do
    name="$(basename $PKG)"
    dir="p/$name"

    if [ ! -d "$dir" ]; then
  echo "Cloning $name..."
  git clone -q "$PKG" "$dir"
    fi
done
