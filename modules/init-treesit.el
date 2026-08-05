;;; init-treesit.el --- Tree-sitter powered major modes -*- lexical-binding: t; -*-

;;; Commentary:
;; Emacs 29+ ships a native tree-sitter integration, and Emacs 29/30
;; include several `*-ts-mode' major modes (python-ts-mode, js-ts-mode,
;; etc.) that give much better syntax highlighting/indentation than the
;; classic modes -- but only once the matching grammar is compiled and
;; installed. `treesit-auto' automates fetching/building grammars and
;; remapping the classic modes to their `-ts-mode' equivalents.

;;; Code:

(use-package treesit-auto
  :demand t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (global-treesit-auto-mode))

(provide 'init-treesit)
;;; init-treesit.el ends here
