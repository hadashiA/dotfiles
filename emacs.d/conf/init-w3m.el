;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; emacs-w3m いんすとーる (CarbonEmacs & NTEmacs)
;; http://homepage.mac.com/matsuan_tamachan/software/EmacsW3m.html
;;
;; 
;; $ ./configure --with-addpath=~/.emacs.d/elisp/apel:~/.emacs.d/elisp/emu --with-lispdir=~/.emacs.d/elisp/emacs-w3m --with-icondir=~/.emacs.d/etc/emacs-w3m/icons --infodir=~/.emacs.d/info --with-emacs=/Applications/Emacs.app/Contents/MacOS/Emacs
;; $ make
;; $ sudo make install
;; $ sudo make install-icons

(setq w3m-coding-system 'utf-8
      w3m-file-coding-system 'utf-8
      w3m-file-name-coding-system 'utf-8
      w3m-input-coding-system 'utf-8
      w3m-output-coding-system 'utf-8
      w3m-terminal-coding-system 'utf-8)
(add-to-load-path "~/.emacs.d/elisp/emacs-w3m/")

;; emacs-w3m
(require 'w3m-load)

(autoload 'w3m-search "w3m-search" "Search QUERY using SEARCH-ENGINE." t)

;; GNU infoなキーバインドにする。
;;(setq w3m-key-binding 'info)

(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(global-set-key "\C-xm" 'browse-url-at-point)


;; Emacs でテキスト翻訳をする elisp - とりあえず暇だったし何となく始めたブログ
;;  http://d.hatena.ne.jp/khiker/20070503/emacs_text_translator
(add-to-load-path "~/.emacs.d/elisp/text-translator")
(require 'text-translator)
;; 自動選択に使用する関数を設定
(setq text-translator-auto-selection-func 'text-translator-translate-by-auto-selection-enja)

;;(global-set-key "\C-x\M-t" 'text-translator)
(global-set-key "\C-x\M-t" 'text-translator-translate-by-auto-selection-enja)
(global-set-key "\C-x\M-T" 'text-translator-all)
;;(global-set-key "\C-x\M-T" 'text-translator-translate-last-string)