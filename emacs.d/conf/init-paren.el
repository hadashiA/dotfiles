(require 'smartparens-config)
(smartparens-global-mode t)

(define-key sp-keymap (kbd "S-C-f") 'sp-forward-sexp)
(define-key sp-keymap (kbd "S-C-b") 'sp-backward-sexp)
(define-key sp-keymap (kbd "C-)") 'sp-unwrap-sexp)
