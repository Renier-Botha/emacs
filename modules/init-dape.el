;;; init-dape.el --- Debugging via dape (DAP client) -*- lexical-binding: t; -*-

;;; Code:

(use-package dape
  :config
  ;; Save breakpoints between sessions.
  (setq dape-breakpoint-global-mode t)
  ;; Show useful info panels automatically when a debug session starts.
  (add-hook 'dape-start-hook
            (lambda ()
              (dape-info)
              (dape-repl)))

  ;; --- Rust support via gdb's native DAP mode (gdb >= 14.1) ---
  ;; dape ships an `lldb-dap' config for Rust, but that needs the LLVM
  ;; `lldb-dap' binary. We only have gdb installed, and it has no
  ;; built-in Rust template, so define one that builds with `cargo
  ;; build' and locates the resulting debug binary automatically.

  (defun my/dape--gdb-ensure-14 (config)
    "Ensure gdb's DAP support (gdb >= 14.1) is available for CONFIG."
    (dape-ensure-command config)
    (let* ((default-directory
            (or (dape-config-get config 'command-cwd) default-directory))
           (command (dape-config-get config 'command))
           (output (shell-command-to-string (format "%s --version" command)))
           (version (save-match-data
                      (when (string-match "GNU gdb \\(?:(.*) \\)?\\([0-9.]+\\)" output)
                        (string-to-number (match-string 1 output))))))
      (unless (and version (>= version 14.1))
        (user-error "Requires gdb version >= 14.1"))))

  (defun my/dape-rust-cargo-root ()
    "Find the nearest Cargo.toml directory for the current buffer."
    (or (locate-dominating-file default-directory "Cargo.toml")
        (user-error "No Cargo.toml found above %s" default-directory)))

  (defun my/dape-rust-crate-name ()
    "Best-effort parse of the package name from the nearest Cargo.toml."
    (let* ((root (my/dape-rust-cargo-root))
           (toml (expand-file-name "Cargo.toml" root)))
      (with-temp-buffer
        (insert-file-contents toml)
        (if (re-search-forward "^name[ \t]*=[ \t]*\"\\([^\"]+\\)\"" nil t)
            (match-string 1)
          (user-error "Could not find `name' in %s" toml)))))

  (defun my/dape-rust-debug-binary ()
    "Path to the debug binary built by `cargo build' for the current crate."
    (expand-file-name (concat "target/debug/" (my/dape-rust-crate-name))
                       (my/dape-rust-cargo-root)))

  ;; gdb's own DAP traffic to Emacs runs over gdb's regular stdio pipe,
  ;; which is *not* a real terminal -- so a debuggee that reads stdin
  ;; (e.g. `std::io::stdin().read_line') has nowhere to read from and
  ;; just hangs. The fix is `set inferior-tty', which tells gdb to
  ;; connect the *inferior's* stdio to a separate real pty, decoupled
  ;; from gdb's own DAP channel. We provide that pty via a dedicated
  ;; `term-mode' buffer that you can type into/read output from like a
  ;; normal terminal.
  (defvar my/dape-rust-tty-buffer-name "*rust-debuggee-tty*")

  (defun my/dape-rust-ensure-tty ()
    "Ensure a live terminal buffer to host a Rust debuggee's stdio.
Returns the pty device path (e.g. \"/dev/pts/7\") backing that buffer,
creating the buffer/shell if necessary."
    (let* ((buf (get-buffer my/dape-rust-tty-buffer-name))
           (proc (and buf (get-buffer-process buf))))
      (unless (process-live-p proc)
        ;; Deliberately NOT an interactive shell: an interactive shell
        ;; would race the debuggee for reads on the same pty (stealing
        ;; keystrokes meant for the program). `sleep infinity' just
        ;; holds the pty open without ever reading from it, so once
        ;; gdb points the inferior at this tty, the inferior is the
        ;; only thing actually consuming input from it.
        (setq buf (make-term "rust-debuggee-tty" "sh" nil "-c" "exec sleep infinity"))
        (with-current-buffer buf
          (term-mode)
          (term-char-mode))
        (setq proc (get-buffer-process buf)))
      (display-buffer buf)
      (process-tty-name proc)))

  (add-to-list 'dape-configs
               `(rust-gdb
                 modes (rust-mode rust-ts-mode)
                 ensure my/dape--gdb-ensure-14
                 command "gdb"
                 command-args (lambda ()
                                 (list "--interpreter=dap" "-iex"
                                       (format "set inferior-tty %s"
                                               (my/dape-rust-ensure-tty))))
                 command-cwd my/dape-rust-cargo-root
                 compile "cargo build"
                 :request "launch"
                 :program my/dape-rust-debug-binary
                 :cwd my/dape-rust-cargo-root
                 :args []
                 :stopAtBeginningOfMainSubprogram nil)))

(provide 'init-dape)
;;; init-dape.el ends here
