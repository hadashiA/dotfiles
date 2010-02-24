(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")

;; (setq yas/trigger-key (kbd "C-l"))
;; (setq yas/next-field-key (kbd "TAB"))

(add-hook 'rinari-minor-mode-hook
          #'(lambda ()
              (setq yas/mode-symbol 'rails-mode)))

