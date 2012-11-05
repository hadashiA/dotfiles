;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(autoload 'js3-mode "js3-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.\\(js\\|as\\|json\\|jsn\\)\\'" . js3-mode))

(add-hook 'js3-mode-hook
          '(lambda ()
             (custom-set-variables
              '(js3-auto-indent-p t)
              '(js3-enter-indents-newline t)
              '(js3-indent-on-enter-key t)
              '(js3-indent-dots nil)
              '(js3-lazy-dots nil)
              '(js3-mirror-mode t)
              '(js3-mode-dev-mode-p t)
              '(js3-compact-expr t)
              '(js3-consistent-level-indent-inner-bracket t)
              ;; '(js3-expr-indent-offset 0)
              ;; '(js3-paren-indent-offset 0)
              ;; '(js3-square-indent-offset 0)
              ;; '(js3-curly-indent-offset 0)
              )
             (define-key js3-mode-map ";" 'insert-semicolon-and-new-line-and-indent)
             (define-key js3-mode-map (kbd "C-c C-a") #'align)
             ))

(add-hook 'align-load-hook
          (lambda ()
            (add-to-list 'align-rules-list
                         '(js3-assignment-literal
                           (regexp . "\\(\\s-*\\)=\\s-*[^# \t\n]")
                           (repeat . t)
                           (modes  . '(js3-mode))))
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

