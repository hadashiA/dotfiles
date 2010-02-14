;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ruby-mode
;; http://pub.cozmixng.org/~the-rwiki/rw-cgi.rb?cmd=view;name=Emacs
(add-to-load-path "~/.emacs.d/elisp/ruby-mode/")

(require 'ruby-mode)
(autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")

(setq auto-mode-alist
      (append '(
                ("\\.rb$"   . ruby-mode)
                ("Rakefile" . ruby-mode)
                ("\\.rake$" . ruby-mode)
                ("\\.rjs"   . ruby-mode)
                ("\\.rash"  . ruby-mode)
                ) auto-mode-alist))

(setq interpreter-mode-alist
      (append '(
                ("ruby" . ruby-mode)
                )
              interpreter-mode-alist))

;; 深いインデントを避ける
(setq ruby-deep-indent-paren-style nil)

;; よくあるコードを、自動挿入する。
(require 'ruby-electric)

;; flymake-modeで補完する対象を追加
(push '(".+\\.rb$"   flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("Rakefile$"  flymake-ruby-init) flymake-allowed-file-name-masks)
(push '(".+\\.rake$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '(".+\\.rjs$"  flymake-ruby-init) flymake-allowed-file-name-masks)
(push '(".+\\.rash$" flymake-ruby-init) flymake-allowed-file-name-masks)

(add-hook 'ruby-mode-hook
          '(lambda ()
             (inf-ruby-keys)
             (ruby-electric-mode t)
             (abbrev-mode nil)
             (flymake-mode t)))

;; endに対応する行をハイライト
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)

;; Rinari
(add-to-load-path "~/.emacs.d/elisp/rinari/")
(require 'rinari)

;; rhtml-mode
(add-to-load-path "~/.emacs.d/elisp/rhtml-mode/")
(require 'rhtml-mode)
(setq auto-mode-alist (cons '("\\.erb$" . rhtml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.rhtml$" . rhtml-mode) auto-mode-alist))
(add-hook 'rhtml-mode-hook
  (lambda () (rinari-launch)))
