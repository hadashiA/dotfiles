;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; http://www.bookshelf.jp/soft/meadow_50.html#SEC745

(when (require 'color-moccur nil t)
  (setq moccur-split-word t
        moccur-use-migemo t
        dmoccur-use-list nil
        moccur-kill-moccur-buffer t
        *moccur-buffer-name-exclusion-list* '(".+TAGS.+" "*Completions*" "*Messages*" ".+\.log" "\.git" "\.svn")
        dmoccur-list '(("emacs" "~/.emacs.d/" ("\\.el$") nil)))
  (global-set-key (kbd "C-M-o") 'moccur-grep-find)
  ;; (global-set-key (kbd "C-M-o") 'dmoccur)
  )

(load "moccur-edit")
