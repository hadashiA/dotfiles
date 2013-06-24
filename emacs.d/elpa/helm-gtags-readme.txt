`helm-gtags.el' is GNU GLOBAL `helm' interface.
`helm-gtags.el' is not compatible `anything-gtags.el', but `helm-gtags.el'
is designed for fast search.


To use this package, add these lines to your init.el or .emacs file:
    (require 'helm-config)
    (require 'helm-gtags)

    (add-hook 'helm-gtags-mode-hook
              '(lambda ()
                 (local-set-key (kbd "M-t") 'helm-gtags-find-tag)
                 (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)
                 (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
                 (local-set-key (kbd "C-t") 'helm-gtags-pop-stack)
                 (local-set-key (kbd "C-c C-f") 'helm-gtags-find-files)))
