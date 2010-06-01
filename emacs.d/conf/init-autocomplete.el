;; Auto Complete Mode
;; http://cx4a.org/software/auto-complete/manual.ja.html#ac-source-yasnippet
;; (when (require 'auto-complete nil t)
(when (require 'auto-complete-config nil t)
  ;; (ac-config-default)
  (global-auto-complete-mode t)
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")

  ;; (setq ac-sources
  ;;       '(;; ac-source-abbrev
  ;;         ;; ac-source-dictionary
  ;;         ;; ac-source-eclim
  ;;         ;; ac-source-features            ; Emacs Lisp
  ;;         ac-source-filename
  ;;         ;; ac-source-files-in-current-dir
  ;;         ;; ac-source-functions           ; Emacs Lisp
  ;;         ;; ac-source-gtags
  ;;         ;; ac-source-imenu
  ;;         ;; ac-source-semantic
  ;;         ;; ac-source-symbols             ; Emacs Lisp
  ;;         ;; ac-source-variables           ; Emacs Lisp
  ;;         ;; ac-source-words-in-all-buffer
  ;;         ;; ac-source-words-buffer
  ;;         ac-source-words-in-same-mode-buffers
  ;;         ac-source-yasnippet))
        
  ;; 色
  ;; (set-face-background 'ac-candidate-face "lightgray")
  ;; (set-face-underline 'ac-candidate-face "darkgray")
  ;; (set-face-background 'ac-selection-face "steelblue")

  ;; 補完対象に大文字が含まれる場合のみ区別する
  ;; (setq ac-ignore-case 'smart)
  (setq ac-ignore-case t)

  (global-set-key (kbd "C-c /") 'ac-complete-filename)

  ;; ツールチップすごいけど、あんまり見てないので無効
  ;; (when (require 'pos-tip nil t)
  ;;   (setq ac-quick-help-prefer-x t))

  (add-hook 'emacs-lisp-mode-hook
            (lambda ()
              (add-to-list 'ac-sources 'ac-source-features)
              (add-to-list 'ac-sources 'ac-source-functions)
              (add-to-list 'ac-sources 'ac-source-symbols)
              (add-to-list 'ac-sources 'ac-source-variables)))

  (add-hook 'ruby-mode-hook
            (lambda ()
              (add-to-list 'ac-sources 'ac-source-rsense-method)
              (add-to-list 'ac-sources 'ac-source-rsense-constant)))

  (ac-config-default))
