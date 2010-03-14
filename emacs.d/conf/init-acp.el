;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(when (require 'acp nil)
  (acp-mode t)
  (setq acp-paren-alist
        '((?( . ?))
          (?[ . ?])
          (?\" . ?\")))

  ;; (setq acp-insertion-functions
  ;;    '((mark-active . acp-surround-with-paren)
  ;;      ((thing-at-point 'symbol) . acp-surround-symbol-with-paren)
  ;;      (t . acp-insert-paren)))

  ;; (defun acp-surround-symbol-with-paren (n)
  ;;   (save-excursion
  ;;     (save-restriction
  ;;       (narrow-to-region (car (bounds-of-thing-at-point 'symbol)) (cdr (bounds-of-thing-at-point 'symbol)))
  ;;       (goto-char (point-min))
  ;;       (insert-char (car (acp-current-pair)) n)
  ;;       (goto-char (point-max))
  ;;       (insert-char (cdr (acp-current-pair)) n))))
  
  (add-hook 'emacs-lisp-mode-hook 'acp-mode)
  (add-hook 'lisp-mode-hook 'acp-mode))
