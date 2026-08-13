;;; init-clipboard.el --- System clipboard integration -*- lexical-binding: t; -*-

;;; Commentary:
;; Makes the normal kill-ring commands (`M-w', `C-w', `C-y'/`yank') read
;; from and write to the system clipboard, in addition to the Emacs
;; kill-ring.
;;
;; - In GUI Emacs this already works out of the box, but we set the
;;   variables explicitly so behaviour doesn't depend on defaults.
;; - In terminal Emacs (`emacs -nw'), Emacs has no direct way to talk to
;;   the system clipboard, so we use `xclip' (via an external tool:
;;   xclip/xsel/wl-copy/pbcopy/termux-clipboard, whichever is available)
;;   to bridge kill-ring <-> clipboard.
;;
;; As a belt-and-braces fallback, explicit "always use the clipboard"
;; commands are bound under the leader key (`C-c y ...'), using Emacs'
;; built-in `clipboard-*' commands, which bypass `select-enable-clipboard'
;; entirely and always talk to the system clipboard directly.

;;; Code:

;; Kill-ring <-> primary selection/clipboard integration (GUI default).
(setq select-enable-clipboard t
      select-enable-primary t)

;; Terminal clipboard bridge.
(use-package xclip
  :unless (display-graphic-p)
  :demand t
  :config
  (xclip-mode 1))

;; `init-keybindings' (loaded before this module) has already defined
;; `my/leader-def' and required `general', so this can be called directly.
(my/leader-def
  "y" '(:ignore t :which-key "clipboard")
  "yy" '(clipboard-kill-ring-save :which-key "copy to clipboard")
  "yw" '(clipboard-kill-region :which-key "cut to clipboard")
  "yp" '(clipboard-yank :which-key "paste from clipboard"))

(provide 'init-clipboard)
;;; init-clipboard.el ends here
