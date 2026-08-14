;;; init-magit.el --- Magit setup -*- lexical-binding: t; -*-

;;; Code:

(use-package magit
  :bind (("C-x g" . magit-status))
  :config
  (setq magit-diff-refine-hunk 'all
        magit-save-repository-buffers 'dontask))

(use-package diff-hl
  :demand t
  :config
  (global-diff-hl-mode 1)
  (add-hook 'magit-pre-refresh-hook #'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh)
  (add-hook 'dired-mode-hook #'diff-hl-dired-mode))

(provide 'init-magit)
;;; init-magit.el ends here
