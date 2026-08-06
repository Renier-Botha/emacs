;;; init-minibuffer.el --- Vertico-based minibuffer completion -*- lexical-binding: t; -*-

;;; Commentary:
;; - vertico: vertical completion UI for the minibuffer.
;; - marginalia: rich annotations (docstrings, file sizes, etc.) in
;;   the minibuffer, next to vertico's candidates.
;; - embark: contextual actions on the thing at point / minibuffer
;;   candidate ("right-click" via keyboard); embark-consult adds
;;   Embark support for consult's collections (e.g. previewing grep
;;   results, exporting to a grep-mode buffer).
;;
;; Together with `orderless' and `consult' (configured in
;; init-completion.el / init-navigation.el) this gives a full
;; Vertico + Orderless + Consult + Marginalia + Embark stack.

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
  ;; Don't pop up the *Completions* buffer as a target selector.
  (prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult
  :after (embark consult)
  :demand t
  :hook (embark-collect-mode . consult-preview-at-point-mode))

(provide 'init-minibuffer)
;;; init-minibuffer.el ends here
