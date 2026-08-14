;;; init-prog.el --- Generic programming defaults -*- lexical-binding: t; -*-

;;; Code:

(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'prog-mode-hook #'electric-pair-mode)

(show-paren-mode 1)
(setq show-paren-delay 0)

(setq-default indent-tabs-mode nil
              tab-width 4)

(add-hook 'before-save-hook #'delete-trailing-whitespace)

(provide 'init-prog)
;;; init-prog.el ends here
