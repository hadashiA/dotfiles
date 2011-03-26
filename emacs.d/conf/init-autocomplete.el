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
  (setq ac-ignore-case t
        ac-use-menu-map t)
  
  (define-key ac-completing-map (kbd "C-c /") 'ac-complete-filename)
  (define-key ac-menu-map "\C-n" 'ac-next)
  (define-key ac-menu-map "\C-p" 'ac-previous)

  ;; ツールチップすごいけど、あんまり見てないので無効
  ;; (when (require 'pos-tip nil t)
  ;;   (setq ac-quick-help-prefer-x t))

  (add-to-list 'load-path "~/.emacs.d/elisp/company")
  (require 'ac-company)
  (setq ac-modes (append ac-modes '(objc-mode)))
  (ac-company-define-source ac-source-company-xcode company-xcode)
  (ac-company-define-source ac-source-company-gtags company-gtags)
  (add-hook 'objc-mode-hook
            (lambda ()
              (add-to-list 'ac-sources 'ac-source-company-xcode)
              (add-to-list 'ac-sources 'ac-source-company-gtags)
              ;; (add-to-list 'ac-sources 'ac-source-c++-keywords)
              (add-to-list 'ac-sources 'ac-source-filename)
              ;; (add-to-list 'ac-sources 'ac-source-words-in-same-mode-buffers)
              (add-to-list 'ac-sources 'ac-source-yasnippet)
              (auto-complete)
              )
            )

  (add-hook 'emacs-lisp-mode-hook
            (lambda ()
              (add-to-list 'ac-sources 'ac-source-features)
              (add-to-list 'ac-sources 'ac-source-functions)
              (add-to-list 'ac-sources 'ac-source-symbols)
              (add-to-list 'ac-sources 'ac-source-variables)))

  (add-hook 'ruby-mode-hook
            (lambda ()
              (ac-ruby-mode-setup)
              (add-to-list 'ac-sources 'ac-source-rsense-method)
              (add-to-list 'ac-sources 'ac-source-rsense-constant)
              (add-to-list 'ac-sources 'ac-source-company-gtags)
              ))

  (defun ac-complete-pycomplete-pycomplete ()
    (interactive)
    (auto-complete '(ac-source-python)))
  
  (setq ac-source-python
        '((prefix "\\(?:\\.\\|->\\)\\(\\(?:[a-zA-Z_][a-zA-Z0-9_]*\\)?\\)" nil 1)      
          (candidates . ac-py-candidates)
          (requires . 0)))

  (defun ac-py-candidates ()
    (pycomplete-pycomplete (py-symbol-near-point) (py-find-global-imports)))

  (add-hook 'python-mode-hook
            (lambda ()
              (add-to-list 'ac-sources 'ac-source-words-in-same-mode-buffers)
              (add-to-list 'ac-sources 'ac-source-dictionary)
              ))

  (ac-config-default))
