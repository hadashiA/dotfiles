;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; (autoload 'gtags-mode "gtags" "" t)
(require 'gtags)
(setq gtags-mode-hook
      (lambda ()
        (local-set-key (kbd "M-t") 'gtags-find-tag)
        (local-set-key (kbd "M-r") 'gtags-find-rtag)
        (local-set-key (kbd "M-s") 'gtags-find-symbol)
        (local-set-key (kbd "S-C-t") 'gtags-pop-stack)
        ))

;; (define-key gtags-mode-map "\M-t" 'gtags-find-rtag)
;; (define-key gtags-mode-map "\M-r" 'gtags-pop-stack)
;; (define-key gtags-mode-map "\M-s" 'gtags-find-symbol)

(defun gtags-mode-setup ()
  (interactive)
  (gtags-mode)
  ;; (gtags-make-complete-list)
  )

(dolist (hook '(cc-mode-common-hook
                c++-mode-hook
                objc-mode-hook
                ruby-mode-hook
                php-mode-hook))
  (add-hook hook #'gtags-mode-setup))
