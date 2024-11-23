#!/usr/bin/env bash
set -e

PACKAGES=(
    "https://github.com/magnars/dash.el"
    "https://github.com/rejeep/f.el"
    "https://github.com/magnars/s.el"
    "https://github.com/syohex/emacs-git-gutter"
    "https://github.com/jrblevin/markdown-mode"
    "https://github.com/milkypostman/powerline"
    "https://github.com/flycheck/flycheck"
    "https://github.com/company-mode/company-mode"
    "https://github.com/slime/slime"
    "https://github.com/ALSchwalm/janet-mode"
    "https://github.com/SerialDev/ijanet-mode"
    "https://gitlab.com/aimebertrand/timu-rouge-theme"
    "https://github.com/purcell/exec-path-from-shell"
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
