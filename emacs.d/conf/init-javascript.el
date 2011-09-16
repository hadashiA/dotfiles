;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; javascript.el
;; http://web.comhem.se/~u83406637/emacs/javascript.el
;; (add-to-list 'auto-mode-alist '("\\.\\(js\\|as\\|json\\|jsn\\)\\'" . javascript-mode))
;; (autoload 'javascript-mode "javascript" nil t)
;; (setq javascript-indent-level 2)
;; (setq javascript-auto-indent-flag t)

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.\\(js\\|as\\|json\\|jsn\\)\\'" . js2-mode))

(add-hook 'js2-mode-hook
          '(lambda ()
             (setq js2-bounce-indent-flag nil
                   js2-auto-indent-p t
                   js2-basic-offset 2
                   js2-auto-insert-semicolon t
                   )
             
             ;; (require 'espresso)
             ;; (setq espresso-indent-level 2
             ;;       espresso-expr-indent-offset 2
             ;;       indent-tabs-mode nil)
             ;; (set (make-local-variable 'indent-line-function) 'espresso-indent-line)
             (define-key js2-mode-map ";" 'insert-semicolon-and-new-line-and-indent)
             (define-key js2-mode-map "\C-m" 'newline-and-indent)
             (define-key js2-mode-map "\C-i" 'indent-and-back-to-indentation)
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

;; (defun kakko-and-semicolon ()
;;   (interactive)
;;   )

(require 'jade-mode)

