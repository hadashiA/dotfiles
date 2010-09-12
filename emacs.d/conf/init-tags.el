;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ctags
;; http://www.bookshelf.jp/soft/meadow_42.html#SEC625

;; 候補が複数ある場合は、C-xu or C-uで前置引数を置いてからfind-tagする
;; と、次の候補にジャンプする

;; (global-set-key "\C-cf" 'find-tag)
;; (global-set-key "\C-cb" 'pop-tag-mark)

;; (require 'etags-table)
;; (add-to-list  'etags-table-alist
;;               '("\\.[mh]$" "~/.emacs.d/share/tags/objc.TAGS"))

(autoload 'gtags-mode "gtags" "" t)
(setq gtags-mode-hook
      '(lambda ()
         (local-set-key "\M-t" 'gtags-find-tag)
         (local-set-key "\M-r" 'gtags-find-rtag)
         (local-set-key "\M-s" 'gtags-find-symbol)
         ;; (local-set-key "\C-t" 'gtags-pop-stack)
         ))

