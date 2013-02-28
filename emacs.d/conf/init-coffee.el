;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(autoload 'coffee-mode "coffee-mode" "\
Major mode for editing CoffeeScript.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.coffee\\'" . coffee-mode))
(add-to-list 'auto-mode-alist '("\\.iced\\'" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile\\'" . coffee-mode))

(add-hook 'coffee-mode-hook
          #'(lambda ()
              (set (make-local-variable 'tab-width) 2)
              (setq coffee-tab-width 2)
              ))
