(add-to-list 'load-path "~/.emacs.d/p/dash.el")
(add-to-list 'load-path "~/.emacs.d/p/f.el")
(add-to-list 'load-path "~/.emacs.d/p/s.el")
(add-to-list 'load-path "~/.emacs.d/p/emacs-git-gutter")
(add-to-list 'load-path "~/.emacs.d/p/markdown-mode")
(add-to-list 'load-path "~/.emacs.d/p/powerline")
(add-to-list 'load-path "~/.emacs.d/p/flycheck")
(add-to-list 'load-path "~/.emacs.d/p/company-mode")
(add-to-list 'load-path "~/.emacs.d/p/slime")
(add-to-list 'load-path "~/.emacs.d/p/janet-mode")
(add-to-list 'load-path "~/.emacs.d/p/ijanet-mode")
(add-to-list 'load-path "~/.emacs.d/p/timu-rouge-theme")
(add-to-list 'load-path "~/.emacs.d/p/exec-path-from-shell")

(require 'dash)
(require 'f)
(require 's)
(require 'git-gutter)
(require 'markdown-mode)
(require 'powerline)
(require 'flycheck)
(require 'company)
(require 'slime-autoloads)
(require 'janet-mode)
(require 'ijanet)
(require 'timu-rouge-theme)
(require 'exec-path-from-shell)

;; theme
(powerline-default-theme)
(load-theme 'timu-rouge t)

;; specify environment variables to keep
(dolist (var '("DYLD_LIBRARY_PATH"))
  (add-to-list 'exec-path-from-shell-variables var))

;; load environment variables
(exec-path-from-shell-initialize)

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
;(setq inferior-lisp-program "sbcl")
(setq inferior-lisp-program
      "/Applications/AllegroCL64express.app/Contents/Resources/alisp")

;; use command key as meta
(setq mac-command-modifier 'meta)

;; don't show the startup screen
(setq inhibit-startup-screen t)

;; disable autosave and creation of backup files
(setq auto-save-default nil)
(setq auto-save-list-file-prefix nil)
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
