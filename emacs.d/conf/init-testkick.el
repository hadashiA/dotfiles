(add-to-load-path "~/.emacs.d/elisp/ruby-mode/")
(require 'testkick)

(global-set-key [?\C-.] 'testkick)
(global-set-key [?\C-,] 'testkick-toggle)
