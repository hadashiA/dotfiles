;; ;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(defun skelton-setup-default ()
  (interactive)
  (make-variable-buffer-local 'skeleton-pair)
  (make-variable-buffer-local 'skeleton-pair-on-word)
  (setq skeleton-pair-on-word t)
  (setq skeleton-pair t)
  (make-variable-buffer-local 'skeleton-pair-alist)
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "'") 'skeleton-pair-insert-maybe))

(defun skelton-setup-lisp ()
  (interactive)
  (make-variable-buffer-local 'skeleton-pair)
  (make-variable-buffer-local 'skeleton-pair-on-word)
  (setq skeleton-pair-on-word t)
  (setq skeleton-pair t)
  (make-variable-buffer-local 'skeleton-pair-alist)
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe))

(add-hook 'html-mode-hook 'skelton-setup-default)
(add-hook 'c-common-mode-hook 'skelton-setup-default)
(add-hook 'c-mode-hook 'skelton-setup-default)
(add-hook 'ruby-mode-hook 'skelton-setup-default)
(add-hook 'python-mode-hook 'skelton-setup-default)

(add-hook 'lisp-mode-hook 'skelton-setup-lisp)
(add-hook 'emacs-lisp-mode-hook 'skelton-setup-lisp)