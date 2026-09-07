;;; init-completion.el --- Fast in-buffer completion -*- lexical-binding: t; -*-

;;; Code:

(use-package corfu
  :demand t
  :custom
  ;; No automatic popup while typing -- only show completions when
  ;; explicitly requested (see `SPC c c' in init-keybindings.el).
  (corfu-auto nil)
  (corfu-cycle t)
  (corfu-popupinfo-delay '(0.5 . 0.2))
  :config
  (global-corfu-mode)
  (corfu-popupinfo-mode))

(use-package orderless
  :demand t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(provide 'init-completion)
;;; init-completion.el ends here
