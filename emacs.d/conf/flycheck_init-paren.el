(require 'smartparens-config)
(smartparens-global-mode t)

(define-key sp-keymap (kbd "S-C-f") 'sp-end-of-sexp)
(define-key sp-keymap (kbd "S-C-b") 'sp-beginning-of-sexp)
(define-key sp-keymap (kbd "S-C-d") 'sp-down-sexp)
(define-key sp-keymap (kbd "S-C-u") 'sp-up-sexp)
;; (define-key sp-keymap (kbd "C-9") 'sp-splice-sexp)
;; (define-key sp-keymap (kbd "C-8") 'sp-backward-unwrap-sexp)

(defun my/create-newline-and-enter-sexp (&rest _ignored)
  "Open a new brace or bracket expression, with relevant newlines and indent. "
  (newline)
  (indent-according-to-mode)
  (forward-line -1)
  (indent-according-to-mode))

(sp-local-pair 'c-mode "{" nil :post-handlers '((my/create-newline-and-enter-sexp "RET")))
(sp-local-pair 'c++-mode "{" nil :post-handlers '((my/create-newline-and-enter-sexp "RET")))
(sp-local-pair 'objc-mode "{" nil :post-handlers '((my/create-newline-and-enter-sexp "RET")))
