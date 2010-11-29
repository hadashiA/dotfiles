;;; genkou.el --- minor mode for Japanese manuscript

;; Copyright (C) 2009  Takeshi Miura

;; Author: Takeshi Miura <info@miura-takeshi.com>
;; Keywords: wp

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; 四百字詰め原稿用紙換算枚数をモード行に表示するマイナーモードです。

;; インストール：
;; 1. このファイルを load-path の通ったディレクトリにコピーします。
;; 2. .emacs に以下の設定を追加します。
;;    (autoload 'genkou-mode "genkou" "minor mode for Japanese manuscript." t)

;; 使い方：
;; M-x genkou-mode で genkou-mode (マイナーモード) になります。
;; genkou-mode になると "genkou" という項目がメニューに追加されます。
;; メニューコマンドの内容は以下の通りです。
;; "400字換算"         モード行の四百字換算枚数を更新します。
;; "保存して400字換算" バッファを保存してモード行の四百字換算枚数を更新します。
;;                     C-x C-s にバインドすると保存するたびに枚数を確認できます。
;; "TeXにエクスポート" TeX ファイルにエクスポートします。
;;                     単に改行位置に "\\" を挿入しているだけで、
;;                     A4、横用紙、縦書き固定です。
;;                     拡張子が小文字の txt の時だけこのコマンドは使えます。
;; "プレビュー"        四百字詰め原稿用紙の字詰めをプレビューします。

;; キーバインド設定例：
;; (add-hook 'genkou-mode-hook
;;           '(lambda ()
;;              (define-key genkou-mode-map "\C-x\C-s" 'genkou-save)))

;; var 0.1 [2009-10-04]

;;; Code:

(easy-mmode-define-minor-mode
 genkou-mode "minor mode for Japanese manuscript." nil " 原稿" (make-sparse-keymap))

(add-hook 'genkou-mode-hook 'genkou-toggle)

(defvar genkou-char-num nil)
(defvar genkou-line-num nil)
(defvar genkou-page-num nil)
(defvar genkou-mode-line-string nil)
(defvar genkou-extension "^\\(.+\\)\.txt$")

(defun genkou-init ()
  "変数の初期化"
  (setq genkou-char-num 0)
  (setq genkou-line-num 1)
  (setq genkou-page-num 1))

;; ポイント位置の文字をチェックしたかで genkou-char-num の値が変わる
;; "\n" は次の文字を次の文字をチェックする必要があるので genkou-char-num の値は 0
(defun genkou-line-count ()
  "行数カウント"
  (cond
   ((looking-at "\n")
    (setq genkou-line-num (+ genkou-line-num 1))
    (setq genkou-char-num 0))
   ((= genkou-char-num 18)
    (cond
     ((looking-at ".「")
      (setq genkou-line-num (+ genkou-line-num 1))
      (setq genkou-char-num 1))
     ((looking-at ".[！？]」")
      (setq genkou-line-num (+ genkou-line-num 1))
      (setq genkou-char-num 1))
     (t
      (setq genkou-char-num (+ genkou-char-num 1)))))
   ((= genkou-char-num 19)
    (cond
     ((looking-at ".[！？」々ぁぃぅぇぉっゃゅょァィゥェォッャュョ]")
      (setq genkou-line-num (+ genkou-line-num 1))
      (setq genkou-char-num 1))
     (t
      (setq genkou-char-num (+ genkou-char-num 1)))))
   ((> genkou-char-num 19)
    (cond
     ((looking-at "[。、　]")
      (setq genkou-char-num (+ genkou-char-num 1)))
     (t
      (setq genkou-line-num (+ genkou-line-num 1))
      (setq genkou-char-num 1))))
   (t (setq genkou-char-num (+ genkou-char-num 1)))))

(defun genkou-page-count ()
  "枚数カウント"
  (if (> genkou-line-num 20)
      (progn
        (setq genkou-page-num (+ genkou-page-num 1))
        (setq genkou-line-num 1))))

(defun genkou-mode-line ()
  "モードラインを書き換える"
  (let ((tmp-list))
    (setq genkou-mode-line-string
          (format "%d枚%d行" genkou-page-num genkou-line-num))
    (make-local-variable 'mode-line-format)
    (setq tmp-list (copy-sequence default-mode-line-format))
    (setq mode-line-format
          (append
           (delete "-%-" tmp-list)
           (append (list genkou-mode-line-string) (member "-%-" default-mode-line-format))))
    (force-mode-line-update)))

(defun genkou-toggle ()
  "モード行をトグルする"
  (if genkou-mode
      (genkou-count)
    (progn
      (setq mode-line-format default-mode-line-format)
      (force-mode-line-update))))

(defun genkou-count ()
  "４００字詰め原稿用紙換算枚数を計算してモード行を更新"
  (interactive)
  (genkou-init)
  (save-excursion
    (goto-char (point-min))
    (while (not (eobp))
      (genkou-line-count)
      (genkou-page-count)
      (forward-char))
    (genkou-mode-line)))

(defun genkou-count-preview ()
  "デバッグ用コマンド"
  (interactive)
  (let ((tmp-line)
        (tmp-page)
        (buf-org (current-buffer))
        (tmp-buf (get-buffer-create "*genkou-mode-temp-buffer*")))
    (genkou-init)
    (set-buffer tmp-buf)
    (erase-buffer)
    (insert-buffer-substring buf-org)
    (goto-char (point-min))
    (insert (format "------------------%04d------------------\n" genkou-page-num))
    (while (not (eobp))
      (setq tmp-line genkou-line-num)
      (genkou-line-count)
      (if (/= tmp-line genkou-line-num)
          ;; 改行で行数が変わる場合は "\n" を挿入しない
          ;; 文字数が変わっているわけではないので、問題ないと思う
          (if (not (looking-at "\n"))
              (insert "\n")))
      (setq tmp-page genkou-page-num)
      (genkou-page-count)
      (if (/= tmp-page genkou-page-num)
          ;; 改行で行数が変わって枚数が変わる場合、挿入する "\n" の位置を変える
          ;; 文字数が変わっているわけではないので、問題ないと思う
          (if (looking-at "\n")
              (insert (format "\n------------------%04d------------------" genkou-page-num))
            (insert (format "------------------%04d------------------\n" genkou-page-num))))
      (forward-char))
    (goto-char (point-min))
    (display-buffer tmp-buf)
    (genkou-mode-line)))

(defun genkou-save ()
  "バッファを保存する時に枚数を数える"
  (interactive)
  (save-buffer)
  (genkou-count))

(defun genkou-txtp ()
  "拡張子が txt だったら拡張子抜きのファイル名を返す それ以外は nil"
  (let ((path-txt (buffer-file-name (current-buffer))))
    (if (string-match "^\\(.+\\)\.txt$" path-txt)
        (match-string 1 path-txt)
      nil)))

(defun genkou-tex-export ()
  "テキストをTeXにエクスポート"
  (interactive)
  (let ((buf-org (current-buffer))
        (path-tex)
        (temp-buf))
    (if (setq path-tex (genkou-txtp))
        (progn
          (setq path-tex (concat path-tex ".tex"))
          (setq temp-buf
                (generate-new-buffer "*genkou-mode-temp-buffer*"))
          (set-buffer temp-buf)
          (setq buffer-file-name path-tex)
          (insert-buffer-substring buf-org)
          (goto-char (point-min))
          (perform-replace "\\([？！]\\)　" "\\1" nil t nil)
          (goto-char (point-min))
          (perform-replace "\n" "\\\\\\\\\n" nil t nil)
          (goto-char (point-min))
          (insert "\\documentclass[a4j,landscape,12pt]{tarticle}\n\\begin{document}\n\\noindent")
          (goto-char (point-max))
          (insert "\\end{document}\n")
          (set-buffer-file-coding-system 'shift_jis-dos)
          (save-buffer)
          (kill-buffer temp-buf)
          )
      (message "拡張子を小文字のtxtにしてください"))))

;; メニュー

(require 'easymenu)

(defvar genkou-menu
  '("Genkou"
    ["400字換算" genkou-count t]
    ["保存して400字換算" genkou-save t]
    ["-----" nil nil]
    ["TeXにエクスポート" genkou-tex-export (genkou-txtp)]
    ["プレビュー" genkou-count-preview t]
    ))

(easy-menu-define
  genkou-menu-map
  genkou-mode-map
  "Menu for genkou-mode."
  genkou-menu)

(provide 'genkou)
;;; genkou.el ends here
