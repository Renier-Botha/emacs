;;; init-evil.el --- Vim-style modal editing -*- lexical-binding: t; -*-

;;; Commentary:
;; - evil: Vim emulation for Emacs, used only for normal file editing.
;;   Modes like Dired, Magit, and terminals are explicitly kept in Emacs
;;   state so they behave with their native (non-Vim) keybindings.
;; - which-key: pop-up hints for incomplete key sequences.
;; - general: convenient key-binding definer, used here to set up a
;;   SPC-prefixed leader key (like Vim/Doom/Spacemacs).

;;; Code:

(use-package evil
  :demand t
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-want-C-u-scroll t
        evil-want-C-i-jump nil
        evil-undo-system 'undo-redo
        evil-search-module 'evil-search)
  :config
  (evil-mode 1)

  ;; Keep Vim bindings for regular file editing only. Dired, Magit, and
  ;; terminal/shell modes use their own native keybindings (Emacs state).
  ;;
  ;; Evil follows each mode's `derived-mode-parent' chain, so setting the
  ;; state on a base/parent mode automatically covers everything derived
  ;; from it (e.g. `magit-mode' covers magit-status-mode, magit-log-mode,
  ;; magit-diff-mode, etc.; `comint-mode' covers shell-mode and friends).
  ;; Modes that aren't defined with `define-derived-mode' (e.g. minor
  ;; modes like `git-commit-mode', or modes that set `major-mode'
  ;; directly) still need to be listed explicitly.
  (dolist (mode '(dired-mode
                   magit-mode
                   git-commit-mode
                   comint-mode
                   term-mode
                   eshell-mode
                   vterm-mode))
    (evil-set-initial-state mode 'emacs))

  ;; `term-mode' uses `C-c' as its "escape to Emacs" prefix by default
  ;; (e.g. `C-c b' to switch buffers), which shadows the shell's own use
  ;; of `C-c' (e.g. SIGINT). Use `C-x' as the escape prefix instead, so
  ;; regular Emacs `C-x ...' commands work in the terminal and `C-c' is
  ;; passed straight through to the shell.
  (with-eval-after-load 'term
    (term-set-escape-char ?\C-x)))

(use-package which-key
  :demand t
  :config
  (which-key-mode 1))

(use-package general
  :after evil
  :demand t
  :config
  (general-create-definer my/leader-def
    :states '(normal visual motion emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")

  (defun my/open-terminal-below ()
    "Open a terminal in a horizontal split below the current window."
    (interactive)
    (split-window-below)
    (other-window 1)
    (term (or explicit-shell-file-name (getenv "SHELL") "/bin/sh")))

  (my/leader-def
    "o" '(:ignore t :which-key "open")
    "ot" '(my/open-terminal-below :which-key "terminal below")

    "b" '(:ignore t :which-key "buffer")
    "bb" '(consult-buffer :which-key "switch buffer")
    "bd" '(kill-current-buffer :which-key "kill buffer")

    "f" '(:ignore t :which-key "file")
    "ff" '(find-file :which-key "find file")
    "fs" '(save-buffer :which-key "save file")

    "g" '(:ignore t :which-key "git")
    "gs" '(magit-status :which-key "status")

    "c" '(:ignore t :which-key "code")
    "cd" '(xref-find-definitions :which-key "find definitions")
    "cr" '(xref-find-references :which-key "find references")
    "ca" '(eglot-code-actions :which-key "code actions")
    "cn" '(eglot-rename :which-key "rename")
    "cf" '(eglot-format :which-key "format")

    "p" '(:ignore t :which-key "project")
    "pf" '(project-find-file :which-key "find file in project")

    "s" '(:ignore t :which-key "search")
    "sl" '(consult-line :which-key "search line")
    "sg" '(consult-ripgrep :which-key "ripgrep")))

(provide 'init-evil)
;;; init-evil.el ends here
