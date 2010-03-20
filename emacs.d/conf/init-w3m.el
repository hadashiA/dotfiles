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
;; (setq w3m-key-binding 'info)

(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(global-set-key "\C-xm" 'browse-url-at-point)
