;;; init-completion.el --- Fast in-buffer completion -*- lexical-binding: t; -*-

;;; Code:

(use-package corfu
  :demand t
  :custom
  ;; Pop up automatically as you type.
  (corfu-auto t)
  (corfu-auto-delay 0.1)
  (corfu-auto-prefix 2)
  (corfu-cycle t)
  ;; Show a ghost-text preview of the top candidate inline, Copilot-style.
  (corfu-preview-current 'insert)
  (corfu-preselect 'prompt)
  ;; Don't close the popup just because the current input doesn't match
  ;; anything yet, or when you type a separator character.
  (corfu-quit-no-match 'separator)
  (corfu-quit-at-boundary 'separator)
  (corfu-popupinfo-delay '(0.3 . 0.2))
  (corfu-scroll-margin 4)
  (corfu-count 12)
  :bind
  ;; Evil users hit RET constantly for new lines in insert state -- don't
  ;; let an open popup hijack that. Use TAB to accept a candidate instead,
  ;; and C-g/C-e to dismiss the popup without touching the buffer.
  (:map corfu-map
        ("RET" . nil)
        ("TAB" . corfu-insert)
        ([tab] . corfu-insert)
        ("C-e" . corfu-quit))
  :init
  (global-corfu-mode)
  :config
  (corfu-popupinfo-mode)
  (corfu-history-mode)
  (with-eval-after-load 'savehist
    (add-to-list 'savehist-additional-variables 'corfu-history)))

;; Show icons for the kind of each completion candidate (function,
;; variable, snippet, ...).
(use-package kind-icon
  :after corfu
  :demand t
  :custom
  (kind-icon-default-face 'corfu-default)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

;; Extra completion-at-point sources layered underneath whatever the
;; major mode / Eglot already provide, so corfu still has something
;; useful to suggest in buffers without an LSP server.
(use-package cape
  :demand t
  :custom
  (cape-dabbrev-min-length 3)
  :init
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-keyword))

;; Fall back to a popup usable in terminal frames too (e.g. `emacs -nw'),
;; since corfu's default child-frame popup only works under a GUI.
(use-package corfu-terminal
  :if (not (display-graphic-p))
  :after corfu
  :demand t
  :config
  (corfu-terminal-mode 1))

(use-package orderless
  :demand t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(provide 'init-completion)
;;; init-completion.el ends here
