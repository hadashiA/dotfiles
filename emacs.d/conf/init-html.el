;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; html-helper-mode
;; (require 'html-helper-mode)
;; (setq auto-mode-alist (append '(("\\.html?$" . html-helper-mode)
;;                                 ("\\.tt$" . html-helper-mode))
;;                               auto-mode-alist))

;; (add-hook 'html-helper-mode-hook
;;           '(lambda()
;;                (abbrev-mode nil)))

;; ;; 勝手に雛形が作られてウザいのでnilにしておく
;; (setq html-helper-build-new-buffer nil)

;; (add-hook 'html-mode-hook
;;           (lambda ()
;;             (define-key html-mode-map (kbd "M-n") 'sgml-skip-tag-forward)
;;             (define-key html-mode-map "\M-p" 'sgml-skip-tag-backward)))

(require 'haml-mode)
(require 'sass-mode)

(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
