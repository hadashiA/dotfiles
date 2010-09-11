;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; (add-to-load-path "~/.emacs.d/elisp/anything/")

(require 'info)
(require 'anything-config)

(define-key anything-map (kbd "C-p") 'anything-previous-line)
(define-key anything-map (kbd "C-n") 'anything-next-line)
(define-key anything-map (kbd "C-v") 'anything-next-source)
(define-key anything-map (kbd "M-v") 'anything-previous-source)
(global-set-key (kbd "C-;") 'anything)
(setq anything-enable-shortcuts 'alphabet)

(setq anything-sources
      '(anything-c-source-buffers
        anything-c-source-files-in-current-dir       ;; カレントディレクトディレクトリにあるファイル
        anything-c-source-file-name-history          ;; ファイル開いた履歴
        anything-c-source-recentf                    ;; 最近開いたファイル
        anything-c-source-locate
        anything-c-source-bookmarks                  ;; bookmark
;;        anything-c-source-info-pages               ;; infoマニュアルを参照する
        ;; anything-c-source-man-pages                  ; manページ。なんかすげー重いんだけど
;;        anything-c-source-occur                      ;;
;;        anything-c-source-emacs-commands           ;; emacsコマンドを実行する
;;        anything-c-source-emacs-functions          ;; emacs関数を検索する
;;        anything-c-source-complex-command-history  ;; コマンド履歴の一覧
;;        anything-c-source-info-elisp
        ))

;; \M-y でキルリング履歴
(setq kill-ring-max 30) ;; kill-ring の最大値. デフォルトは 30.
(setq anything-kill-ring-threshold 5) ;; anything で対象とするkill-ring の要素の長さの最小値.デフォルトは 10.
(global-set-key "\M-y" 'anything-show-kill-ring);;kill-ring の最大値. デフォルトは 30.

(setq kill-ring-max 20)

;;anything で対象とするkill-ring の要素の長さの最小値.

;;デフォルトは 10.

(setq anything-kill-ring-threshold 5)

(global-set-key "\M-y" 'anything-show-kill-ring)

(when (require 'anything-c-moccur nil t)
  (global-set-key (kbd "M-o") 'anything-c-moccur-occur-by-moccur)
  ;; (global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur)
  (add-hook 'dired-mode-hook
            '(lambda ()
               (local-set-key (kbd "O") 'anything-c-moccur-dired-do-moccur-by-moccur)))
  (setq anything-c-moccur-anything-idle-delay 0.2
        anything-c-moccur-higligt-info-line-flag t
        anything-c-moccur-enable-auto-look-flag t
        anything-c-moccur-enable-initial-pattern t))

(when (require 'anything-rurima nil t)
  (setq anything-rurima-index-file "~/src/rurema/rubydoc/rurema.e")
  ;; (define-key ruby-mode-map "\C-cue" 'anything-rurima)
  ;; (define-key ruby-mode-map "\C-cum" 'anything-rurima-at-point)
    (global-set-key "\C-cue" 'anything-rurima)
    (global-set-key "\C-cum" 'anything-rurima-at-point))

(require 'anything-zsh-history)
