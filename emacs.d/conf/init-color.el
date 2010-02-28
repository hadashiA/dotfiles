;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; http://norainu.net/mt/archives/2007/05/emacs_22.html
(set-background-color "black")
(set-foreground-color "white")

;; comment
(set-face-foreground 'font-lock-comment-face "gray59")
;;(set-face-italic-p 'font-lock-comment-face t)

;; string
(set-face-foreground 'font-lock-string-face  "chartreuse1")

;; keyword
(set-face-foreground 'font-lock-keyword-face "tomato")

;; 変数
(set-face-foreground 'font-lock-variable-name-face "white")

;;
(set-face-foreground 'font-lock-type-face "DarkOliveGreen3")

;; function name
(set-face-foreground 'font-lock-function-name-face "DarkOliveGreen3")

;; Constant
(set-face-foreground 'font-lock-constant-face "DarkOliveGreen3")

;; warning
(set-face-foreground 'font-lock-warning-face "gray56")
(set-face-background 'font-lock-warning-face "yellow")

;;
(set-face-foreground 'font-lock-builtin-face "LightSkyBlue")

;; ハイライト
(set-face-background 'highlight "yellow")
(set-face-foreground 'highlight "black")

;; region
(set-face-background 'region "gray")
(set-face-foreground 'region "white")

;; モードライン
(set-face-foreground 'modeline "brightblack")
(set-face-background 'modeline "brightwhite")

;; ウィンドウを複数開いた時、アクティヴでない方のモードラインの色
(set-face-foreground 'mode-line-inactive "silver")
(set-face-background 'mode-line-inactive "brightblack")

;; ミニバッファのプロンプトの色
(set-face-foreground 'minibuffer-prompt "Green")

