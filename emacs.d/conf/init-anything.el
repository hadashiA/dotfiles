;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; (add-to-load-path "~/.emacs.d/elisp/anything/")

(require 'info)
(require 'anything-config)

(define-key anything-map (kbd "C-p") 'anything-previous-line)
(define-key anything-map (kbd "C-n") 'anything-next-line)
(define-key anything-map (kbd "C-v") 'anything-next-source)
(define-key anything-map (kbd "M-v") 'anything-previous-source)
;; (global-set-key (kbd "C-;") 'anything)
(global-set-key (kbd "C-;") 'anything-for-files)
(global-set-key (kbd "C-:") 'anything-resume)
(global-set-key (kbd "C-*") 'anything-execute-extended-command)
(setq anything-enable-shortcuts 'alphabet)

;; (setq anything-sources
;;       `(
;;         ;; anything-c-source-git-project-for-modified
;;         anything-c-source-buffers
;;         anything-c-source-files-in-current-dir       ;; カレントディレクトディレクトリにあるファイル
;;         anything-c-source-file-name-history          ;; ファイル開いた履歴
;;         anything-c-source-recentf                    ;; 最近開いたファイル
;;         anything-c-source-locate
;;         anything-c-source-bookmarks                  ;; bookmark
;;         anything-c-source-info-pages               ;; infoマニュアルを参照する
;;         ;; anything-c-source-man-pages                  ; manページ。なんかすげー重いんだけど
;; ;;        anything-c-source-occur                      ;;
;; ;;        anything-c-source-emacs-commands           ;; emacsコマンドを実行する
;;         anything-c-source-emacs-functions          ;; emacs関数を検索する
;; ;;        anything-c-source-complex-command-history  ;; コマンド履歴の一覧
;; ;;        anything-c-source-info-elisp
;;         ;; anything-c-source-gtags-select
;;         ))

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

(when (require 'anything-c-moccur)
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


(dolist (elt '(("modified" "Modified files (%s)" "--modified")
               ("untracked" "Untracked files (%s)" "--others --exclude-standard")
               ("all" "All controlled files in this project (%s)" "")))
  (destructuring-bind (suffix name options) elt
    (eval `(defvar ,(intern (concat "anything-c-source-git-project-for-" suffix))
             `((name . ,(format name default-directory))
               (init . (lambda ()
                         (unless (and ,(string= options "") ;update candidate buffer every time except for that of all project files
                                      (anything-candidate-buffer))
                           (with-current-buffer
                               (anything-candidate-buffer 'global)
                             (insert
                              (shell-command-to-string
                               ,(format "git ls-files $(git rev-parse --show-cdup) %s"
                                        options)))))))
               (candidates-in-buffer)
               (type . file))
             ))))

(defun anything-git-project ()
  (interactive)
  (let ((sources '(anything-c-source-git-project-for-modified
                   ;; anything-c-source-git-project-for-untracked
                   anything-c-source-git-project-for-all)))
    (anything-other-buffer sources
     (format "*Anything git project in %s*" default-directory))))

(define-key global-map (kbd "C-+") 'anything-git-project)


(when (require 'anything-gtags)
  ;; imenu, gtags, perlのgtagsから読み込み
  (defun anything-gtags-select-all ()
    (interactive)
    (anything-other-buffer
     '(anything-c-source-imenu
       anything-c-source-gtags-select
       ;; anything-c-source-gtags-select-with-home-perl-lib
       )
     "*anything gtags*"))

  (defun anything-gtags-from-here ()
    (interactive)
    (anything
     :sources '(anything-c-source-imenu
                anything-c-source-gtags-select
                ;; anything-c-source-gtags-select-with-home-perl-lib
                )
     :input (thing-at-point 'symbol)
     ;; :preselect (thing-at-point 'symbol)
     ))
  ;; (define-key global-map (kbd "C-*") 'anything-gtags-from-here)
  )

(defvar anything-c-sources-local-gem-file
  '((name . "gems (local)")
    (candidates-in-buffer)
    (init . (lambda ()
              (unless (anything-candidate-buffer)
                (call-process-shell-command
                 "gem list" nil (anything-candidate-buffer 'global)
                 ))))
    (action . (lambda (gem-name)
                (setq gem-name (replace-regexp-in-string "\s+(.+)$" "" gem-name))
                (with-temp-buffer
                  (call-process "gem" nil t nil "which" gem-name)
                  (let ((path (buffer-substring-no-properties (point-min)
                                                              (- (point-max) 1))))
                    (if (file-exists-p path)
                        (find-file path)
                      (message "no such file or directory:\"%s\"" path))))
                ))))

(defun anything-local-gems ()
  (interactive)
  (anything-other-buffer
   '(anything-c-sources-local-gem-file)
   "*anything local gems*"
  ))
