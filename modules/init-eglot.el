;;; init-eglot.el --- LSP support via Eglot, with auto-install of servers -*- lexical-binding: t; -*-

;;; Code:

(use-package eglot
  :ensure nil
  :bind (:map eglot-mode-map
              ("C-c l r" . eglot-rename)
              ("C-c l a" . eglot-code-actions)
              ("C-c l f" . eglot-format))
  :config
  (setq eglot-autoshutdown t
        eglot-report-progress nil
        eglot-confirm-server-edits nil)
  (add-to-list 'eglot-server-programs
               '(svelte-mode . ("svelteserver" "--stdio"))))

(defvar my/lsp-server-specs
  '((python-mode        :bin "pyright-langserver" :install ("pip" "install" "--user" "pyright"))
    (python-ts-mode     :bin "pyright-langserver" :install ("pip" "install" "--user" "pyright"))
    (js-mode            :bin "typescript-language-server" :install ("npm" "install" "-g" "typescript-language-server" "typescript"))
    (js-ts-mode         :bin "typescript-language-server" :install ("npm" "install" "-g" "typescript-language-server" "typescript"))
    (typescript-mode    :bin "typescript-language-server" :install ("npm" "install" "-g" "typescript-language-server" "typescript"))
    (typescript-ts-mode :bin "typescript-language-server" :install ("npm" "install" "-g" "typescript-language-server" "typescript"))
    (rust-mode          :bin "rust-analyzer" :install ("rustup" "component" "add" "rust-analyzer"))
    (rust-ts-mode       :bin "rust-analyzer" :install ("rustup" "component" "add" "rust-analyzer"))
    (go-mode            :bin "gopls" :install ("go" "install" "golang.org/x/tools/gopls@latest"))
    (go-ts-mode         :bin "gopls" :install ("go" "install" "golang.org/x/tools/gopls@latest"))
    (svelte-mode        :bin "svelteserver" :install ("npm" "install" "-g" "svelte-language-server"))
    (clojure-mode        :bin "clojure-lsp" :install ("bash" "-c" "curl -sL https://raw.githubusercontent.com/clojure-lsp/clojure-lsp/master/install | bash -s -- --dir ~/.local/bin"))
    (clojurescript-mode  :bin "clojure-lsp" :install ("bash" "-c" "curl -sL https://raw.githubusercontent.com/clojure-lsp/clojure-lsp/master/install | bash -s -- --dir ~/.local/bin"))
    (clojurec-mode       :bin "clojure-lsp" :install ("bash" "-c" "curl -sL https://raw.githubusercontent.com/clojure-lsp/clojure-lsp/master/install | bash -s -- --dir ~/.local/bin"))
    (clojure-ts-mode     :bin "clojure-lsp" :install ("bash" "-c" "curl -sL https://raw.githubusercontent.com/clojure-lsp/clojure-lsp/master/install | bash -s -- --dir ~/.local/bin")))
  "Per-major-mode LSP server bootstrap info: (MAJOR-MODE :bin EXE :install CMD).")

(defun my/eglot-maybe-install-and-ensure ()
  "Install this buffer's default LSP server if missing, then start Eglot."
  (with-demoted-errors "Eglot auto-install: %S"
    (let* ((spec (alist-get major-mode my/lsp-server-specs))
           (exe (plist-get spec :bin))
           (install-cmd (plist-get spec :install)))
      (cond
       ((not spec) (eglot-ensure))
       ((executable-find exe) (eglot-ensure))
       (t
        (when (y-or-n-p (format "Language server `%s' not found. Install now via `%s'? "
                                 exe (string-join install-cmd " ")))
          (let ((buf (current-buffer))
                (out (get-buffer-create "*lsp-install*")))
            (message "Installing %s ..." exe)
            (make-process
             :name (format "lsp-install-%s" exe)
             :buffer out
             :command install-cmd
             :sentinel
             (lambda (proc _event)
               (when (memq (process-status proc) '(exit signal))
                 (if (zerop (process-exit-status proc))
                     (progn
                       (message "Installed %s successfully." exe)
                       (when (buffer-live-p buf)
                         (with-current-buffer buf (eglot-ensure))))
                   (message "Failed to install %s -- see the *lsp-install* buffer for details."
                            exe))))))))))))

(dolist (mode (mapcar #'car my/lsp-server-specs))
  (add-hook (intern (concat (symbol-name mode) "-hook"))
            #'my/eglot-maybe-install-and-ensure))

(provide 'init-eglot)
;;; init-eglot.el ends here
