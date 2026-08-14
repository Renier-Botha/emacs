;;; early-init.el --- Early startup tweaks -*- lexical-binding: t; -*-

;;; Code:

(setq site-run-file nil)

(setq package-enable-at-startup nil)

(setq frame-inhibit-implied-resize t)

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

(defvar my/file-name-handler-alist-backup file-name-handler-alist)
(setq file-name-handler-alist nil)

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

(provide 'early-init)
;;; early-init.el ends here
