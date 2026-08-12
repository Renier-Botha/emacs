;;; init-multiple-cursors.el --- Multiple cursors -*- lexical-binding: t; -*-

;;; Commentary:
;; - multiple-cursors: edit several points in a buffer simultaneously.
;;   Mark occurrences of a word/region (or one cursor per line) and every
;;   keystroke is replayed at each cursor.

;;; Code:

(use-package multiple-cursors
  :bind (("C->"     . mc/mark-next-like-this)
         ("C-<"     . mc/mark-previous-like-this)
         ("C-c C->" . mc/mark-all-like-this)
         ("C-!"     . mc/mark-all-dwim)
         ("C-c m l" . mc/edit-lines)
         ("C-c m a" . mc/mark-all-like-this)
         ("C-c m n" . mc/mark-next-like-this)
         ("C-c m p" . mc/mark-previous-like-this)))

(provide 'init-multiple-cursors)
;;; init-multiple-cursors.el ends here
