(autoload 'css-mode "css-mode")
(add-to-list 'auto-mode-alist '("\\.s?css$" . css-mode))
(setq cssm-indent-function #'cssm-c-style-indenter)

(add-hook 'css-mode-hook
          '(lambda ()
             (rainbow-mode 1)
             ))
