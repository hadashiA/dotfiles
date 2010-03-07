;; (when (require 'auto-complete nil t)
;; ;;  (require 'auto-complete-config)
;;   (require 'auto-complete-ruby)

;;   (global-auto-complete-mode t)
;;   (set-face-background 'ac-candidate-face "lightgray")
;;   (set-face-underline 'ac-candidate-face "darkgray")
;;   (set-face-background 'ac-selection-face "steelblue")

;;   (define-key ac-complete-mode-map "\M-/" 'ac-start)
;;   (define-key ac-complete-mode-map "\t" 'ac-expand)
;;   (define-key ac-complete-mode-map "\r" 'ac-complete)
;;   (define-key ac-complete-mode-map "\M-n" 'ac-next)
;;   (define-key ac-complete-mode-map "\M-p" 'ac-previous)

;;   (setq ac-auto-start 3)
;;   (setq ac-dwim t)
;;   (set-default 'ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-words-in-buffer))

;;   (add-hook 'auto-complete-mode-hook
;;             (lambda ()
;;               (add-to-list 'ac-sources 'ac-source-filename)
;;               (add-to-list 'ac-sources 'ac-source-words-in-buffer)))

;;   (add-hook 'c-mode-hook
;;             (lambda ()
;;               (setq ac-sources '(ac-source-gtags ac-source-yasnippet))))

;;   (setq ac-modes
;;         (append ac-modes
;;                 '(eshell-mode
;;                                         ;org-mode
;;                   )))
;;                                         ;(add-to-list 'ac-trigger-commands 'org-self-insert-command)

;;   (add-hook 'emacs-lisp-mode-hook
;;             (lambda ()
;;               (setq ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-words-in-buffer ac-source-symbols))))

;;   (add-hook 'eshell-mode-hook
;;             (lambda ()
;;               (setq ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-files-in-current-dir ac-source-words-in-buffer))))

;;   (add-hook 'ruby-mode-hook
;;             (lambda ()
;;               (setq ac-omni-completion-sources '(("\\.\\=" ac-source-rcodetools)))))
;;   )

(require 'auto-complete)
(global-auto-complete-mode t)


