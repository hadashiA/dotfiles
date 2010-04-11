;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(setq woman-manpath '("/usr/local/jman/share/man/ja_JP.UTF-8/" 
		      "/opt/local/share/man"
		      "/usr/local/share/man"
;;		      "/usr/share/man"
		      "/usr/X11/man"))

(setq woman-cache-filename (expand-file-name "~/.womancache"))
(setq woman-cache-level 3)
(setq woman-use-own-frame nil)

(autoload 'woman "woman" "Decode and browse a UN*X man page." t)
(autoload 'woman-find-file "woman" "Find, decode and browse a specific UN*X man-page file." t)

(global-set-key "\C-x\M-m" 'woman)

;; vi や w3m のようなキー設定を少々
(add-hook 'woman-post-format-hook
	  '(lambda ()
             (progn
               (define-key woman-mode-map "j" 'next-line)
               (define-key woman-mode-map "k" 'previous-line)
               (define-key woman-mode-map "J"
                 '(lambda () (interactive) (scroll-up 1)))
               (define-key woman-mode-map "K"
                 '(lambda () (interactive) (scroll-down 1)))
               (define-key woman-mode-map "b" 'scroll-down)
               (define-key woman-mode-map "h" 'backward-word)
               (define-key woman-mode-map "l" 'forward-word))))