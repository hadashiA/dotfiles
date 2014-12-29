;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(byte-recompile-directory "~/.emacs.d/elisp/")
(byte-recompile-directory "~/.emacs.d/conf/")
;; (require 'isearch)

;; 実行環境を判別する。
;; http://d.hatena.ne.jp/hito-d/20060220#1140445790

;; OSを判別
(defvar run-unix
  (or (equal system-type 'gnu/linux)
      (or (equal system-type 'usg-unix-v)
          (or  (equal system-type 'berkeley-unix)
               (equal system-type 'cygwin)))))

(defvar run-linux
  (equal system-type 'gnu/linux))
(defvar run-system-v
  (equal system-type 'usg-unix-v))
(defvar run-bsd
  (equal system-type 'berkeley-unix))
(defvar run-cygwin ;; cygwinもunixグループにしておく
  (equal system-type 'cygwin))
(defvar run-w32
  (and (null run-unix)
       (or (equal system-type 'windows-nt)
           (equal system-type 'ms-dos))))

(defvar run-darwin (equal system-type 'darwin))

;; Emacsenの種類とヴァージョンを判別
(defvar run-emacs20
  (and (equal emacs-major-version 20)
       (null (featurep 'xemacs))))
(defvar run-emacs21
  (and (equal emacs-major-version 21)
       (null (featurep 'xemacs))))
(defvar run-emacs22
  (and (equal emacs-major-version 22)
       (null (featurep 'xemacs))))
(defvar run-meadow (featurep 'meadow))
(defvar run-meadow1 (and run-meadow run-emacs20))
(defvar run-meadow2 (and run-meadow run-emacs21))
(defvar run-meadow3 (and run-meadow run-emacs22))
(defvar run-xemacs (featurep 'xemacs))
(defvar run-xemacs-no-mule
  (and run-xemacs (not (featurep 'mule))))
(defvar run-carbon-emacs (and run-darwin window-system))

(eval-when-compile (require 'cl))

;; ユーティリティ関数

;; 引数をload-pathへ追加する
(defun add-to-load-path (&rest paths)
  (mapc '(lambda (path)
           (add-to-list 'load-path path))
        (mapcar 'expand-file-name paths)))

;; eval-safe
;; 安全な評価。評価に失敗してもそこで止まらない。
;; http://www.sodan.org/~knagano/emacs/dotemacs.html#eval-safe
(defmacro eval-safe (&rest body)
  `(condition-case err
       (progn ,@body)
     (error (message "[eval-safe] %s" err))))

;; dot.emacs
;; http://www.sodan.org/~knagano/emacs/dotemacs.html
(defun autoload-if-found (function file &optional docstring interactive type)
  "set autoload iff. FILE has found."
  (and (locate-library file)
       (autoload function file docstring interactive type)))


;; elispと設定ファイルのディレクトリをload-pathに追加
(add-to-load-path "~/.emacs.d/elisp"
                  "~/.emacs.d/conf")

;; apel, emuをロードパスに追加
;; w3mかなんかで使う。
;; (add-to-load-path "~/.emacs.d/elisp/emu"
;;                   "~/.emacs.d/elisp/apel")

;; (when (require 'auto-install)
;;   (setq auto-install-directory "~/.emacs.d/elisp/"))
;; (auto-install-update-emacswiki-package-name t)
;;(auto-install-compatibility-setup)

(require 'generic-x)

(setq default-tab-width 4)

;; 個別の設定をロードしまくりパート

(load "init-env")
(load "init-color")
(load "init-shell")
(load "init-package")
(load "init-window")
(load "init-remaps")

;; Emacs feature settings
(load "init-minibuf")
(load "init-killring")
(load "init-dired")
(load "init-ffap")

;; Global extensions
(load "init-smartparens")
(load "init-point-undo")
(load "init-highlighting")
(load "init-expand-region")
(load "init-foreign-regexp")
(load "init-smartchr")
(load "init-junk-file")
(load "init-vimlike")
(load "init-jump")
;; (load "init-migemo")

;; Coding 
(load "init-skk")
(load "init-flycheck")
(load "init-yasnippet")
(load "init-auto-complete")
(load "init-autosave-buffers")
(load "init-helm")
(load "init-tags")
(load "init-testkick")

;; Web interface
(load "init-sdic")
(load "init-translate")
;; (load "init-w3m")
(load "init-twitter")

;; Major modes
(load "init-vcs")
(load "init-markdown")
(load "init-html")
(load "init-css")
(load "init-javascript")
(load "init-coffee")
(load "init-cc")
(load "init-glsl")
(load "init-ruby")
(load "init-puppet")
(load "init-python")
(load "init-php")
(load "init-sql")
(load "init-lisp")
(load "init-yaml")
(load "init-genkou")

;; Meadow用設定を読み込む
(when (and run-w32 run-meadow)
  (load "init-meadow"))

;; Mac用設定を読み込む
(when run-darwin
  (load "init-mac"))

;; Linux
(when run-linux
  (load "init-linux"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rspec-spec-command "rspec")
 '(rspec-use-rake-flag nil)
 '(rspec-use-rvm t)
 '(safe-local-variable-values (quote ((encoding . utf-8) (encoding . UTF-8) (Coding . utf-8) (ruby-compilation-executable . "ruby") (ruby-compilation-executable . "ruby1.8") (ruby-compilation-executable . "ruby1.9") (ruby-compilation-executable . "rbx") (ruby-compilation-executable . "jruby")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "#272822" :foreground "#F8F8F2" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 110 :width normal))))
 '(cursor ((t (:background "#F8F8F2" :foreground "#272822"))))
 '(font-lock-comment-face ((((class color) (min-colors 88) (background dark)) (:foreground "#75715E"))))
 '(font-lock-function-name-face ((((class color) (min-colors 88) (background dark)) (:foreground "#A6E22E"))))
 '(font-lock-keyword-face ((((class color) (min-colors 88) (background dark)) (:foreground "#F92672"))))
 '(font-lock-preprocessor-face ((t (:inherit font-lock-builtin-face :foreground "#66d9ef"))))
 '(font-lock-string-face ((((class color) (min-colors 88) (background dark)) (:foreground "#E6DB74"))))
 '(font-lock-type-face ((((class color) (min-colors 88) (background dark)) (:foreground "#66d9ef"))))
 '(font-lock-variable-name-face ((((class color) (min-colors 88) (background dark)) (:foreground "#FD971F"))))
 '(region ((((class color) (min-colors 88) (background dark)) (:background "#49483E"))))
 '(show-paren-match ((((class color) (background dark)) (:background "#3E3D32"))))
 '(variable-pitch ((t (:family "DejaVu Sans")))))
(put 'narrow-to-region 'disabled nil)


 
;; 日本語
(set-fontset-font
 nil 'japanese-jisx0208
 ;; (font-spec :family "Hiragino Mincho Pro")) ;; font
 (font-spec :family "Hiragino Kaku Gothic ProN")) ;; font
 
;; 半角と全角の比を1:2に
(setq face-font-rescale-alist
      '((".*Hiragino_Mincho_pro.*" . 1.2)))
