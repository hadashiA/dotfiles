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

(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.dust\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.haml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jade\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . handlebars-mode))
(add-to-list 'auto-mode-alist '("\\.haml\\'" . haml-mode))

;;; インデント数
(add-hook 'web-mode-hook
          (lambda ()
            (setq web-mode-html-offset   2)
            (setq web-mode-css-offset    2)
            (setq web-mode-script-offset 2)
            (setq web-mode-php-offset    2)
            (setq web-mode-java-offset   2)
            (setq web-mode-asp-offset    2)
            
            (define-key web-mode-map (kbd "C-;") 'helm-for-files)
            ))
