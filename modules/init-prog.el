;;; init-prog.el --- Generic programming defaults -*- lexical-binding: t; -*-

;;; Commentary:
;; Small, dependency-free QoL settings that apply to every `prog-mode'
;; derived buffer (i.e. basically any programming language buffer).

;;; Code:

(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'prog-mode-hook #'electric-pair-mode)

(show-paren-mode 1)
(setq show-paren-delay 0)

;; Indentation: spaces, not tabs, by default. Language modes can still
;; override this locally.
(setq-default indent-tabs-mode nil
              tab-width 4)

;; Highlight matching syntax in a subtler way and trim trailing
;; whitespace only in the lines we touch, not the whole buffer.
(add-hook 'before-save-hook #'delete-trailing-whitespace)

(provide 'init-prog)
;;; init-prog.el ends here
