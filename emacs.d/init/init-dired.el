 ;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; rでdiredバッファを直接編集できるようになる。
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
;;パーミッションも変更可能に
(setq wdired-allow-to-change-permissions t)


;; lsの代りにEmacs自体の機能を利用してディレクトリをリスト
;; http://www.namazu.org/~tsuchiya/elisp/#dired
(require 'ls-lisp)
(let (current-load-list)
  (defadvice insert-directory
      (around reset-locale activate compile)
    (let ((system-time-locale "C"))
      ad-do-it)))

(require 'dired-x)
(setq dired-guess-shell-alist-user
      '(("\\.tar\\.gz\\'"  "tar ztvf")
        ("\\.taz\\'" "tar ztvf")
        ("\\.tar\\.bz2\\'" "tar Itvf")
        ("\\.zip\\'" "unzip -l")
        ("\\.\\(g\\|\\) z\\'" "zcat")
        ("\\.\\(jpg\\|JPG\\|gif\\|GIF\\)\\'" (when run-carbon-emacs "open"))
        ))

(global-set-key "\C-x\C-d" 'dired-jump)
  
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


;; make get-free-disk-space human readable (especially for dired) — Gist
;; https://gist.github.com/845216
(defadvice get-free-disk-space (after get-free-disk-gb activate)
  "Return free disk space with GByte order"
  (let ((kb (string-to-number ad-return-value))) ; this is reserved variable
  (if (> kb 1024)
      (progn (setq kb (/ kb 1024))
             (if (> kb 1024)
                 (setq ad-return-value (format "%.0f GB" (/ kb 1024)))
               (setq ad-return-value (format "%.0f MB" kb))))
    (setq ad-return-value (format "%.0f kB" kb))
)))

(defun my-quicklook-at-point ()
  "Preview a file at point with Quick Look."
  (interactive)
  (require 'ffap)
  (let ((url (ffap-url-at-point))
        (file (ffap-file-at-point))
        (process (get-process "qlmanage_ps")))
    (when url
      (if (string-match "\\`file://\\(.*\\)\\'" url)
          (setq file (match-string 1 url))
        (setq file nil)))
    (when (or (not (stringp file))
              (not (file-exists-p (setq file (expand-file-name file)))))
      (when process
        (kill-process process))
      (error "No file found"))
    (if process
        (kill-process process)
      (message "Quick Look: %s" file)
      (start-process "qlmanage_ps" nil "qlmanage" "-p" file))))

(global-set-key "\C-cy" 'my-quicklook-at-point)

;; (defun my-dired-do-quicklook ()
;;   "In dired, preview with Quick Look."
;;   (interactive)
;;   (let ((file (dired-get-filename))
;;         (process (get-process "qlmanage_ps")))
;;     (if process
;;         (kill-process process)
;;       (start-process "qlmanage_ps" nil "qlmanage" "-p" file))))

;; (eval-after-load "dired"
;;   '(define-key dired-mode-map "\C-cy" 'my-dired-do-quicklook))

(eval-after-load "dired"
  '(add-to-list
    (quote dired-font-lock-keywords)
    (list dired-re-exe
	  '(".+" (dired-move-to-filename) nil (0 (quote face-for-executable))))))
