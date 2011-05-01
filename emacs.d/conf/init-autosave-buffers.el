;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; (when (require 'auto-save-buffers nil t)
;;   (run-with-idle-timer 0.5 t 'auto-save-buffers))

(when (require 'auto-save-buffers-enhanced)
  (auto-save-buffers-enhanced t)
  (setq auto-save-buffers-enhanced-interval 2.0
        auto-save-buffers-enhanced-include-regexps '(".+")
        auto-save-buffers-enhanced-exclude-regexps '("^not-save-file" "\\.ignore$" ".*\\.howm$" "^save$" "\\.omm"))
  (global-set-key "\C-xas" 'auto-save-buffers-enhanced-toggle-activity)
  (run-with-idle-timer 2 t 'auto-save-buffers)
)
