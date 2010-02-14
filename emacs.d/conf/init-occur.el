;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; http://www.bookshelf.jp/soft/meadow_50.html#SEC745

(require 'color-moccur)

(setq moccur-split-word t)

(setq *moccur-buffer-name-exclusion-list*
      '(".+TAGS.+" "*Completions*" "*Messages*"))
(setq dmoccur-use-list t)
(setq dmoccur-list
      '(
        ("emacs" "~/.emacs.d/" ("\\.el$") nil)
        ))

(define-key dired-mode-map "O" 'dired-do-moccur)
(define-key Buffer-menu-mode-map "O" 'Buffer-menu-moccur)
