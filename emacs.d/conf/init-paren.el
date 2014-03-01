(require 'smartparens-config)
(smartparens-global-mode t)

(define-key sp-keymap (kbd "S-C-f") 'sp-forward-symbol)
(define-key sp-keymap (kbd "S-C-b") 'sp-backward-symbol)
(define-key sp-keymap (kbd "C-9") 'sp-unwrap-sexp)
