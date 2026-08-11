;;; init-navigation.el --- Consult -*- lexical-binding: t; -*-

;;; Commentary:
;; - consult: enhanced search/navigation commands (buffers, grep, lines...).

;;; Code:

(use-package consult
  :bind (("C-x b"   . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x p b" . consult-project-buffer)
         ("M-y"     . consult-yank-pop)
         ("M-g g"   . consult-goto-line)
         ("M-g M-g" . consult-goto-line)
         ("M-g i"   . consult-imenu)
         ("M-g o"   . consult-outline)
         ("M-s l"   . consult-line)
         ("M-s g"   . consult-ripgrep)
         ("M-s f"   . consult-find)
         :map minibuffer-local-map
         ("M-s" . consult-history)
         ("M-r" . consult-history))
  :custom
  ;; Don't preview expensive commands automatically.
  (consult-preview-key 'any)
  (register-preview-function #'consult-register-format)
  :init
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref))

(use-package avy
  :bind (("C-'"   . avy-goto-char-timer)
         ("M-g w" . avy-goto-word-1)
         ("M-g W" . avy-goto-word-2)
         ("M-g l" . avy-goto-line))
  :custom
  (avy-timeout-seconds 0.3)
  (avy-style 'at-full))

(provide 'init-navigation)
;;; init-navigation.el ends here
