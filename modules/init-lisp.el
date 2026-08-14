;;; init-lisp.el --- Common Lisp support via SLY -*- lexical-binding: t; -*-

;;; Code:

(use-package sly
  :commands (sly sly-connect)
  :init
  (setq inferior-lisp-program "sbcl"))

(provide 'init-lisp)
;;; init-lisp.el ends here
