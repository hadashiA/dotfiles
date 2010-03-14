;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; flymake
;; 自動的にシンタックスチェックをかける
(when (require 'flymake nil)
  (set-face-background 'flymake-errline "red4")
  (set-face-foreground 'flymake-errline "black")
  (set-face-background 'flymake-warnline "yellow")
  (set-face-foreground 'flymake-warnline "black"))
