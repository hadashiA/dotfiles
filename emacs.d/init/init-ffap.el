(require 'ffap)
(ffap-bindings)

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

(add-to-list 'ffap-alist '(js2-mode . ffap-nodejs))


(setq ff-other-file-alist
      '(("\\.mm?$" (".h"))
        ("\\.cc$"  (".hh" ".h"))
        ("\\.hh$"  (".cc" ".C"))

        ("\\.c$"   (".h"))
        ("\\.h$"   (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" ".m" ".mm"))

        ("\\.C$"   (".H"  ".hh" ".h"))
        ("\\.H$"   (".C"  ".CC"))

        ("\\.CC$"  (".HH" ".H"  ".hh" ".h"))
        ("\\.HH$"  (".CC"))

        ("\\.cxx$" (".hh" ".h"))
        ("\\.cpp$" (".hpp" ".hh" ".h"))
        
        ("\\.hpp$" (".cpp" ".c"))

        ("\\.coffee$" (".js"))
        ("\\.js$" (".coffee"))

        ("\\.rb$" ("._spec.rb"))
        ("\\._spec.rb$" (".rb"))
        ))


(setq ff-search-directories '("./" "../*" "../../*"))
