(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/dash.el")
(add-to-list 'load-path "~/.emacs.d/s.el")
(add-to-list 'load-path "~/.emacs.d/f.el")
(add-to-list 'load-path "~/.emacs.d/popup-el")
(add-to-list 'load-path "~/.emacs.d/spinner.el")
(add-to-list 'load-path "~/.emacs.d/emacs-git-gutter")
(add-to-list 'load-path "~/.emacs.d/company-mode")
(add-to-list 'load-path "~/.emacs.d/flycheck")
(add-to-list 'load-path "~/.emacs.d/slime")
(add-to-list 'load-path "~/.emacs.d/slime-company")

;; add theme paths
(add-to-list 'custom-theme-load-path "~/.emacs.d/atom-one-dark-theme/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/dracula-theme/")

;; auto-load various programming packages
(require 'let-alist)
(require 'dash)
(require 's)
(require 'f)
(require 'popup)
(require 'company)
(require 'git-gutter)
(require 'slime-autoloads)
(require 'slime)
(require 'slime-fuzzy)
(require 'slime-company)

;; load packages based on version
(when (and (>= emacs-major-version 24)
           (>= emacs-minor-version  4))
  (require 'flycheck)

  ;; add flycheck to all buffers
  (add-hook 'after-init-hook 'global-flycheck-mode))

;; enable git-gutter-mode all the time
(global-git-gutter-mode +1)

;; git gutter symbols, just use whitespace
(custom-set-variables
 '(git-gutter:added-sign " ")
 '(git-gutter:deleted-sign " ")
 '(git-gutter:modified-sign " "))

;; set the background color for git modifications
(set-face-background 'git-gutter:added "green")
(set-face-background 'git-gutter:modified "purple")
(set-face-background 'git-gutter:deleted "red")

;; update the git status of all windows
(global-set-key "\C-cg" 'git-gutter:update-all-windows)

;; add company mode to all buffers
(add-hook 'after-init-hook 'global-company-mode)

;; company mode should try and auto complete soon
(setq company-idle-delay 0.2)

;; create some company-mode key bindings
(define-key company-active-map (kbd "\C-n") 'company-select-next)
(define-key company-active-map (kbd "\C-p") 'company-select-previous)
(define-key company-active-map (kbd "\C-d") 'company-show-doc-buffer)
(define-key company-active-map (kbd "<tab>") 'company-complete)

;; auto-enter d-mode for .d files
(add-to-list 'auto-mode-alist '("\\.d[i]?\\'" . d-mode))

;; set lisp program to use by platform
(setq inferior-lisp-program "sbcl")

;; setup minor modes for slime
(slime-setup '(slime-fancy slime-company))

;; create a key for looking up a symbol in the hyperspec
(add-hook 'lisp-mode-hook
          (lambda ()
            (global-set-key "\C-ch" 'slime-hyperspec-lookup)
            (global-set-key "\C-ci" 'slime-inspect)))

;; set the color theme
(load-theme 'dracula t)

;; change the default window size
(add-to-list 'default-frame-alist '(width . 88))
(add-to-list 'default-frame-alist '(height . 40))

;; immediately split the window vertically
;(split-window-right)

;; change the default font based on the platform
(set-default-font
 (cond ((string= system-type "windows-nt") "InputMonoCondensed-11")
       ((string= system-type "darwin") "Monaco-11")
       ((string= system-type "gnu/linux") "Anonymous Pro-11")))

;; don't show the GNU emacs startup buffers
(setq inhibit-startup-screen t)
(setq inhibit-splash-screen t)

;; let the active buffer follow the mouse
(setq mouse-autoselect-window t)

;; disable scroll acceleration, and scroll what's under the mouse
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse t)

;; keyboard scroll one line at a time
(setq scroll-step 1)

;; disable backups and auto-saving
(setq-default backup-inhibited t)
(setq-default auto-save-default nil)

;; setup whitespace options
(setq whitespace-style '(lines-tail trailing))
(setq whitespace-line-column 72)

;; use spaces for everything
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; when tramped to another site, don't forget password
(setq-default password-cache-expiry nil)

;; enable line wrap
(setq-default truncate-lines nil)

;; always follow symbolic links
(setq vc-follow-symlinks t)

;; always show matching parens
(show-paren-mode t)

;; turn on display of the mark
(transient-mark-mode t)

;; turn on whitespace mode globally
(global-whitespace-mode t)

;; show the menubar, hide scrollbar, and toolbar
(menu-bar-mode 1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; use utf-8 encoding and unix line endings
(setq buffer-file-coding-system 'utf-8-unix)

;; use the command key as the meta key
(setq-default mac-command-modifier 'meta)

;; when entering org mode, wrap lines
(add-hook 'org-mode-hook 'visual-line-mode)

;; remove trailing whitespace when saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; if indent-tabs-mode is off, untabify before saving
(add-hook 'before-save-hook
          (lambda () (if (not indent-tabs-mode)
                         (untabify (point-min)
                                   (point-max)))))

;; the delete key should delete forward
(global-set-key (kbd "<kp-delete>") 'delete-char)

;; setup common lisp indentation settings
(defun setup-lisp-indentation ()
  (load-library "cl-indent") ; must load first or will override
  (put 'if 'common-lisp-indent-function '(nil nil &body)))

;; if statements in lisp should be indented like elisp
(add-hook 'lisp-mode-hook 'setup-lisp-indentation)
(add-hook 'lisp-interaction-mode-hook 'setup-lisp-indentation)
