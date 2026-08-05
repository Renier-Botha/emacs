;;; init-langs.el --- Classic major modes so tree-sitter can remap them -*- lexical-binding: t; -*-

;;; Commentary:
;; `treesit-auto' (see `init-treesit.el') only *remaps* an existing
;; classic major mode to its `-ts-mode' counterpart (e.g. `rust-mode'
;; -> `rust-ts-mode'). Emacs core doesn't ship a classic `rust-mode',
;; `go-mode', or `typescript-mode', so without installing these
;; packages, `.rs'/`.go'/`.ts' files have no major mode association at
;; all (they'd fall back to `fundamental-mode') -- there's nothing for
;; treesit-auto to remap. Installing these small packages gives us:
;;   1. the `auto-mode-alist' entries and a working major mode even
;;      when no tree-sitter grammar is installed yet, and
;;   2. something for `treesit-auto' to automatically upgrade to the
;;      `-ts-mode' version once the grammar is available.
;;
;; `svelte-mode' has no tree-sitter equivalent in Emacs yet, so it's
;; just a plain (web-mode based) major mode.

;;; Code:

(use-package rust-mode
  :mode "\\.rs\\'")

(use-package go-mode
  :mode "\\.go\\'")

(use-package typescript-mode
  :mode ("\\.ts\\'" . typescript-mode))

(use-package svelte-mode
  :mode "\\.svelte\\'")

(provide 'init-langs)
;;; init-langs.el ends here
