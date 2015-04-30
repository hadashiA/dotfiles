;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'generic-x)
(setq default-tab-width 4)

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


(add-to-load-path "~/.emacs.d/elisp"
                  "~/.emacs.d/init"
                  "~/.emacs.d/el-get/el-get")
;;
;; Standard Settings
;;

(load "init-env")
(load "init-color")
(load "init-shell")
(load "init-ffap")
(load "init-remaps")
(load "init-window")
(load "init-minibuf")
(load "init-killring")
(load "init-ffap")
(load "init-highlighting")
(load "init-vimlike")
(load "init-dired")
(load "init-minibuf")

(load "init-cc")
(load "init-genkou-mode")

;; Meadow用設定を読み込む
(when (and run-w32 run-meadow)
  (load "init-meadow"))

;; Mac用設定を読み込む
(when run-darwin
  (load "init-mac"))

;; Linux
(when run-linux
  (load "init-linux"))
 
;; 半角と全角の比を1:2に
(setq face-font-rescale-alist
      '((".*Hiragino_Mincho_pro.*" . 1.2)))

;;
;; packages
;;

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/recipes")
(setq el-get-user-package-directory (locate-user-emacs-file "init"))

(el-get-bundle smartrep
  :features smartrep)
(el-get-bundle mcomplete
  :type github
  :pkgname "emacsmirror/mcomplete"
  :features mcomplete)
(el-get-bundle session)
(el-get-bundle smartparens)
(el-get-bundle auto-save-buffers-enhanced
  :type github
  :pkgname "kentaro/auto-save-buffers-enhanced")
(el-get-bundle point-undo
  :type github
  :pkgname "emacsmirror/point-undo")
(el-get-bundle undo-tree)
(el-get-bundle undohist
  :features undohist)
(el-get-bundle expand-region)
(el-get-bundle foreign-regexp
  :type github
  :pkgname "k-talo/foreign-regexp.el")
(el-get-bundle smartchr)
(el-get-bundle rainbow-delimiters)
(el-get-bundle open-junk-file)
(el-get-bundle ace-jump-mode)
(el-get-bundle ddskk)
(el-get-bundle flycheck)
(el-get-bundle go-flymake
  :features go-flycheck)
(el-get-bundle dropdown-list
  :features dropdown-list)
(el-get-bundle yasnippet)
(el-get-bundle pos-tip)
(el-get-bundle go-autocomplete
  :features go-autocomplete)
(el-get-bundle auto-complete)
(el-get-bundle auto-complete-ya-gtags
  :type github
  :pkgname "whitypig/auto-complete-ya-gtags"
  :features auto-complete-ya-gtags)
(el-get-bundle gtags)
(el-get-bundle git-gutter)
(el-get-bundle helm)
(el-get-bundle helm-ag)
(el-get-bundle projectile)
(el-get-bundle helm-ghq)
(el-get-bundle helm-c-yasnippet)
(el-get-bundle helm-gtags)
(el-get-bundle helm-descbinds)
(el-get-bundle helm-swoop)
(el-get-bundle magit)
(el-get-bundle markdown-mode)
(el-get-bundle twittering-mode)
(el-get-bundle web-mode)
(el-get-bundle css-mode)
(el-get-bundle js2-mode)
(el-get-bundle json-mode)
(el-get-bundle yaml-mode)
(el-get-bundle coffee-mode)
(el-get-bundle go-mode)
(el-get-bundle puppet-mode)
(el-get-bundle php-mode)
(el-get-bundle ruby-mode)
(el-get-bundle ruby-block)
;; (el-get-bundle ruby-electric)
(el-get-bundle rcodetools)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ido-enter-matching-directory (quote first))
 '(ido-max-directory-size (quote const))
 '(package-selected-packages (quote (nil css-mode))))
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
