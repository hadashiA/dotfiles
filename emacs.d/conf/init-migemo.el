;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; Migemo
;; http://www4.kcn.ne.jp/~boochang/emacs/migemo.html

;; メモ
;; ./configure --with-emacs=/Applications/Emacs.app/Contents/MacOS/Emacs --with-lispdir=/Users/hadashi/.emacs.d/elisp/

(when (require 'migemo nil t)
  (setq migemo-use-pattern-alist t)
  (setq migemo-use-frequent-pattern-alist t)
  (setq migemo-pattern-alist-length 1000)
  (setq migemo-use-frequent-pattern-alist t)
  (migemo-init))
