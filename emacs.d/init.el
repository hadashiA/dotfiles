;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;;
;; Global Variables
;;

;; スタートアップ時のメッセージを抑制
(setq inhibit-startup-message t)

(when window-system
 (menu-bar-mode 0)
 (tool-bar-mode 0))

;; エンコーディングは基本的にUTF-8
;; (add-hook 'set-language-environment-hook 
;; 	  (lambda ()
;; 	    (when (equal "ja_JP.UTF-8" (getenv "LANG"))
;; 	      (setq default-process-coding-system '(utf-8 . utf-8))
;; 	      (setq default-file-name-coding-system 'utf-8))
;; 	    (when (equal "Japanese" current-language-environment)
;; 	      (setq default-buffer-file-coding-system 'iso-2022-jp))))
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))
(setq default-file-name-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setenv "LANG" "ja_JP.UTF-8")

;; ヴィジブルベルを抑制
(setq visible-bell nil)

;; ビープ音を抑制
(setq ring-bell-function '(lambda ()))

;; カーソルの点滅を抑制
(blink-cursor-mode 0)

;; 行数、列数を表示
(line-number-mode t)
(column-number-mode t)

;; バックアップしない
(setq make-backup-files nil)

;; 自動保存したファイルを削除する。
(setq delete-auto-save-files t)

;; 自動セーブしない。
(setq auto-save-default nil)

;; yes/noを、y/nで選択できるようにする。
(fset 'yes-or-no-p 'y-or-n-p)

;; kill-lineで行末の改行文字も削除
(setq kill-whole-line t)

;; リージョンをC-hで削除
;;(delete-selection-mode 1)

(transient-mark-mode t)

;; シフト + 矢印で範囲選択
;; (setq pc-select-selection-keys-only t)
;; (pc-selection-mode 1)

;; インデントはスペースで
(setq-default indent-tabs-mode nil)
(setq default-tab-width 4)

;; 改行と同時にインデント
(global-set-key "\C-m" 'newline-and-indent)
;; (global-set-key "\C-m" 'comment-indent-new-line)

;; バッファにファイルをドラッグドロップした際のファイルをinsertする動作に変更されている。
;; (define-key global-map [ns-drag-file] 'ns-insert-file)
;; Emacs22の時の動作は find-fileですので同じにするには以下を .emacs に記述します
(define-key global-map [ns-drag-file] 'ns-find-file)

(setq dnd-open-file-other-window nil)

;; 個人用infoディレクトリを追加
(setq Info-default-directory-list
      (cons (expand-file-name "~/.emacs.d/info/") Info-default-directory-list))

(turn-off-auto-fill)

;; ファイルの末尾に改行を付加しない
(setq require-final-newline nil)

(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/.emacs.d/init")
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

;; 半角と全角の比を1:2に
(setq face-font-rescale-alist
      '((".*Hiragino_Mincho_pro.*" . 1.2)))

;;
;; Standard Libraries
;;

(load "init-server")
(load "init-color")
(load "init-shell")
(load "init-ffap")
(load "init-minibuf")
(load "init-remaps")
(load "init-window")
(load "init-killring")
(load "init-highlighting")
(load "init-vimlike")
(load "init-dired")
(load "init-cc")
(load "init-genkou-mode")
(load "init-generic-x")
(load "init-os")

;;
;; Packages
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
;; (el-get-bundle mcomplete
;;   :type github
;;   :pkgname "emacsmirror/mcomplete"
;;   :features mcomplete)
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
(el-get-bundle multiple-cursors)
(el-get-bundle foreign-regexp
  :type github
  :pkgname "k-talo/foreign-regexp.el")
(el-get-bundle smartchr)
(el-get-bundle rainbow-delimiters)
(el-get-bundle open-junk-file)
(el-get-bundle ace-jump-mode)
(el-get-bundle ddskk)
(el-get-bundle flycheck)
(el-get-bundle flycheck-pos-tip)
(el-get-bundle go-flymake
  :features go-flycheck)
(el-get-bundle dropdown-list
  :features dropdown-list)
(el-get-bundle yasnippet)
(el-get-bundle pos-tip)
(el-get-bundle company-mode)
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
(el-get-bundle haml-mode)
(el-get-bundle handlebars-mode)
(el-get-bundle css-mode)
(el-get-bundle rainbow-mode)
(el-get-bundle js2-mode)
(el-get-bundle coffee-mode)
(el-get-bundle typescript-mode)
(el-get-bundle json-mode)
(el-get-bundle yaml-mode)
(el-get-bundle go-mode)
(el-get-bundle ruby-mode)
(el-get-bundle ruby-block)
(el-get-bundle inf-ruby)
(el-get-bundle rcodetools)
(el-get-bundle csharp-mode)
(el-get-bundle omnisharp-mode)
(el-get-bundle dash-at-point)
(el-get-bundle swift-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-display-errors-function (function flycheck-pos-tip-error-messages))
 '(ido-enter-matching-directory (quote first))
 '(ido-max-directory-size (quote const))
 '(package-selected-packages (quote (typescript-mode nil rainbow-mode)))
 '(session-use-package t nil (session)))
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
