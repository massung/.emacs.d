#!/bin/env sh

# download emacs plugins/repositories
git clone https://github.com/company-mode/company-mode
git clone https://github.com/magnars/dash.el
git clone https://github.com/syohex/emacs-git-gutter
git clone https://github.com/rejeep/f.el
git clone https://github.com/flycheck/flycheck
git clone https://github.com/auto-complete/popup-el
git clone https://github.com/magnars/s.el
git clone https://github.com/slime/slime
git clone https://github.com/anwyn/slime-company
git clone https://github.com/jrblevin/markdown-mode

# get color themese
git clone https://github.com/dracula/emacs dracula-theme
git clone https://github.com/jonathanchu/atom-one-dark-theme

# copy the .emacs file to HOME
cp .emacs $HOME/.emacs
