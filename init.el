(add-to-list 'load-path "~/.emacs.d/p/emacs-git-gutter")
(add-to-list 'load-path "~/.emacs.d/p/powerline")
(add-to-list 'load-path "~/.emacs.d/p/slime")
(add-to-list 'load-path "~/.emacs.d/p/timu-rouge-theme")

(require 'git-gutter)
(require 'powerline)
(require 'slime-autoloads)
(require 'timu-rouge-theme)

;; theme
(powerline-default-theme)
(load-theme 'timu-rouge t)

;; git gutter
(global-git-gutter-mode +1)

;; git gutter symbols, just use whitespace
(custom-set-variables
 '(git-gutter:added-sign " ")
 '(git-gutter:deleted-sign " ")
 '(git-gutter:modified-sign " "))

;; git gutter colors
(set-face-background 'git-gutter:added "green")
(set-face-background 'git-gutter:modified "purple")
(set-face-background 'git-gutter:deleted "red")

;; setup slime
(setq inferior-lisp-program "sbcl")

;; use command key as meta
(setq mac-command-modifier 'meta)

;; don't show the startup screen
(setq inhibit-startup-screen t)

;; disable autosave and creation of backup files
(setq auto-save-list-file-prefix nil)
(setq auto-save-default nil)
(setq backup-inhibited t)

;; use spaces for everything
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; enable word wrap
(setq-default truncate-lines nil)

;; window size
(setq default-frame-alist '((height . 62) (width . 100)))

;; setup whitespace
(setq whitespace-style '(lines-tail trailing))
(setq whitespace-line-column 72)

;; font
(set-frame-font "PT Mono 14" nil t)

;; random options
(display-line-numbers-mode t)
(tool-bar-mode -1)
(global-whitespace-mode t)
(show-paren-mode t)
;(tab-bar-mode)
;(scroll-bar-mode)

;; save hooks
(add-hook 'before-save-hook (lambda ()
                              (unless (eq major-mode 'fundamental-mode)
                                (delete-trailing-whitespace))

                              ;; convert tabs to spaces
                              (unless indent-tabs-mode
                                (untabify (point-min) (point-max)))))

;; if indent mode for lisp should be like Lispworks
(defun setup-lisp-indentation ()
  (load-library "cl-indent")
  (put 'if 'common-lisp-indent-function '(nil nil &body)))

(add-hook 'lisp-mode-hook 'setup-lisp-indentation)
(add-hook 'lisp-interaction-mode-hook 'setup-lisp-indentation)
