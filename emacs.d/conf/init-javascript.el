;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; javascript.el
;; http://web.comhem.se/~u83406637/emacs/javascript.el
;; (add-to-list 'auto-mode-alist '("\\.\\(js\\|as\\|json\\|jsn\\)\\'" . javascript-mode))
;; (autoload 'javascript-mode "javascript" nil t)
;; (setq javascript-indent-level 2)
;; (setq javascript-auto-indent-flag t)

(add-to-list 'auto-mode-alist '("\\.\\(js\\|as\\|json\\|jsn\\)\\'" . js2-mode))
(require 'js2-mode)

(defun insert-semicolon-and-new-line-and-indent ()
  "insert semicolon and newline and indentation."
  (interactive)
  (insert ";")
  (newline-and-indent)
  )

(add-hook 'js2-mode-hook
          '(lambda ()
             (setq js2-bounce-indent-flag nil
                   js2-auto-indent-p t
                   js2-basic-offset 2
                   js2-auto-insert-semicolon t
                   )
             
             (require 'espresso)
             (setq espresso-indent-level 2
                   espresso-expr-indent-offset 2
                   indent-tabs-mode nil)
             (set (make-local-variable 'indent-line-function) 'espresso-indent-line)

             (define-key js2-mode-map "\C-m" 'newline-and-indent)
             (define-key js2-mode-map "\C-i" 'indent-and-back-to-indentation)
             (make-variable-buffer-local 'skeleton-pair)
             (make-variable-buffer-local 'skeleton-pair-on-word)
             (setq skeleton-pair-on-word t)
             (setq skeleton-pair t)
             (make-variable-buffer-local 'skeleton-pair-alist)
             (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
             (local-set-key (kbd "[") 'skeleton-pair-insert-maybe)
             (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
             (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe))

             (define-key js2-mode-map ";" 'insert-semicolon-and-new-line-and-indent)
             )
(defun indent-and-back-to-indentation ()
  (interactive)
  (indent-for-tab-command)
  (let ((point-of-indentation
         (save-excursion
           (back-to-indentation)
           (point))))
    (skip-chars-forward "\s " point-of-indentation)))

;; [2008-03-12]
;; bracket.elにinsert-single-quotationを追加したのに伴い、以下の設定も追従

;; 対応する括弧を自動挿入する。
;; http://d.hatena.ne.jp/khiker/20061119/1163934208
;; (add-hook 'javascript-mode-hook
;;           '(lambda()
;;              (progn
;;                ;; { で{}を書く
;;                (define-key javascript-mode-map "{" 'insert-braces)
;;                ;; ( で()を書く
;;                (define-key javascript-mode-map "(" 'insert-parens)
;;                ;; " で""を書く
;;                (define-key javascript-mode-map "\"" 'insert-double-quotation)
;;                ;; ' で''を書く
;;                (define-key javascript-mode-map "'" 'insert-single-quotation)
;;                ;; [ で[]を書く
;;                (define-key javascript-mode-map "[" 'insert-brackets)
;;                ;; Ctrl+c }でregionを{}で囲む
;;                (define-key javascript-mode-map "\C-c}" 'insert-braces-region)
;;                ;; Ctrl+c )でregionを()で囲む
;;                (define-key javascript-mode-map "\C-c)" 'insert-parens-region)
;;                ;; Ctrl+c ]でregionを[]で囲む
;;                (define-key javascript-mode-map "\C-c]" 'insert-brackets-region)
;;                ;; Ctrl+c "でregionを""で囲む
;;                (define-key javascript-mode-map "\C-c\"" 'insert-double-quotation-region)
;;                )))


(require 'jade-mode)

