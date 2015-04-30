(setq auto-save-buffers-enhanced-interval 0.75
      auto-save-buffers-enhanced-include-regexps '(".+")
      auto-save-buffers-enhanced-exclude-regexps '("^not-save-file"
                                                   "\\.ignore$"
                                                   ".*\\.howm$"
                                                   "^save$"
                                                   "\\.omm$"
                                                   "\\.txt$"
                                                   ;; "\\.coffee"
                                                   ))

(require 'auto-save-buffers-enhanced)
(auto-save-buffers-enhanced t)
(global-set-key "\C-xas" 'auto-save-buffers-enhanced-toggle-activity)

(defun my/save-some-buffers ()
  (interactive)
  (save-some-buffers t))

(global-set-key "\C-xs"  'my/save-some-buffers)
