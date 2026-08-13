;;; init.el --- Minimal, fast-starting Emacs config -*- lexical-binding: t; -*-

;;; Commentary:
;; Minimal config focused on fast startup.
;; - Package management via package.el + use-package.
;; - `no-littering' keeps all Emacs-generated files under `.emacs.d/var'.
;; - Extra config lives in per-topic files under `modules/'.

;;; Code:

;; --- Restore sane GC/file-handler settings after startup ----------------

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024)
                  gc-cons-percentage 0.1
                  file-name-handler-alist my/file-name-handler-alist-backup)))

;; --- Package management ---------------------------------------------------

(require 'package)
(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("melpa"  . "https://melpa.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
;; Don't hit the network on every startup; run `package-refresh-contents'
;; manually (M-x package-refresh-contents) when you need to update.
(setq package-quickstart nil)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t
      use-package-expand-minimally t)

;; --- no-littering: keep .emacs.d clean, put generated files in var/ -----

;; no-littering expects these two variables set *before* it is loaded so
;; it knows where to put things.
(setq no-littering-etc-directory
      (expand-file-name "etc/" user-emacs-directory))
(setq no-littering-var-directory
      (expand-file-name "var/" user-emacs-directory))

(use-package no-littering
  :demand t
  :config
  ;; Keep auto-save files, backups, etc. out of the way too.
  (setq auto-save-file-name-transforms
        `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
  (setq backup-directory-alist
        `((".*" . ,(no-littering-expand-var-file-name "backup/"))))
  (setq custom-file (no-littering-expand-etc-file-name "custom.el"))
  (when (file-exists-p custom-file)
    (load custom-file 'noerror)))

;; --- Basic sane defaults --------------------------------------------------

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

;; --- Load modules -----------------------------------------------------------

(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))

(require 'init-magit)
(require 'init-prog)
(require 'init-completion)
(require 'init-minibuffer)
(require 'init-navigation)
(require 'init-multiple-cursors)
(require 'init-langs)
(require 'init-treesit)
(require 'init-eglot)
(require 'init-keybindings)
(require 'init-clipboard)

(provide 'init)
;;; init.el ends here
