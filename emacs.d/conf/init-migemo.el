;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; Migemo
;; http://www4.kcn.ne.jp/~boochang/emacs/migemo.html
;;
;; (when (require 'migemo nil t)
;;   (setq migemo-use-pattern-alist t)
;;   (setq migemo-use-frequent-pattern-alist t)
;;   (setq migemo-pattern-alist-length 1000)
;;   (setq migemo-use-frequent-pattern-alist t)
;;   (migemo-init))

;; Kaoriya C/Migemo
;; http://www.kaoriya.net/#CMIGEMO
;;
;; Making The Road Wiki - 開発環境::Emacs::C/Migemo
;; http://ik.am/yukiwiki/wiki.cgi?%E9%96%8B%E7%99%BA%E7%92%B0%E5%A2%83%3A%3AEmacs%3A%3AC%2FMigemo
;;
;; svn export http://cvs.kaoriya.net/svn/CMigemo/branches/dev-1_3 cmigemo
;; cd cmigemo
;; ./configure
;; make osx
;; make osx-dict
;; cd dict
;; make utf-8
;; cd ..
;; ./build/cmigemo -d dict/utf-8.d/migemo-dict
;; sudo make osx-install

(let ((migemo-dir "/usr/local/share/migemo"))
  (setq load-path (append load-path (list migemo-dir)))
  (setq migemo-command "cmigemo")
  (setq migemo-options '("-q" "--emacs" "-i" "\a"))
  (setq migemo-dictionary (format "%s/utf-8/migemo-dict" migemo-dir))
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-use-pattern-alist t)
  (setq migemo-use-frequent-pattern-alist t)
  (setq migemo-pattern-alist-length 1024)
  (setq migemo-coding-system 'utf-8-unix)
  (load-library "migemo")
  (migemo-init)
  )
