(require 'smartparens-config)
(smartparens-global-mode t)

(define-key sp-keymap (kbd "S-C-f") 'sp-end-of-sexp)
(define-key sp-keymap (kbd "S-C-b") 'sp-beginning-of-sexp)
(define-key sp-keymap (kbd "C-9") 'sp-splice-sexp)
(define-key sp-keymap (kbd "C-8") 'sp-backward-unwrap-sexp)


