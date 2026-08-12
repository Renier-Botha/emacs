;;; init-dired-sidebar.el --- Project file-tree sidebar -*- lexical-binding: t; -*-

;;; Commentary:
;; - dired-sidebar: a persistent Dired-based file tree in a side window,
;;   so you can see the project layout without opening every file.

;;; Code:

(use-package dired-sidebar
  :bind ("C-c t" . dired-sidebar-toggle-sidebar)
  :commands (dired-sidebar-toggle-sidebar)
  :custom
  (dired-sidebar-should-follow-file t)
  (dired-sidebar-use-term-integration t)
  (dired-sidebar-width 30)
  :config
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode)))))

(provide 'init-dired-sidebar)
;;; init-dired-sidebar.el ends here
