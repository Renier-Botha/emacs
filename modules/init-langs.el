;;; init-langs.el --- Classic major modes so tree-sitter can remap them -*- lexical-binding: t; -*-

;;; Code:

(use-package rust-mode
  :mode "\\.rs\\'")

(use-package go-mode
  :mode "\\.go\\'")

(use-package typescript-mode
  :mode ("\\.ts\\'" . typescript-mode))

(use-package svelte-mode
  :mode "\\.svelte\\'")

(use-package clojure-mode
  :mode (("\\.clj\\'" . clojure-mode)
         ("\\.cljs\\'" . clojurescript-mode)
         ("\\.cljc\\'" . clojurec-mode)))

(provide 'init-langs)
;;; init-langs.el ends here
