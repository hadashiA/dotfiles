;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; http://www.bookshelf.jp/soft/meadow_50.html#SEC745

(when (require 'color-moccur nil t)
  (setq moccur-split-word t
        dmoccur-use-list nil
        moccur-kill-moccur-buffer t
        *moccur-buffer-name-exclusion-list* '(".+TAGS.+" "*Completions*" "*Messages*" ".+\.log" "\.git" "\.svn")
        dmoccur-list '(("emacs" "~/.emacs.d/" ("\\.el$") nil)))
  (global-set-key (kbd "C-M-o") 'moccur-grep-find)

  (when (require 'anything-c-moccur)
    (global-set-key (kbd "M-o") 'anything-c-moccur-occur-by-moccur)
    ;; (global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur)
    (add-hook 'dired-mode-hook
              '(lambda ()
                 (local-set-key (kbd "O") 'anything-c-moccur-dired-do-moccur-by-moccur)))
    (setq anything-c-moccur-anything-idle-delay 0.2
          anything-c-moccur-higligt-info-line-flag t
          anything-c-moccur-enable-auto-look-flag t
          anything-c-moccur-enable-initial-pattern t)))


