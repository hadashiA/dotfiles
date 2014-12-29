(add-hook 'after-init-hook #'global-flycheck-mode)
(require 'go-flycheck)

(eval-after-load 'flycheck
  '(custom-set-variables
   '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))
