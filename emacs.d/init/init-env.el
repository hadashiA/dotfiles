;; exec-path, PATHの追加
(let* ((pathenv (replace-regexp-in-string "[\r\n]+$" "" (shell-command-to-string "/usr/bin/env zsh -c 'printenv PATH'")))
       (pathlst (split-string pathenv ":")))
  (setq exec-path pathlst)
  (setq eshell-path-env pathenv)
  (setenv "PATH" pathenv))

;; スタートアップ時のメッセージを抑制
(setq inhibit-startup-message t)

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


;; メニューバー、ツールバー非表示
(eval-safe (menu-bar-mode 0))
(eval-safe (tool-bar-mode 0))

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

;; シフト + 矢印で範囲選択
;; (setq pc-select-selection-keys-only t)
;; (pc-selection-mode 1)

;; インデントはスペースで
(setq-default indent-tabs-mode nil)

;; 改行と同時にインデント
(global-set-key "\C-m" 'newline-and-indent)
;; (global-set-key "\C-m" 'comment-indent-new-line)

;; バッファにファイルをドラッグドロップした際のファイルをinsertする動作に変更されている。
;; (define-key global-map [ns-drag-file] 'ns-insert-file)
;; Emacs22の時の動作は find-fileですので同じにするには以下を .emacs に記述します
(define-key global-map [ns-drag-file] 'ns-find-file)

(setq dnd-open-file-other-window nil)

;; 個人用infoディレクトリを追加
(setq Info-default-directory-list
      (cons (expand-file-name "~/.emacs.d/info/") Info-default-directory-list))

(turn-off-auto-fill)

;; ファイルの末尾にかいぎょうを付加しない
(setq require-final-newline nil)

;; 記号やその他の文字等を正しくマッピングする
;; Emacs辞典p.395
;; http://www.pqrs.org/~tekezo/emacs/doc/wide-character/index.html
;;(utf-translate-cjk-set-unicode-range
;; '((#x00a2 . #x00a3)
;;   (#x00a7 . #x00a8)
;;   (#x00ac . #x00ac)
;;   (#x00b0 . #x00b1)
;;   (#x00b4 . #x00b4)
;;   (#x00b6 . #x00b6)
;;   (#x00d7 . #x00d7)
;;   (#X00f7 . #x00f7)
;;   (#x0370 . #x03ff)
;;   (#x0400 . #x04FF)
;;   (#x2000 . #x206F)
;;   (#x2100 . #x214F)
;;   (#x2190 . #x21FF)
;;   (#x2200 . #x22FF)
;;   (#x2300 . #x23FF)
;;   (#x2500 . #x257F)
;;   (#x25A0 . #x25FF)
;;   (#x2600 . #x26FF)
;;   (#x2e80 . #xd7a3)
;;   (#xff00 . #xffef)))
