;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(autoload 'gtags-mode "gtags" "" t)
(define-key gtags-mode-map "\M-t" 'gtags-find-rtag)
(define-key gtags-mode-map "\M-r" 'gtags-pop-stack)
(define-key gtags-mode-map "\M-s" 'gtags-find-symbol)

(add-hook 'cc-mode-hook
          (lambda ()
            (gtags-mode 1)
            ;; (gtags-make-complete-list)
            (setq gtags-libpath `((,(expand-file-name "~/.tags/c") . "/usr/include")
                                  (,(expand-file-name "~/.tags/c_local") . "/usr/local/include")))
            (add-to-list 'anything-sources 'anything-c-source-gtags-select t)
            (define-key c-mode-base-map (kbd "C-+") 'anything-gtags-select)
            ))

(add-hook 'objc-mode-hook
          (lambda ()
            (gtags-mode 1)
            ;; (gtags-make-complete-list)
            (setq gtags-libpath `((,(expand-file-name "~/.tags/objc") . "/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS4.0.sdk/System/Library/Frameworks")))
            (add-to-list 'anything-sources 'anything-c-source-gtags-select t)
            (define-key objc-mode-map (kbd "C-+") 'anything-gtags-select)
            ))
