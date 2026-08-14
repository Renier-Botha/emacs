;;; init-minibuffer.el --- Vertico-based minibuffer completion -*- lexical-binding: t; -*-

;;; Code:

(use-package vertico
  :demand t
  :custom
  (vertico-cycle t)
  :config
  (vertico-mode 1))

(use-package marginalia
  :demand t
  :config
  (marginalia-mode 1))

(use-package embark
  :bind (("C-." . embark-act)
         ("C-;" . embark-dwim)
         ("C-h B" . embark-bindings))
  :custom
  (prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult
  :after (embark consult)
  :demand t
  :hook (embark-collect-mode . consult-preview-at-point-mode))

(provide 'init-minibuffer)
;;; init-minibuffer.el ends here
