;;; init-keybindings.el --- Leader-key bindings (no Vim emulation) -*- lexical-binding: t; -*-

;;; Code:

(use-package which-key
  :demand t
  :config
  (which-key-mode 1))

(use-package general
  :demand t
  :config
  ;; Leader key: SPC in Evil's normal/visual/motion states, C-SPC in
  ;; insert/emacs states, and C-c everywhere (including non-Evil buffers).
  (general-create-definer my/leader-def
    :states '(normal visual motion emacs insert)
    :keymaps 'override
    :prefix "SPC"
    :non-normal-prefix "C-SPC"
    :global-prefix "C-c")

  (defun my/open-terminal-below ()
    "Open a terminal in a horizontal split below the current window."
    (interactive)
    (split-window-below)
    (other-window 1)
    (term (or explicit-shell-file-name (getenv "SHELL") "/bin/sh")))

  (with-eval-after-load 'term
    (term-set-escape-char ?\C-x))

  (my/leader-def
    "SPC" '(execute-extended-command :which-key "M-x")
    "u"   '(universal-argument :which-key "universal argument")

    "t" '(:ignore t :which-key "toggle")
    "te" '(evil-mode :which-key "toggle evil mode (global)")

    "o" '(:ignore t :which-key "open")
    "ot" '(my/open-terminal-below :which-key "terminal below")

    "w" '(:ignore t :which-key "window")
    "wv" '(split-window-right :which-key "split right")
    "ws" '(split-window-below :which-key "split below")
    "wd" '(delete-window :which-key "delete window")
    "wo" '(delete-other-windows :which-key "delete other windows")
    "ww" '(other-window :which-key "other window")

    "b" '(:ignore t :which-key "buffer")
    "bb" '(consult-buffer :which-key "switch buffer")
    "bd" '(kill-current-buffer :which-key "kill buffer")

    "f" '(:ignore t :which-key "file")
    "ff" '(find-file :which-key "find file")
    "fs" '(save-buffer :which-key "save file")

    "g" '(:ignore t :which-key "git")
    "gs" '(magit-status :which-key "status")
    "gb" '(magit-blame :which-key "blame")
    "gl" '(magit-log-current :which-key "log")
    "gc" '(magit-commit :which-key "commit")
    "gp" '(magit-push :which-key "push")
    "gP" '(magit-pull :which-key "pull")
    "gf" '(magit-fetch :which-key "fetch")
    "gd" '(magit-diff-buffer-file :which-key "diff file")

    "c" '(:ignore t :which-key "code")
    "cc" '(completion-at-point :which-key "complete at point")
    "cd" '(xref-find-definitions :which-key "find definitions")
    "cr" '(xref-find-references :which-key "find references")
    "ca" '(eglot-code-actions :which-key "code actions")
    "cn" '(eglot-rename :which-key "rename")
    "cf" '(eglot-format :which-key "format")

    "p" '(:ignore t :which-key "project")
    "pf" '(project-find-file :which-key "find file in project")
    "pg" '(project-find-regexp :which-key "find regexp in project")
    "pp" '(project-switch-project :which-key "switch project")
    "pc" '(project-compile :which-key "compile")
    "pk" '(project-kill-buffers :which-key "kill project buffers")

    "s" '(:ignore t :which-key "search")
    "sl" '(consult-line :which-key "search line")
    "sg" '(consult-ripgrep :which-key "ripgrep")

    "j" '(:ignore t :which-key "jump")
    "jj" '(avy-goto-char-timer :which-key "jump to char")
    "jw" '(avy-goto-word-1 :which-key "jump to word (1 char)")
    "jW" '(avy-goto-word-2 :which-key "jump to word (2 chars)")
    "jl" '(avy-goto-line :which-key "jump to line")

    "d" '(:ignore t :which-key "debug")
    "dd" '(dape :which-key "start/select debug session")
    "db" '(dape-breakpoint-toggle :which-key "toggle breakpoint")
    "dB" '(dape-breakpoint-remove-all :which-key "remove all breakpoints")
    "dn" '(dape-next :which-key "next (step over)")
    "di" '(dape-step-in :which-key "step in")
    "do" '(dape-step-out :which-key "step out")
    "dc" '(dape-continue :which-key "continue")
    "dr" '(dape-restart :which-key "restart")
    "dq" '(dape-quit :which-key "quit session")
    "dR" '(dape-repl :which-key "repl")
    "dI" '(dape-info :which-key "info panels")
    "dw" '(dape-watch-dwim :which-key "add watch")

    "m" '(:ignore t :which-key "multiple-cursors")
    "mn" '(mc/mark-next-like-this :which-key "mark next like this")
    "mp" '(mc/mark-previous-like-this :which-key "mark previous like this")
    "ma" '(mc/mark-all-like-this :which-key "mark all like this")
    "md" '(mc/mark-all-dwim :which-key "mark all dwim")
    "ml" '(mc/edit-lines :which-key "edit lines")))

(provide 'init-keybindings)
;;; init-keybindings.el ends here
