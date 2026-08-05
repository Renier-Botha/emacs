;;; init-eglot.el --- LSP support via the built-in Eglot client -*- lexical-binding: t; -*-

;;; Commentary:
;; Eglot ships with Emacs (29+) so this needs no extra package, just
;; configuration. It talks to whatever language server is installed
;; and on `exec-path'/$PATH for the current major mode
;; (e.g. pyright/pylsp for Python, clangd for C/C++, rust-analyzer for
;; Rust, gopls for Go, typescript-language-server for JS/TS, ...).
;;
;; Install the servers you need yourself, e.g.:
;;   npm i -g pyright typescript-language-server
;;   rustup component add rust-analyzer

;;; Code:

(use-package eglot
  :ensure nil ; built-in
  :hook ((python-mode      . eglot-ensure)
         (python-ts-mode   . eglot-ensure)
         (js-mode          . eglot-ensure)
         (js-ts-mode       . eglot-ensure)
         (typescript-ts-mode . eglot-ensure)
         (c-mode           . eglot-ensure)
         (c-ts-mode        . eglot-ensure)
         (c++-mode         . eglot-ensure)
         (c++-ts-mode      . eglot-ensure)
         (rust-ts-mode     . eglot-ensure)
         (go-mode          . eglot-ensure)
         (go-ts-mode       . eglot-ensure))
  :bind (:map eglot-mode-map
              ("C-c l r" . eglot-rename)
              ("C-c l a" . eglot-code-actions)
              ("C-c l f" . eglot-format))
  :config
  ;; Keep Eglot quiet and fast: don't report every event to the echo
  ;; area, and don't ask before shutting a server down.
  (setq eglot-autoshutdown t
        eglot-report-progress nil
        eglot-confirm-server-initiated-edits nil))

(provide 'init-eglot)
;;; init-eglot.el ends here
