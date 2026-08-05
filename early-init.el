;;; early-init.el --- Early startup tweaks -*- lexical-binding: t; -*-

;; This runs before init.el and before package.el/UI init, so it's the
;; right place to disable things that slow down startup.

;; Don't load site-wide startup files, they're mostly irrelevant here.
(setq site-run-file nil)

;; Skip the default package.el initialization; init.el does it explicitly
;; (and only once) via `package-initialize'.
(setq package-enable-at-startup nil)

;; Avoid resizing the frame each time we change fonts, themes, etc.
(setq frame-inhibit-implied-resize t)

;; Bump the GC threshold way up during startup, then restore a saner
;; value once we're done (see bottom of init.el).
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; Reduce noise/work from file-name-handler-alist during startup.
(defvar my/file-name-handler-alist-backup file-name-handler-alist)
(setq file-name-handler-alist nil)

;; Keep the UI minimal from the very start to avoid flashing
;; menu/tool/scroll bars before `custom.el' or init.el disable them.
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

(provide 'early-init)
;;; early-init.el ends here
