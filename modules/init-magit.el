;;; init-magit.el --- Magit setup -*- lexical-binding: t; -*-

;;; Commentary:
;; Minimal Magit configuration, loaded from init.el.

;;; Code:

(use-package magit
  :bind (("C-x g" . magit-status))
  :config
  ;; Don't clutter the frame with a separate window for the diff/status;
  ;; keep Magit fast and simple.
  (setq magit-diff-refine-hunk 'all
        magit-save-repository-buffers 'dontask))

(provide 'init-magit)
;;; init-magit.el ends here
