(when (require 'auto-complete nil t)
  (global-auto-complete-mode t)

  ;; 色
  (set-face-background 'ac-candidate-face "lightgray")
  (set-face-underline 'ac-candidate-face "darkgray")
  (set-face-background 'ac-selection-face "steelblue")

  ;; 補完対象に大文字が含まれる場合のみ区別する
  ;; (setq ac-ignore-case 'smart)
  (setq ac-ignore-case t)

  (when (require 'pos-tip nil t)
    (setq ac-quick-help-prefer-x t))

  (add-hook 'ruby-mode-hook
            (lambda ()
              (add-to-list 'ac-sources 'ac-source-rsense-method)
              (add-to-list 'ac-sources 'ac-source-rsense-constant))))
