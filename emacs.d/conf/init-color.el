;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(custom-set-faces
;;'(default ((t (:stipple nil :background "#272822" :foreground "#F8F8F2" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :family "outline-consolas"))))
'(default ((t (:stipple nil :background "#272822" :foreground "#F8F8F2" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 110 :width normal ))))
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
'(variable-pitch ((t (:family "DejaVu Sans"))))
)

;; http://norainu.net/mt/archives/2007/05/emacs_22.html
;; (set-background-color "black")
;; (set-foreground-color "white")

;; ;; comment
;; (set-face-foreground 'font-lock-comment-face "gray59")
;; ;;(set-face-italic-p 'font-lock-comment-face t)

;; ;; string
;; (set-face-foreground 'font-lock-string-face  "chartreuse1")

;; ;; keyword
;; (set-face-foreground 'font-lock-keyword-face "tomato")
;; ;;(set-face-foreground 'font-lock-keyword-face "LightSkyBlue")

;; ;; 変数
;; (set-face-foreground 'font-lock-variable-name-face "white")

;; ;;
;; (set-face-foreground 'font-lock-type-face "DarkOliveGreen3")

;; ;; function name
;; (set-face-foreground 'font-lock-function-name-face "DarkOliveGreen3")

;; ;; Constant
;; (set-face-foreground 'font-lock-constant-face "DarkOliveGreen3")

;; ;; warning
;; (set-face-foreground 'font-lock-warning-face "gray56")
;; (set-face-background 'font-lock-warning-face "yellow")

;; ;;
;; ;;(set-face-foreground 'font-lock-builtin-face "LightSkyBlue")
;; (set-face-foreground 'font-lock-builtin-face "tomato")

;; ;;(set-face-foreground 'font-lock-reference-face "tomato")

;; ;; ハイライト
;; (set-face-background 'highlight "yellow")
;; (set-face-foreground 'highlight "black")

;; ;; region
;; (set-face-background 'region "gray")
;; (set-face-foreground 'region "white")

;; ;; モードライン
;; (set-face-foreground 'modeline "brightblack")
;;(set-face-background 'modeline "brightwhite")

;;;;  ウィンドウを複数開いた時、アクティヴでない方のモードラインの色
;; ;;(set-face-foreground 'mode-line-inactive "silver")
;; ;;(set-face-background 'mode-line-inactive "brightblack")

;; ;; ミニバッファのプロンプトの色
;; (set-face-foreground 'minibuffer-prompt "Green")

;; ;; 足りないfont-lockを追加。条件は各メジャーモードのhookで定義する
;; ;; シンボル
;; (make-face 'font-lock-symbol-face)
;; (set-face-foreground 'font-lock-symbol-face "tomato")

;; ;; teiginokaisi
;; (make-face 'font-lock-preproc-face)
;; (set-face-foreground 'font-lock-preproc-face "tomato")

;; ;; requireとか？
;; (make-face 'font-lock-reference-face)
;; (set-face-foreground 'font-lock-reference-face "tomato")

