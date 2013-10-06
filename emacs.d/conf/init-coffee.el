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
              (define-key coffee-mode-map (kbd "C-c o") #'ff-find-other-file)

              (define-key coffee-mode-map (kbd "C-c C-k") #'coffee-compile-file)
              (define-key coffee-mode-map (kbd "C-c C-l") #'coffee-build-for-grunt)
              ))

(add-hook 'js3-mode-hook
          #'(lambda ()
              (define-key js3-mode-map (kbd "C-c o") #'ff-find-other-file)
              ))


;; (add-hook 'after-save-hook
;;           #'(lambda ()
;;               (when (eq major-mode 'coffee-mode)
;;                 (coffee-compile-file))))

(defun coffee-build-for-grunt ()
  "coffee-script compile for grunt task"
  (interactive)
  (let ((cur-dir (expand-file-name default-directory)))
    (compile 
     (if (string-match "client" cur-dir)
         "grunt client"
       "grunt server"))))
