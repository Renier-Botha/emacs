;;; init-dired-sidebar.el --- Project file-tree sidebar -*- lexical-binding: t; -*-

;;; Commentary:
;; - dired-sidebar: a persistent Dired-based file tree in a side window,
;;   so you can see the project layout without opening every file.
;; - dired-subtree: lets dired-sidebar expand/collapse directories
;;   in-place (TAB) instead of replacing the buffer with a new listing,
;;   which is also what keeps the tree state stable when "follow file"
;;   jumps to the file you have open elsewhere.

;;; Code:

(use-package dired-subtree
  :after dired)

(use-package dired-sidebar
  :after dired-subtree
  :bind ("C-c t" . dired-sidebar-toggle-sidebar)
  :commands (dired-sidebar-toggle-sidebar)
  :custom
  (dired-sidebar-should-follow-file t)
  (dired-sidebar-use-term-integration t)
  (dired-sidebar-width 30)
  (dired-sidebar-want-subtree t)
  (dired-sidebar-follow-file-at-point-on-toggle-open t)
  :config
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode)))))

(provide 'init-dired-sidebar)
;;; init-dired-sidebar.el ends here
