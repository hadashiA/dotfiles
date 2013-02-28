;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; (when (require 'auto-save-buffers nil t)
;;   (run-with-idle-timer 0.5 t 'auto-save-buffers))

(setq auto-save-buffers-enhanced-interval 2.5
      auto-save-buffers-enhanced-include-regexps '(".+")
      auto-save-buffers-enhanced-exclude-regexps '("^not-save-file" "\\.ignore$" ".*\\.howm$" "^save$" "\\.omm"))

(require 'auto-save-buffers-enhanced)
(auto-save-buffers-enhanced t)
(global-set-key "\C-xas" 'auto-save-buffers-enhanced-toggle-activity)

