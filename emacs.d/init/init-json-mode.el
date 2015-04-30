(add-to-list 'auto-mode-alist '("\\.json" . json-mode))


(add-hook 'json-mode-hook
          (lambda ()
            (make-variable-buffer-local 'js-indent-level)
            (setq js-indent-level 2)))

