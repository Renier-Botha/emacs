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

;; Show added/removed/modified line markers in the fringe, updated live
;; against the current git HEAD (i.e. relative to your current branch).
(use-package diff-hl
  :demand t
  :config
  (global-diff-hl-mode 1)
  ;; Refresh the markers after Magit operations (commit, stage, etc.)
  ;; since those don't otherwise trigger `after-save-hook'.
  (add-hook 'magit-pre-refresh-hook #'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh))

(provide 'init-magit)
;;; init-magit.el ends here
