(add-to-load-path "~/.emacs.d/elisp/testkick/")
(when (require 'testkick)
  (global-set-key (kbd "C-`") 'testkick)
  (global-set-key (kbd "C-+") 'testkick-toggle)
  )