;;; init-completion.el --- Fast in-buffer completion -*- lexical-binding: t; -*-

;;; Code:

(use-package corfu
  :demand t
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.1)
  (corfu-auto-prefix 2)
  (corfu-cycle t)
  :config
  (global-corfu-mode))

(use-package orderless
  :demand t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(provide 'init-completion)
;;; init-completion.el ends here
