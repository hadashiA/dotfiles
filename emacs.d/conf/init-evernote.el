(setq evelnote-dev-path (expand-file-name "~/dev/evelnote")
      evelnote-command (concat "bundle exec " evelnote-dev-path "/bin/evelnote" " --debug"))
(setenv "BUNDLE_GEMFILE" (concat evelnote-dev-path "/Gemfile"))

(add-to-load-path evelnote-dev-path)
(load "evelnote")

;; (require 'evelnote)
