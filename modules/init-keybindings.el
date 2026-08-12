;;; init-keybindings.el --- Leader-key bindings (no Vim emulation) -*- lexical-binding: t; -*-

;;; Commentary:
;; - which-key: pop-up hints for incomplete key sequences.
;; - general: convenient key-binding definer, used here to set up a
;;   `C-c'-prefixed leader key for common commands.
;;
;; Vim/Evil emulation has been removed entirely. Editing uses plain
;; Emacs keybindings everywhere (files, Dired, Magit, terminal, etc).

;;; Code:

(use-package which-key
  :demand t
  :config
  (which-key-mode 1))

(use-package general
  :demand t
  :config
  (general-create-definer my/leader-def
    :keymaps 'override
    :prefix "C-c"
    :global-prefix "C-c")

  (defun my/open-terminal-below ()
    "Open a terminal in a horizontal split below the current window."
    (interactive)
    (split-window-below)
    (other-window 1)
    (term (or explicit-shell-file-name (getenv "SHELL") "/bin/sh")))

  ;; `term-mode' uses `C-c' as its "escape to Emacs" prefix by default
  ;; (e.g. `C-c b' to switch buffers), which shadows the shell's own use
  ;; of `C-c' (e.g. SIGINT). Use `C-x' as the escape prefix instead, so
  ;; regular Emacs `C-x ...' commands work in the terminal and `C-c' is
  ;; passed straight through to the shell.
  (with-eval-after-load 'term
    (term-set-escape-char ?\C-x))

  (my/leader-def
    "o" '(:ignore t :which-key "open")
    "ot" '(my/open-terminal-below :which-key "terminal below")
    "oe" '(dired-sidebar-toggle-sidebar :which-key "file explorer")

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
    "sg" '(consult-ripgrep :which-key "ripgrep")

    "j" '(:ignore t :which-key "jump")
    "jj" '(avy-goto-char-timer :which-key "jump to char")
    "jw" '(avy-goto-word-1 :which-key "jump to word (1 char)")
    "jW" '(avy-goto-word-2 :which-key "jump to word (2 chars)")
    "jl" '(avy-goto-line :which-key "jump to line")

    "m" '(:ignore t :which-key "multiple-cursors")
    "mn" '(mc/mark-next-like-this :which-key "mark next like this")
    "mp" '(mc/mark-previous-like-this :which-key "mark previous like this")
    "ma" '(mc/mark-all-like-this :which-key "mark all like this")
    "md" '(mc/mark-all-dwim :which-key "mark all dwim")
    "ml" '(mc/edit-lines :which-key "edit lines")))

(provide 'init-keybindings)
;;; init-keybindings.el ends here
