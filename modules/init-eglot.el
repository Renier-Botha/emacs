;;; init-eglot.el --- LSP support via Eglot, with auto-install of servers -*- lexical-binding: t; -*-

;;; Commentary:
;; Eglot ships with Emacs (29+), so it needs no extra package -- just
;; configuration. Unlike `lsp-mode', Eglot deliberately doesn't know how
;; to install language servers for you.
;;
;; This module adds a small, explicit auto-install layer: for each
;; major mode we care about, `my/lsp-server-specs' names one server
;; binary to look for and a shell command to install it if it's
;; missing. Before starting Eglot in a matching buffer, we check
;; `executable-find' for that binary; if it's absent, we ask for
;; confirmation and run the install command asynchronously in the
;; background, then start Eglot once it succeeds. If the binary is
;; already on PATH, Eglot starts immediately, using whatever server it
;; would normally pick (which may not even be the one we'd install --
;; that's fine, this layer only exists to bootstrap a *default*
;; server when there is none yet).
;;
;; This only covers the servers listed below -- add more entries as you
;; pick up new languages. It intentionally does NOT try to be a full
;; "mason.nvim"-style universal installer; that's `lsp-mode' territory
;; and comes with a lot more moving parts.

;;; Code:

(use-package eglot
  :ensure nil ; built-in
  :bind (:map eglot-mode-map
              ("C-c l r" . eglot-rename)
              ("C-c l a" . eglot-code-actions)
              ("C-c l f" . eglot-format))
  :config
  (setq eglot-autoshutdown t
        eglot-report-progress nil
        eglot-confirm-server-edits nil))

;; --- Auto-install helper ---------------------------------------------------

(defvar my/lsp-server-specs
  '((python-mode        :bin "pyright-langserver" :install ("pip" "install" "--user" "pyright"))
    (python-ts-mode     :bin "pyright-langserver" :install ("pip" "install" "--user" "pyright"))
    (js-mode            :bin "typescript-language-server" :install ("npm" "install" "-g" "typescript-language-server" "typescript"))
    (js-ts-mode         :bin "typescript-language-server" :install ("npm" "install" "-g" "typescript-language-server" "typescript"))
    (typescript-ts-mode :bin "typescript-language-server" :install ("npm" "install" "-g" "typescript-language-server" "typescript"))
    (rust-ts-mode       :bin "rust-analyzer" :install ("rustup" "component" "add" "rust-analyzer"))
    (go-mode            :bin "gopls" :install ("go" "install" "golang.org/x/tools/gopls@latest"))
    (go-ts-mode         :bin "gopls" :install ("go" "install" "golang.org/x/tools/gopls@latest")))
  "Per-major-mode LSP server bootstrap info: (MAJOR-MODE :bin EXE :install CMD).
EXE is the executable to look for on `PATH'; CMD is the shell command
(as a list of strings) used to install it if missing. `clangd' (C/C++)
is deliberately left out: it's normally best installed via your
system's package manager, e.g. `dnf install clang-tools-extra'.")

(defun my/eglot-maybe-install-and-ensure ()
  "Install this buffer's default LSP server if missing, then start Eglot."
  (let* ((spec (alist-get major-mode my/lsp-server-specs))
         (exe (plist-get spec :bin))
         (install-cmd (plist-get spec :install)))
    (cond
     ;; No spec for this mode: just let Eglot try its own defaults.
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
                          exe)))))))))))

(dolist (mode (mapcar #'car my/lsp-server-specs))
  (add-hook (intern (concat (symbol-name mode) "-hook"))
            #'my/eglot-maybe-install-and-ensure))

(provide 'init-eglot)
;;; init-eglot.el ends here
