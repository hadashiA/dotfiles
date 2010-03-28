;; Auto Complete Modeユーザーマニュアル
;; http://cx4a.org/software/auto-complete/manual.ja.html#ac-source-yasnippet
(when (require 'auto-complete nil t)
  ;; (ac-config-default)
  (global-auto-complete-mode t)
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)

  (setq ac-sources
        '(;; ac-source-abbrev
          ;; ac-source-dictionary
          ;; ac-source-eclim
          ;; ac-source-features            ; Emacs Lisp
          ac-source-filename
          ;; ac-source-files-in-current-dir
          ;; ac-source-functions           ; Emacs Lisp
          ;; ac-source-gtags
          ;; ac-source-imenu
          ;; ac-source-semantic
          ;; ac-source-symbols             ; Emacs Lisp
          ;; ac-source-variables           ; Emacs Lisp
          ;; ac-source-words-in-all-buffer
          ;; ac-source-words-buffer
          ac-source-words-in-same-mode-buffers
          ac-source-yasnippet))
        
  ;; 濶ｲ
  (set-face-background 'ac-candidate-face "lightgray")
  (set-face-underline 'ac-candidate-face "darkgray")
  (set-face-background 'ac-selection-face "steelblue")

  ;; 陬懷ｮ悟ｯｾ雎｡縺ｫ螟ｧ譁�蟄励′蜷ｫ縺ｾ繧後ｋ蝣ｴ蜷医�ｮ縺ｿ蛹ｺ蛻･縺吶ｋ
  ;; (setq ac-ignore-case 'smart)
  (setq ac-ignore-case t)

  ;; C-c /でファイル名補完
  (global-set-key (kbd "C-c /") 'ac-complete-filename)

  (when (require 'pos-tip nil t)
    (setq ac-quick-help-prefer-x t))

  (add-hook 'emacs-lisp-mode-hook
            (lambda ()
              (add-to-list 'ac-sources 'ac-source-features)
              (add-to-list 'ac-sources 'ac-source-functions)
              (add-to-list 'ac-sources 'ac-source-symbols)
              (add-to-list 'ac-sources 'ac-source-variables)))

  (add-hook 'ruby-mode-hook
            (lambda ()
              (add-to-list 'ac-sources 'ac-source-rsense-method)
              (add-to-list 'ac-sources 'ac-source-rsense-constant))))

