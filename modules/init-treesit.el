;;; init-treesit.el --- Tree-sitter powered major modes -*- lexical-binding: t; -*-

;;; Code:

(use-package treesit-auto
  :demand t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (global-treesit-auto-mode))

(provide 'init-treesit)
;;; init-treesit.el ends here
