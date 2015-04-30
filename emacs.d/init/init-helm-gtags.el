(require 'helm-gtags)
(add-hook 'prog-mode-hook 'helm-gtags-mode)
(add-hook 'helm-gtags-mode-hook
          '(lambda ()
             (local-set-key (kbd "M-t") 'helm-gtags-find-tag)
             (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)
             ;; (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
             (local-set-key (kbd "C-S-t") 'helm-gtags-pop-stack)))

