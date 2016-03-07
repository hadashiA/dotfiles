(require 'omnisharp)
(setq omnisharp-server-executable-path
      (expand-file-name "~/src/github.com/OmniSharp/omnisharp-server/OmniSharp/bin/Debug/OmniSharp.exe"))

(add-hook 'csharp-mode-hook
          '(lambda()
             (omnisharp-mode)
             (define-key csharp-mode-map (kbd ".") 'omnisharp-add-dot-and-auto-complete)
             (define-key csharp-mode-map (kbd "M-t") 'omnisharp-go-to-definition)
             ))
