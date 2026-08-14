;;; init-clipboard.el --- System clipboard integration -*- lexical-binding: t; -*-

;;; Code:

(setq select-enable-clipboard t
      select-enable-primary t)

(use-package xclip
  :unless (display-graphic-p)
  :demand t
  :config
  (xclip-mode 1))

(my/leader-def
  "y" '(:ignore t :which-key "clipboard")
  "yy" '(clipboard-kill-ring-save :which-key "copy to clipboard")
  "yw" '(clipboard-kill-region :which-key "cut to clipboard")
  "yp" '(clipboard-yank :which-key "paste from clipboard"))

(provide 'init-clipboard)
;;; init-clipboard.el ends here
