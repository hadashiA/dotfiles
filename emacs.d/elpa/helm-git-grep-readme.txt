Add the following to your emacs init file:

(require 'helm-git-grep) ;; Not necessary if using ELPA package
(global-set-key (kbd "C-c g") 'helm-git-grep)

Original version is anything-git-grep, and port to helm.
https://github.com/mechairoi/anything-git-grep
