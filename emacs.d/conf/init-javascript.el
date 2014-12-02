;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.\\(js\\|as\\|json\\|jsn\\)\\'" . js2-mode))

(add-hook 'js2-mode-hook
          '(lambda ()
             (custom-set-variables
              '(js2-auto-indent-p t)
              '(js2-enter-indents-newline t)
              '(js2-indent-on-enter-key t)
              '(js2-indent-dots nil)
              '(js2-lazy-dots nil)
              '(js2-mirror-mode t)
              '(js2-mode-dev-mode-p t)
              '(js2-compact-expr t)
              '(js2-consistent-level-indent-inner-bracket t)
              ;; '(js2-expr-indent-offset 0)
              ;; '(js2-paren-indent-offset 0)
              ;; '(js2-square-indent-offset 0)
              ;; '(js2-curly-indent-offset 0)
              )
             (define-key js2-mode-map ";" 'insert-semicolon-and-new-line-and-indent)
             (define-key js2-mode-map (kbd "C-c C-a") #'align)
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

(autoload 'jade-mode "jade-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

