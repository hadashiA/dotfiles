;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; (add-to-load-path "~/.emacs.d/elisp/anything/")

(require 'info)
(require 'anything-config)
(require 'anything-gtags)

(define-key anything-map (kbd "C-p") 'anything-previous-line)
(define-key anything-map (kbd "C-n") 'anything-next-line)
(define-key anything-map (kbd "C-v") 'anything-next-source)
(define-key anything-map (kbd "M-v") 'anything-previous-source)
(global-set-key (kbd "C-;") 'anything)
(global-set-key (kbd "C-:") 'anything-resume)
(setq anything-enable-shortcuts 'alphabet)

(setq anything-sources
      `(
        ;; ,@(anything-c-sources-git-project-for)
        anything-c-source-buffers
        anything-c-source-files-in-current-dir       ;; カレントディレクトディレクトリにあるファイル
        anything-c-source-file-name-history          ;; ファイル開いた履歴
        anything-c-source-recentf                    ;; 最近開いたファイル
        ;; anything-c-source-locate
        anything-c-source-bookmarks                  ;; bookmark
        anything-c-source-info-pages               ;; infoマニュアルを参照する
        ;; anything-c-source-man-pages                  ; manページ。なんかすげー重いんだけど
;;        anything-c-source-occur                      ;;
;;        anything-c-source-emacs-commands           ;; emacsコマンドを実行する
        anything-c-source-emacs-functions          ;; emacs関数を検索する
;;        anything-c-source-complex-command-history  ;; コマンド履歴の一覧
;;        anything-c-source-info-elisp
        ;; anything-c-source-gtags-select
        ))

;; (global-set-key (kbd "C-+") 'anything-gtags-select)

(defun anything-split-window (buf)
  (split-window)
  (other-window 1)
  (switch-to-buffer buf))
;; (setq anything-display-function 'anything-split-window)
(setq anything-display-function 'anything-default-display-buffer)

;; \M-y でキルリング履歴
(setq kill-ring-max 50) ;; kill-ring の最大値. デフォルトは 30.
(setq anything-kill-ring-threshold 10) ;; anything で対象とするkill-ring の要素の長さの最小値.デフォルトは 10.
(global-set-key "\M-y" 'anything-show-kill-ring)

(when (require 'anything-c-moccur nil t)
  (global-set-key (kbd "M-o") 'anything-c-moccur-occur-by-moccur)
  ;; (global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur)
  ;; (global-set-key (kbd "C-s") 'anything-c-moccur-isearch-forward)
  ;; (global-set-key (kbd "C-r") 'anything-c-moccur-isearch-backward)
  (add-hook 'dired-mode-hook
            '(lambda ()
               (local-set-key (kbd "O") 'anything-c-moccur-dired-do-moccur-by-moccur)))
  (setq anything-c-moccur-anything-idle-delay 0.2
        anything-c-moccur-higligt-info-line-flag t
        anything-c-moccur-enable-auto-look-flag t
        anything-c-moccur-enable-initial-pattern t))

(require 'anything-zsh-history)


(defun anything-c-sources-git-project-for (&optional pwd)
  (loop for elt in
        '(("Modified files (%s)" . "--modified")
          ("Untracked files (%s)" . "--others --exclude-standard")
          ("All controlled files in this project (%s)" . ""))
        collect
        `((name . ,(format (car elt) (or pwd
                                         (shell-command-to-string "echo -n `pwd`"))
                           ))
          (init . (lambda ()
                    (unless (and ,(string= (cdr elt) "") ;update candidate buffer every time except for that of all project files
                                 (anything-candidate-buffer))
                      (with-current-buffer
                          (anything-candidate-buffer 'global)
                        (insert
                         (shell-command-to-string
                          ,(format "git ls-files $(git rev-parse --show-cdup) %s"
                                   (cdr elt))))))))
          (candidates-in-buffer)
          (type . file))))

(defun anything-git-project ()
  (interactive)
  (let* ((pwd (shell-command-to-string "echo -n `pwd`"))
         (sources (anything-c-sources-git-project-for pwd)))
    (anything-other-buffer sources
     (format "*Anything git project in %s*" pwd))))

(define-key global-map (kbd "C-+") 'anything-git-project)
