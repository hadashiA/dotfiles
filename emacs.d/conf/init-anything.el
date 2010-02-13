;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(require 'info)
(require 'anything-config)

(define-key anything-map (kbd "C-p") 'anything-previous-line)
(define-key anything-map (kbd "C-n") 'anything-next-line)
(define-key anything-map (kbd "C-v") 'anything-next-source)
(define-key anything-map (kbd "M-v") 'anything-previous-source)
(global-set-key (kbd "C-;") 'anything)

(setq anything-sources
      '(anything-c-source-buffers
        anything-c-source-files-in-current-dir       ;; カレントディレクトディレクトリにあるファイル
        anything-c-source-file-name-history          ;; ファイル開いた履歴
        anything-c-source-recentf                    ;; 最近開いたファイル
        anything-c-source-locate
;;        anything-c-source-info-pages               ;; infoマニュアルを参照する
;;        anything-c-source-man-pages                ;; manページ。なんかすげー重いんだけど
;;        anything-c-source-occur                      ;;
;;        anything-c-source-emacs-commands           ;; emacsコマンドを実行する
;;        anything-c-source-emacs-functions          ;; emacs関数を検索する
;;        anything-c-source-complex-command-history  ;; コマンド履歴の一覧
;;        anything-c-source-info-elisp
        ))

;; 
;;(require 'anything-c-moccur)
;;
;;(global-set-key (kbd "M-o") 'anything-c-moccur-occur-by-moccur) ;バッファ内検索
;;(global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur) ;ディレクトリ
;;(add-hook 'dired-mode-hook ;dired
;;          '(lambda ()
;;             (local-set-key (kbd "O") 'anything-c-moccur-dired-do-moccur-by-moccur)))
