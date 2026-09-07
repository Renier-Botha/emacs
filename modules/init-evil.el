;;; init-evil.el --- Evil mode and friends -*- lexical-binding: t; -*-

;;; Code:

(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-want-C-u-scroll t
        evil-want-C-i-jump nil
        evil-want-fine-undo t
        evil-respect-visual-line-mode t
        evil-undo-system 'undo-redo
        evil-search-module 'evil-search)
  :config
  (evil-mode 1)
  ;; Prefer Emacs-native keys in the minibuffer and a few utility modes.
  (dolist (mode '(term-mode vterm-mode eshell-mode))
    (add-to-list 'evil-emacs-state-modes mode))
  (evil-set-undo-system 'undo-redo))

(use-package evil-collection
  :after evil
  :demand t
  :custom
  (evil-collection-setup-minibuffer t)
  :config
  (evil-collection-init))

(use-package evil-surround
  :after evil
  :demand t
  :diminish evil-surround-mode
  :config
  (global-evil-surround-mode 1))

(use-package evil-commentary
  :after evil
  :demand t
  :diminish evil-commentary-mode
  :config
  (evil-commentary-mode 1))

(provide 'init-evil)
;;; init-evil.el ends here
