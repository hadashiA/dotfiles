;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; Linux用設定
;; (setq grep-find-use-xargs 'bsd)
;; (setq browse-url-generic-program "open")
(setq initial-frame-alist '((width . 157) (height . 47) (top . 10) (left . 10)))

;; Ctrl/Cmd/Optionがシステムに渡されるのを防ぐ
;; (setq mac-pass-control-to-system nil)
;; (setq mac-pass-command-to-system nil)
;; (setq mac-pass-option-to-system nil)

;; 半透明化パッチ適用
;; (setq default-frame-alist
;;       (append (list '(alpha . (80 80))) default-frame-alist))

(add-to-list 'default-frame-alist '(alpha . (80 60 40 40)))

;; ¥の代わりにバックスラッシュを入力する
(define-key global-map [?¥] [?\\])
