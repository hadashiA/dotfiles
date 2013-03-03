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
              (setq whitespace-action '(auto-cleanup)) ;; automatically clean up bad whitespace
              (setq whitespace-style '(trailing space-before-tab indentation empty space-after-tab)) ;; only show bad whitespace
              (define-key coffee-mode-map (kbd "C-c C-l") #'grunt-for-build)
              ))


(defun grunt-for-build ()
  "coffee-script compile for grunt task"
  (interactive)
  (let ((cur-dir (expand-file-name default-directory)))
    (compile 
     (if (string-match "/\\(server\\|client\\)s?/" cur-dir)
         (concat "grunt " (match-string 1 cur-dir))
       "grunt"))))
