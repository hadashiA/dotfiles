;; ;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(setq helm-enable-shortcuts 'alphabet)
(setq helm-display-function 'pop-to-buffer)
(setq helm-display-function 'helm-default-display-buffer)

(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-;") 'helm-for-files)
(global-set-key (kbd "C-:") 'helm-resume)

(define-key global-map (kbd "C-,") 'helm-projectile)
(define-key global-map (kbd "C-*") 'helm-ag)

(require 'helm-c-yasnippet)
(define-key global-map (kbd "C-.") 'helm-c-yas-complete)

;; \M-y でキルリング履歴
(setq kill-ring-max 200) ;; kill-ring の最大値. デフォルトは 30.
(setq helm-kill-ring-threshold 10) ;; anything で対象とするkill-ring の要素の長さの最小値.デフォルトは 10.
(global-set-key "\M-y" 'helm-show-kill-ring)

(require 'helm-c-moccur)
(global-set-key (kbd "M-o") 'helm-c-moccur-occur-by-moccur)
(global-set-key (kbd "C-M-o") 'helm-c-moccur-dmoccur)
(add-hook 'dired-mode-hook
          '(lambda ()
             (local-set-key (kbd "O") 'helm-c-moccur-dired-do-moccur-by-moccur)))

(require 'helm-gtags)
(add-hook 'c-mode-common-hook (lambda () (helm-gtags-mode)))
(add-hook 'helm-gtags-mode-hook
          '(lambda ()
             (local-set-key (kbd "M-t") 'helm-gtags-find-tag)
             (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)
             (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
             (local-set-key (kbd "C-t") 'helm-gtags-pop-stack)))

;; (defvar anything-c-sources-rubygems-local
;;   '((name . "rubygems")
;;     (candidates-in-buffer)
;;     (init . (lambda ()
;;               (let ((gemfile-dir
;;                      (block 'find-gemfile
;;                        (let* ((cur-dir (file-name-directory
;;                                         (expand-file-name (or (buffer-file-name)
;;                                                               default-directory))))
;;                               (cnt 0))
;;                          (while (and (< (setq cnt (+ 1 cnt)) 10)
;;                                      (not (equal cur-dir "/")))
;;                            (when (member "Gemfile" (directory-files cur-dir))
;;                              (return-from 'find-gemfile cur-dir))
;;                            (setq cur-dir (expand-file-name (concat cur-dir "/.."))))
;;                          ))))
;;                 (anything-attrset 'gem-command
;;                                   (concat (if gemfile-dir
;;                                               (format "BUNDLE_GEMFILE=%s/Gemfile bundle exec "
;;                                                       gemfile-dir)
;;                                             "")
;;                                           "gem 2>/dev/null"))
;;                 (unless (anything-candidate-buffer)
;;                   (call-process-shell-command (format "%s list" (anything-attr 'gem-command))
;;                                               nil
;;                                               (anything-candidate-buffer 'local))))))
;;     (action . (lambda (gem-name)
;;                 (message (anything-attr 'gem-command))
;;                 (let ((path (file-name-directory
;;                              (shell-command-to-string
;;                               (format "%s which %s"
;;                                       (anything-attr 'gem-command)
;;                                       (replace-regexp-in-string "\s+(.+)$" "" gem-name))))))
;;                   (if (and path (file-exists-p path))
;;                       (find-file path)
;;                     (message "no such file or directory: \"%s\"" path))
;;                   )))))

;; (defun anything-rubygems-local ()
;;   (interactive)
;;   (anything-other-buffer
;;    '(anything-c-sources-rubygems-local)
;;    "*anything local gems*"
;;   ))

