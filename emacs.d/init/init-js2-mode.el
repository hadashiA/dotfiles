(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.\\(js\\|jsx\\)\\'" . js2-mode))

(add-hook 'js2-mode-hook
          '(lambda ()
             (setq js2-basic-offset 2)
             (setq js2-strict-missing-semi-warning nil)
             (setq js2-missing-semi-one-line-override nil)
             (setq js2-strict-trailing-comma-warning t)
             (setq js2-expr-indent-offset 0)
             (setq js2-paren-indent-offset 0)
             (setq js2-square-indent-offset 0)
             (setq js2-curly-indent-offset 0)
             (define-key js2-mode-map ";" 'insert-semicolon-and-new-line-and-indent)
             (define-key js2-mode-map (kbd "C-c C-a") #'align)
             (define-key js2-mode-map "\M-j" 'vimlike-f)
             (define-key js2-mode-map "\M-k" 'vimlike-F)
             (define-key js2-mode-map "\M-u" 'vimlike-semicolon)
             ))

(add-hook 'align-load-hook
          (lambda ()
            (add-to-list 'align-rules-list
                         '(js2-assignment-literal
                           (regexp . "\\(\\s-*\\)=\\s-*[^# \t\n]")
                           (repeat . t)
                           (modes  . '(js2-mode))))
            ))

(defun insert-semicolon-and-new-line-and-indent ()
  "insert semicolon and newline and indentation."
  (interactive)
  (insert ";")
  (newline-and-indent)
  )

(defun indent-and-back-to-indentation ()
  (interactive)
  (indent-for-tab-command)
  (let ((point-of-indentation
         (save-excursion
           (back-to-indentation)
           (point))))
    (skip-chars-forward "\s " point-of-indentation)))
