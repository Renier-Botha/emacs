;;; init.el --- Minimal, fast-starting Emacs config -*- lexical-binding: t; -*-

;;; Code:

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024)
                  gc-cons-percentage 0.1
                  file-name-handler-alist my/file-name-handler-alist-backup)))

(require 'package)
(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("melpa"  . "https://melpa.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(setq package-quickstart nil)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t
      use-package-expand-minimally t)

(setq no-littering-etc-directory
      (expand-file-name "etc/" user-emacs-directory))
(setq no-littering-var-directory
      (expand-file-name "var/" user-emacs-directory))

(use-package no-littering
  :demand t
  :config
  (setq auto-save-file-name-transforms
        `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
  (setq backup-directory-alist
        `((".*" . ,(no-littering-expand-var-file-name "backup/"))))
  (setq custom-file (no-littering-expand-etc-file-name "custom.el"))
  (when (file-exists-p custom-file)
    (load custom-file 'noerror)))

(setq inhibit-startup-screen t
      initial-scratch-message nil
      ring-bell-function 'ignore
      use-short-answers t
      make-backup-files t
      create-lockfiles nil)

(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(column-number-mode 1)

(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))

(require 'init-magit)
(require 'init-prog)
(require 'init-completion)
(require 'init-minibuffer)
(require 'init-navigation)
(require 'init-multiple-cursors)
(require 'init-langs)
(require 'init-lisp)
(require 'init-treesit)
(require 'init-eglot)
(require 'init-keybindings)
(require 'init-clipboard)

(provide 'init)
;;; init.el ends here
