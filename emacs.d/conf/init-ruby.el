;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-
;; ruby-mode
;; http://pub.cozmixng.org/~the-rwiki/rw-cgi.rb?cmd=view;name=Emacs
(add-to-load-path "~/.emacs.d/elisp/ruby-mode/")

(require 'ruby-mode)

;; magickコメントを入れない
(defun ruby-mode-set-encoding () ())

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

;; よくあるコードを、自動挿入する。
(require 'ruby-electric)

;; endに対応する行をハイライト
(require 'ruby-block)

;; rcodetools
;; (add-to-load-path "~/.emacs.d/elisp/rcodetools/")
;; (require 'rcodetools)
;; (setq rct-find-tag-if-available nil)
;; (defun ruby-mode-hook-rcodetools ()
;;   (define-key ruby-mode-map "\M-\C-i" 'rct-complete-symbol)
;;   (define-key ruby-mode-map "\C-c\C-t" 'ruby-toggle-buffer)
;;   (define-key ruby-mode-map "\C-c\C-d" 'xmp)
;;   (define-key ruby-mode-map "\C-c\C-f" 'rct-ri))
;; (add-hook 'ruby-mode-hook 'ruby-mode-hook-rcodetools)

;; flymake-modeで補完する対象を追加
(push '(".+\\.rb$"   flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("Rakefile$"  flymake-ruby-init) flymake-allowed-file-name-masks)
(push '(".+\\.rake$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '(".+\\.rjs$"  flymake-ruby-init) flymake-allowed-file-name-masks)
(push '(".+\\.rash$"  flymake-ruby-init) flymake-allowed-file-name-masks)

(add-hook 'ruby-mode-hook
          '(lambda ()
             (ruby-electric-mode t)
             (ruby-block-mode t)
             (inf-ruby-keys)
             (abbrev-mode nil)
             (setq ruby-block-highlight-toggle t)
             (flymake-mode t)))

;; Rinari: Ruby on Rails Minor Mode for Emacs:  http://rinari.rubyforge.org/
(add-to-load-path "~/.emacs.d/elisp/rinari/")
(require 'rinari)
;; (add-hook 'rails-mode-hook
;;           '(lambda ()
             (global-set-key "\C-c;c" 'rinari-find-controller)
             (global-set-key "\C-c;e" 'rinari-find-environment)
             (global-set-key "\C-c;f" 'rinari-find-file-in-project)
             (global-set-key "\C-c;h" 'rinari-find-helper)
             (global-set-key "\C-c;v" 'rinari-find-view)
             (global-set-key "\C-c;i" 'rinari-find-migration)
             (global-set-key "\C-c;j" 'rinari-find-javascript)
             (global-set-key "\C-c;p" 'rinari-find-plugin)
             (global-set-key "\C-c;m" 'rinari-find-model)
             (global-set-key "\C-c;n" 'rinari-find-configuration)
             (global-set-key "\C-c;l" 'rinari-find-lib)
             (global-set-key "\C-c;s" 'rinari-find-stylesheet);;))

;; rinari-extend-by-emacs-rails
;; (setq rails-tags-dirs '("app" "lib" "test" "db" "vendor"))
;; (require 'rinari-extend-by-emacs-rails)
;; (defun ruby-mode-hooks-rinari-extend ()
;;   (define-key ruby-mode-map (kbd "<C-f1>") 'rails-search-doc)
;;   (define-key ruby-mode-map [f1] 'rails-search-doc-at-point)
;; )
;; (defun rinari-mode-hooks-rinari-extend ()
;;   (define-key rinari-minor-mode-map "\C-c\C-t" 'rails-create-tags)
;; )
;; (add-hook 'ruby-mode-hook 'ruby-mode-hooks-rinari-extend)
;; (add-hook 'rinari-mode-hook 'rinari-mode-hooks-rinari-extend)

;; rhtml-mode
(add-to-load-path "~/.emacs.d/elisp/rhtml-mode/")
(require 'rhtml-mode)
(setq auto-mode-alist (cons '("\\.erb$" . rhtml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.rhtml$" . rhtml-mode) auto-mode-alist))
(add-hook 'rhtml-mode-hook
  (lambda () (rinari-launch)))

;; readgem
(defun search-gem-path (name)
  (shell-command-to-string
    (format "gem which %s | ruby -n -e 'if /lib/; print $_[0, $_.rindex(%%[lib])]; end'" name)))
(defun find-ruby-gem (name)
  (interactive "sRuby gem libraray name: ")
  (find-file (search-gem-path name)))

;; Reference
;;(equire 'refe)

;; Rspec
(require 'rspec-mode)

