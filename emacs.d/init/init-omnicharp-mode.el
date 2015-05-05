(require 'omnisharp)
(add-hook 'csharp-mode-hook 'omnisharp-mode)
(setq omnisharp-server-executable-path
      (expand-file-name "~/src/omnisharp-server/OmniSharp/bin/Debug/OmniSharp.exe"))
