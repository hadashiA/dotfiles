;; Emacs23 (Cocoa Emacs) 入門から中毒まで : 紹介マニア
;; http://sakito.jp/emacs/emacs23.html#id15
;; sakito / dot.emacs.d / source — Bitbucket
;; http://bitbucket.org/sakito/dot.emacs.d/src/tip/site-start.d/init_color.el

;;; フォントの設定
;; システム依存を排除するために一旦デフォルトフォントセットを上書き
;; 漢字は IPAゴジック + かな英数字は September を設定(等幅以外はインストールしてない)
;; jisx0208の範囲の漢字は September にすべきかもしれない
;; face の設定は基本的に全て color-thema に設定する方針
;; japanese-jisx0213.2004-1 = japanese-jisx0213-a + japanese-jisx0213-1
;; japanese-jisx0213-1 = japanese-jisx0208 のほぼ上位互換
;; japanese-jisx0213-2 = code-offset #x150000
;; japanese-jisx0212 = code-offset #x148000 
;; japanese-jisx0208 = code-offset #x140000
;; (set-face-attribute 'default
;;                     nil
;;                     ;; :family "September"
;;                     :family "MiuraLiner-\Jr"
;;                     :height 140)
;; (set-frame-font "September-14")
(set-frame-font "MiuraLiner-\Jr")
(set-fontset-font nil
                  'unicode
                  (font-spec :family "IPAexMincho")
                  ;; (font-spec :family "MiuraLiner-\Jr")
                  nil
                  'append)
;; 古代ギリシア文字、コプト文字を表示したい場合は以下のフォントをインストールする
;; http://apagreekkeys.org/NAUdownload.html
(set-fontset-font nil
                  'greek-iso8859-7
                  (font-spec :family "New Athena Unicode")
                  nil
                  'prepend)
;; 一部の文字を September にする
;; 記号         3000-303F http://www.triggertek.com/r/unicode/3000-303F
;; 全角ひらがな 3040-309f http://www.triggertek.com/r/unicode/3040-309F
;; 全角カタカナ 30a0-30ff http://www.triggertek.com/r/unicode/30A0-30FF
(set-fontset-font nil
                  '( #x3000 .  #x30ff)
                  ;; (font-spec :family "September")
                  (font-spec :family "September-14")
                  nil
                  'prepend)
;; 半角カタカナ、全角アルファベット ff00-ffef http://www.triggertek.com/r/unicode/FF00-FFEF
(set-fontset-font nil
                  '( #xff00 .  #xffef)
                  ;; (font-spec :family "September")
                  ;; (font-spec :family "September-14")
                  (font-spec :family "MiuraLiner-\Jr" :size 16)
                  nil
                  'prepend)

;; 等幅のフォントセットを幾つか作成予定

(when (find-font (font-spec :family "Menlo"))
  ;; ヒラギノ 角ゴ ProN + Menlo
  (create-fontset-from-ascii-font "Menlo-14" nil "menlokakugo")
  (set-fontset-font "fontset-menlokakugo"
                    'unicode
                    (font-spec :family "Hiragino Kaku Gothic ProN" :size 16))
  ;; 確認用 (set-frame-font "fontset-menlokakugo")
  ;; (add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))  ;; 実際に設定する場合
  )
