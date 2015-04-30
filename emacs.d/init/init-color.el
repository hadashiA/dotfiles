;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(when (window-system)
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

  (set-cursor-color "#656565")

  (set-face-foreground 'font-lock-regexp-grouping-backslash "#666")
  (set-face-foreground 'font-lock-regexp-grouping-construct "#f60")

  ;; (defun print-all-fonts ()
  ;;   (let ((ls (x-list-fonts "*")))
  ;;     (while (not (null ls))
  ;;       (princ (car ls))
  ;;       (newline)
  ;;       (setq ls (cdr ls)))))

  ;; (prin1 (font-family-list))

  ;; ;; 英語フォント
  ;; (set-face-attribute 'default nil
  ;; 		    :family "MiuraLiner\-Jr"
  ;; 		    :height 250)
  ;; ;; 日本語フォント
  ;; (set-fontset-font
  ;;  nil 'japanese-jisx0208
  ;;  (font-spec :family "Hiragino_Minco_ProN"))

  ;; ;; ひらがなとカタカナ
  ;; ;; U+3000-303F CJKの記号および句読点
  ;; ;; U+3040-309F ひらがな
  ;; ;; U+30A0-30FF カタカナ
  ;; (set-fontset-font
  ;;  nil '(#x3040 . #x30ff)
  ;;  (font-spec :family "Hiragino_Minco_ProN"))

  ;; 半角カタカナ、全角アルファベット
  ;; (set-fontset-font nil
  ;;                   '( #xff00 .  #xffef)
  ;;                   (font-spec :family "Hiragino_Minco_ProN" :spacing 'm)
  ;;                   nil
  ;;                   'prepend)
  )

