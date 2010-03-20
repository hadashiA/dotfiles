
;; Emacs でテキスト翻訳をする elisp - とりあえず暇だったし何となく始めたブログ
;;  http://d.hatena.ne.jp/khiker/20070503/emacs_text_translator
(add-to-load-path "~/.emacs.d/elisp/text-translator")
(when (require 'text-translator nil t)
  ;; 自動選択に使用する関数を設定
  (setq text-translator-auto-selection-func 'text-translator-translate-by-auto-selection-enja)

  ;; text-translator.elで英語・日本語を自動判別しつつすべての翻訳エンジンで検索するパッチ - (rubikitch loves (Emacs Ruby CUI))
  ;; http://d.hatena.ne.jp/rubikitch/20100228/translator

  (global-set-key "\C-x\M-T" 'text-translator-translate-by-auto-selection)
  (global-set-key "\C-x\M-t" 'text-translator-all-by-auto-selection))









