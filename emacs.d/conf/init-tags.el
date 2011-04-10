;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; (autoload 'gtags-mode "gtags" "" t)
(require 'gtags)
(setq gtags-mode-hook
      '(lambda ()
         (local-set-key "\M-t" 'gtags-find-tag)
         (local-set-key "\M-r" 'gtags-find-rtag)
         (local-set-key "\M-s" 'gtags-find-symbol)
         (local-set-key (kbd "S-C-t") 'gtags-pop-stack)
         ))

;; (define-key gtags-mode-map "\M-t" 'gtags-find-rtag)
;; (define-key gtags-mode-map "\M-r" 'gtags-pop-stack)
;; (define-key gtags-mode-map "\M-s" 'gtags-find-symbol)

(defun gtags-mode-on-and-setup-anything ()
  (interactive)
  (gtags-mode 1)
  (gtags-make-complete-list)
  (add-to-list 'anything-sources 'anything-c-source-gtags-select t)
  (define-key c-mode-base-map (kbd "C-+") 'anything-gtags-select)
  (define-key c-mode-map (kbd "C-+") 'anything-gtags-select)
  )

(add-hook 'c-mode-common-hook 
          (lambda ()
            (gtags-mode-on-and-setup-anything)
            ;; (setq gtags-libpath `((,(expand-file-name "~/.tags/c") . "/usr/include")
            ;;                       (,(expand-file-name "~/.tags/c_local") . "/usr/local/include")))
            ))
          
(add-hook 'c++-mode-hook
          (lambda ()
            (gtags-mode-on-and-setup-anything)
            ))

(add-hook 'objc-mode-hook
          (lambda ()
            (gtags-mode-on-and-setup-anything)
            ;; (setq gtags-libpath `((,(expand-file-name "~/.tags/c") . "/usr/include")
            ;;                       (,(expand-file-name "~/.tags/c_local") . "/usr/local/include")
            ;;                       (,(expand-file-name "~/.tags/objc") . "/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS4.0.sdk/System/Library/Frameworks")))
            ))

(add-hook 'ruby-mode-hook
          (lambda ()
            (gtags-mode-on-and-setup-anything)
            ;; (setq gtags-libpath `((,(expand-file-name "~/.tags/activerecord-2.3.8") . "/opt/local/lib/ruby/gems/1.8/gems/activerecord-2.3.8/lib")
            ;;                       (,(expand-file-name "~/.tags/activesupport-2.3.8") . "/opt/local/lib/ruby/gems/1.8/gems/activesupport-2.3.8/lib")))
            ))
