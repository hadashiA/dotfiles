(add-hook 'ruby-mode-hook
          (lambda ()
            (define-key ruby-mode-map "d" 'ruby-elect-end)))
