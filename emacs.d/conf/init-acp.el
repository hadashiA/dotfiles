;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(when (require 'acp nil)
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
  ;;       (insert-char (cdr (acp-current-pair))

  (defun acp-setup-default ()
    (setq acp-paren-alist '( (?( . ?)) (?[ . ?]) (?\" . ?\") (?\' . ?\')))
    (acp-mode-turn-on))

  (defun acp-setup-lisp ()
    (setq acp-paren-alist '( (?( . ?)) (?[ . ?]) (?\" . ?\") ))
    (acp-mode-turn-on))

  ;; (add-hook 'text-mode-hook 'acp-mode-turn-on)
  (add-hook 'html-mode-hook 'acp-setup-default)
  (add-hook 'c-common-mode-hook 'acp-setup-default)
  (add-hook 'c-mode-hook 'acp-setup-default)
  (add-hook 'ruby-mode-hook 'acp-setup-default)
  (add-hook 'python-mode-hook 'acp-setup-default)

  (add-hook 'lisp-mode-hook 'acp-setup-lisp)
  (add-hook 'emacs-lisp-mode-hook 'acp-setup-lisp))