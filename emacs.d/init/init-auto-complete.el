;; Auto Complete Mode
;; http://cx4a.org/software/auto-complete/manual.ja.html#ac-source-yasnippet
;; (when (require 'auto-complete nil t)
(require 'auto-complete-config)

;; (ac-config-default)
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")

(setq-default ac-sources
              '(ac-source-abbrev
                ac-source-dictionary
                ac-source-words-in-same-mode-buffers
                ac-source-filename
                ac-source-yasnippet))

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

;; (define-key ac-completing-map (kbd "C-c /") 'ac-complete-filename)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

;; (add-hook 'minibuffer-setup-hook '(lambda () (auto-complete-mode 1)))

(setq ac-quick-help-prefer-x t)

(add-hook 'auto-complete-mode-hook 'ac-common-setup)

;; 
;; c/c++
;; 
(defun ac-cc-mode-setup ()
  (add-to-list 'ac-sources '(ac-source-ya-gtags))
  (ac-clang-launch-completion-process)
  (message "ac-cc-mode-setup"))

;; (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
(add-hook 'cc-mode-hook 'ac-cc-mode-setup)
(add-hook 'c++-mode-hook 'ac-cc-mode-setup)

;; 
;; go
;; 
(add-to-list 'ac-modes 'go-mode)
(require 'go-autocomplete)

;; 
;; c#
;; 
(add-to-list 'ac-modes 'csharp-mode)
(add-hook 'csharp-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-ya-gtags)
            ))

(add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)

;; 
;; elisp
;; 
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-features)
            (add-to-list 'ac-sources 'ac-source-functions)
            (add-to-list 'ac-sources 'ac-source-symbols)
            (add-to-list 'ac-sources 'ac-source-variables)))
;; 
;; css
;; 
(add-hook 'css-mode-hook 'ac-css-mode-setup)

;; 
;; javascript
;; 
(add-hook 'js2-mode-hook
          (lambda ()
            (auto-complete-mode nil)
            (auto-complete-mode t)
            ))

(add-hook 'coffee-mode-hook
          (lambda ()
            (auto-complete-mode nil)
            (auto-complete-mode t)
            ))

(global-auto-complete-mode t)

