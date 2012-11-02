(require 'ffap)

(defun ffap-ruby-mode (name)
  (shell-command-to-string
   (format "ruby -e '
require %%[rubygems]
require %%[devel/which]
require %%[%s]
print(which_library(%%[%s]))
'"
           name name)))

;; ruby
(defun find-rubylib (name)
  (interactive "sRuby library name: ")
  (find-file (ffap-ruby name)))

(add-to-list 'ffap-alist '(ruby-mode . ffap-ruby-mode))

;; node.js
(defun ffap-nodejs (name)
  (shell-command-to-string
   (format "node -e 'try { require(\"util\").print(require.resolve(\"%s\")) } catch(e) {}'"
           name)))

(add-to-list 'ffap-alist '(js3-mode . ffap-nodejs))
