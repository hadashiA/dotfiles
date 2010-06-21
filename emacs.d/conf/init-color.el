;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(when (window-system)
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
   ))


(set-cursor-color "#656565")

;; 補完候補に色
(when (require 'dircolors nil t)
  ;; (setq dircolors-face-color
  ;;       '(
  ;;         (dircolors-face-dir            "SkyBlue"        )
  ;;         (dircolors-face-doc            "MediumTurquoise")
  ;;         (dircolors-face-html           "Plum"           )
  ;;         (dircolors-face-package        "IndianRed"      )
  ;;         (dircolors-face-tar            "OrangeRed"      )
  ;;         (dircolors-face-dos            "LimeGreen"      )
  ;;         (dircolors-face-sound          "LightBlue"      )
  ;;         (dircolors-face-img            "Salmon"         )
  ;;         (dircolors-face-ps             "BlueViolet"     )
  ;;         (dircolors-face-backup         "Magenta"        )
  ;;         (dircolors-face-make           "Khaki"          )
  ;;         (dircolors-face-paddb          "Orange"         )
  ;;         (dircolors-face-lang           "Yellow"         )
  ;;         (dircolors-face-emacs          "GreenYellow"    )
  ;;         (dircolors-face-lang-interface "Goldenrod"      )
  ;;         (dircolors-face-yacc           "Coral"          )
  ;;         (dircolors-face-objet          "DimGray"        )
  ;;         (dircolors-face-asm            "Tan"            )
  ;;         (dircolors-face-compress       "Sienna"         )
  ;;         )))
)
