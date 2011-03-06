(add-to-load-path "~/.emacs.d/elisp/evernote/")
(when (require 'evernote) nil t
      (global-set-key (kbd "C-c C-q") 'evernote-search)
      (global-set-key (kbd "C-c C-c C-c") 'evernote-quick-put))
