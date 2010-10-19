;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; (when (require 'auto-save-buffers nil t)
;;   (run-with-idle-timer 0.5 t 'auto-save-buffers))

(when (require 'auto-save-buffers-enhanced)
  (auto-save-buffers-enhanced t)
  ;; (setq auto-save-buffers-enhanced-include-regexps '(".+"))
  ;; (setq auto-save-buffers-enhanced-exclude-regexps '("^not-save-file" "\\.ignore$" ".*\\.omm$"))
  (setq auto-save-buffers-enhanced-exclude-regexps '("^not-save-file" "\\.ignore$" ".*\\.howm"))
  (global-set-key "\C-xas" 'auto-save-buffers-enhanced-toggle-activity))
