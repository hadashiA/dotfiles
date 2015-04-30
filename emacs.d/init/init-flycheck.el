(add-hook 'after-init-hook 'global-flycheck-mode)

(with-eval-after-load 'flycheck
  '(custom-set-variables
    '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages))
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))
