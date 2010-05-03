 ;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; wdired
;; http://www.bookshelf.jp/soft/meadow_25.html#SEC292
(when (require 'wdired nil t)
  ;; rでdiredバッファを直接編集できるようになる。
  (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

  ;;パーミッションも変更可能に
  (setq wdired-allow-to-change-permissions t))


;; lsの代りにEmacs自体の機能を利用してディレクトリをリスト
;; http://www.namazu.org/~tsuchiya/elisp/#dired
(when (require 'ls-lisp nil t)
  (let (current-load-list)
    (defadvice insert-directory
      (around reset-locale activate compile)
      (let ((system-time-locale "C"))
        ad-do-it))))

(when (require 'dired-x)
  (setq dired-guess-shell-alist-user
        '(("\\.tar\\.gz\\'"  "tar ztvf")
          ("\\.taz\\'" "tar ztvf")
          ("\\.tar\\.bz2\\'" "tar Itvf")
          ("\\.zip\\'" "unzip -l")
          ("\\.\\(g\\|\\) z\\'" "zcat")
          ("\\.\\(jpg\\|JPG\\|gif\\|GIF\\)\\'" (when run-carbon-emacs "open"))
          )))

(add-hook 'dired-load-hook
          (lambda ()
            (require 'sorter)))

;; ディレクトリを移動してもソート方法が変化しない
;; Meadow/Emacs memo: ディレクトリ表示 — dired など
;; http://www.bookshelf.jp/soft/meadow_25.html#SEC290
(defadvice dired-advertised-find-file
  (around dired-sort activate)
  (let ((sw dired-actual-switches))
    ad-do-it
    (if (string= major-mode 'dired-mode)
        (progn
          (setq dired-actual-switches sw)
          (dired-sort-other dired-actual-switches)))
    ))

(defadvice dired-my-up-directory
  (around dired-sort activate)
  (let ((sw dired-actual-switches))
    ad-do-it
    (if (string= major-mode 'dired-mode)
        (progn
          (setq dired-actual-switches sw)
          (dired-sort-other dired-actual-switches)))
    ))

(defun dired-app-open ()
  (interactive)
  (let ((file (dired-get-filename)))
    (shell-command-to-string (concat "open " file))))
(define-key dired-mode-map "z" 'dired-app-open)
