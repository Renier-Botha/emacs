;;; init-completion.el --- Fast in-buffer completion -*- lexical-binding: t; -*-

;;; Commentary:
;; Corfu is a small, fast, non-intrusive completion-at-point UI. It
;; works great together with Eglot (which supplies completions via the
;; standard `completion-at-point-functions' machinery, no glue needed).

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

;; Better fuzzy/out-of-order matching for completion candidates.
(use-package orderless
  :demand t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(provide 'init-completion)
;;; init-completion.el ends here
