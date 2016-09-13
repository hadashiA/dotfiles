(eval-after-load 'flycheck
  (progn
    '(custom-set-variables
      '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages))
    ;; (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))
    (flycheck-pos-tip-mode)
  ))
