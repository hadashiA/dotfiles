;; スタートアップ時のメッセージを抑制
(setq inhibit-startup-message t)

(when window-system
 (menu-bar-mode 0)
 (tool-bar-mode 0))

;; エンコーディングは基本的にUTF-8
;; (add-hook 'set-language-environment-hook 
;; 	  (lambda ()
;; 	    (when (equal "ja_JP.UTF-8" (getenv "LANG"))
;; 	      (setq default-process-coding-system '(utf-8 . utf-8))
;; 	      (setq default-file-name-coding-system 'utf-8))
;; 	    (when (equal "Japanese" current-language-environment)
;; 	      (setq default-buffer-file-coding-system 'iso-2022-jp))))
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))
(setq default-file-name-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setenv "LANG" "ja_JP.UTF-8")

;; ヴィジブルベルを抑制
(setq visible-bell nil)

;; ビープ音を抑制
(setq ring-bell-function '(lambda ()))

;; カーソルの点滅を抑制
(blink-cursor-mode 0)

;; 行数、列数を表示
(line-number-mode t)
(column-number-mode t)

;; バックアップしない
(setq make-backup-files nil)

;; 自動保存したファイルを削除する。
(setq delete-auto-save-files t)

;; 自動セーブしない。
(setq auto-save-default nil)

;; yes/noを、y/nで選択できるようにする。
(fset 'yes-or-no-p 'y-or-n-p)

;; kill-lineで行末の改行文字も削除
(setq kill-whole-line t)

;; リージョンをC-hで削除
;;(delete-selection-mode 1)

(transient-mark-mode t)

;; シフト + 矢印で範囲選択
;; (setq pc-select-selection-keys-only t)
;; (pc-selection-mode 1)

;; インデントはスペースで
(setq-default indent-tabs-mode nil)
(setq default-tab-width 4)

;; 改行と同時にインデント
(global-set-key "\C-m" 'newline-and-indent)
;; (global-set-key "\C-m" 'comment-indent-new-line)

;; バッファにファイルをドラッグドロップした際のファイルをinsertする動作に変更されている。
;; (define-key global-map [ns-drag-file] 'ns-insert-file)
;; Emacs22の時の動作は find-fileですので同じにするには以下を .emacs に記述します
;; (define-key global-map [ns-drag-file] 'ns-find-file)

(setq dnd-open-file-other-window nil)

;; 個人用infoディレクトリを追加
(setq Info-default-directory-list
      (cons (expand-file-name "~/.emacs.d/info/") Info-default-directory-list))

(turn-off-auto-fill)

;; ファイルの末尾に改行を付加しない
(setq require-final-newline nil)

;; 半角と全角の比を1:2に
(setq face-font-rescale-alist
      '((".*Hiragino_Mincho_pro.*" . 1.2)))


;; C-hをBackSpaceに
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\C-x?" 'help-command)

;; C-x C-iでリージョンをインデント
(global-set-key "\C-x\C-i" 'indent-region)

;; C-x ?でヘルプ
(global-set-key "\C-x?" 'help)

;; C-x uで全置引数
(global-set-key "\C-xu" 'universal-argument)

;; C-c C-iでインフォを引く
(global-set-key "\C-c\C-i" 'info-lookup-symbol)

;; [2008-03-13]
;; Teaminal.app上ではダメ。

;; M-< M-> の代わりに C-< C-> を使う
(global-set-key (kbd "C-<") 'beginning-of-buffer)
(global-set-key (kbd "C->") 'end-of-buffer)

;; キーボードレイアウトをカスタマイズして、[をCtrl、 ]をMetaにしてるの
;; M-} と M-{ を再設定
(global-set-key "\M-9" 'forward-paragraph)
(global-set-key "\M-8" 'backward-paragraph)

;; shellっぽいところで、C-n/pでヒストリ
;;(define-key comint-mode-map "\C-p" 'comint-previous-input)
;;(define-key comint-mode-map  "\C-n" 'comint-next-input)

(global-set-key "\M-n" 'forward-list)
(global-set-key "\M-p" 'backward-list)

(global-set-key "\C-c\C-a" 'align)

;;
;; Packages (straight.el)
;;

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq package-enable-at-startup nil)

(straight-use-package 'use-package)

(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/.emacs.d/init")
;; (add-to-list 'load-path "~/.emacs.d/el-get/el-get")

;;
;; Configurations each packages
;;

(recentf-mode)
(load "init-server")
(load "init-color")
(load "init-shell")
(load "init-autosave")
(load "init-ffap")
(load "init-window")
(load "init-killring")
(load "init-highlighting")
(load "init-vimlike")
(load "init-dired")
(load "init-consult")
(load "init-vertico")
(load "init-multiple-cursors")
(load "init-generic-x")
(load "init-markdown")
(load "init-yaml")
