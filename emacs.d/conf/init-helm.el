;; ;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(setq helm-display-function
      (lambda (buf)
        (when (one-window-p)
          (split-window-horizontally))
        (other-window 1)
        (switch-to-buffer buf)))

(eval-after-load 'helm
  '(progn
     (define-key helm-map (kbd "C-h") 'delete-backward-char)
     (define-key helm-map (kbd "C-v") 'helm-next-source)
     (define-key helm-map (kbd "M-v") 'helm-previous-source)
     ))

;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
;; (setq helm-for-files-preferred-list
;;       '(helm-source-ls-git-status
;;         helm-source-buffers-list
;;         helm-source-recentf
;;         helm-source-bookmarks
;;         helm-source-file-cache
;;         helm-source-files-in-current-dir
;;         helm-source-locate
;;         ))
(global-set-key (kbd "C-;") 'helm-for-files)
(setq helm-ff-transformer-show-only-basename nil)

(global-set-key (kbd "C-:") 'helm-resume)

;; 
;; find files
;; 
(define-key global-map (kbd "C-*") 'helm-ag)

;; 
;; profectile
;; 
(define-key global-map (kbd "C-,") 'helm-projectile)
;; (setq projectile-enable-caching t)
;; (setq projectile-use-native-indexing t)
;; (require 'helm-project)
;; (define-key global-map (kbd "C-,") 'helm-project)
;; (setq hp:project-files-filters
;;       (list
;;        (lambda (files)
;;          (remove-if 'file-directory-p files))))

;; 
;; ghq
;; 
(define-key global-map (kbd "C-{") 'helm-ghq)

;;
;; helm-c-yasnippet
;; 
(require 'helm-c-yasnippet)
(define-key yas-minor-mode-map (kbd "C-x i i") 'helm-c-yas-complete)

;; 
;; kill-ring
;; 
;; \M-y でキルリング履歴
(setq kill-ring-max 200) ;; kill-ring の最大値. デフォルトは 30.
(setq helm-kill-ring-threshold 10) ;; anything で対象とするkill-ring の要素の長さの最小値.デフォルトは 10.
(global-set-key "\M-y" 'helm-show-kill-ring)

;; 
;; helm-gtags
;; 
(require 'helm-gtags)
(add-hook 'prog-mode-hook 'helm-gtags-mode)
(add-hook 'helm-gtags-mode-hook
          '(lambda ()
             (local-set-key (kbd "M-t") 'helm-gtags-find-tag)
             (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)
             ;; (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
             (local-set-key (kbd "C-S-t") 'helm-gtags-pop-stack)))

(require 'helm-imenu)
(defun my/helm-tags ()
  (interactive)
  (helm :sources '(helm-source-imenu
                   helm-source-gtags-select)
        :buffer "*helm gtasg and imenu*"))

(global-set-key (kbd "C-+") 'my/helm-tags)

;; 
;; helm-descbinds
;; 
(helm-descbinds-mode)
(global-set-key (kbd "C-x b") 'helm-descbinds)

;; 
;; helm-swoop
;; 
(require 'helm-swoop)
(global-set-key (kbd "M-i") 'helm-swoop)
;; When doing isearch, hand the word over to helm-swoop
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
;; From helm-swoop to helm-multi-swoop-all
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
;; When doing evil-search, hand the word over to helm-swoop
;; (define-key evil-motion-state-map (kbd "M-i") 'helm-swoop-from-evil-search)

;; Save buffer when helm-multi-swoop-edit complete
(setq helm-multi-swoop-edit-save t)

;; If this value is t, split window inside the current window
(setq helm-swoop-split-with-multiple-windows nil)

;; Split direcion. 'split-window-vertically or 'split-window-horizontally
(setq helm-swoop-split-direction 'split-window-vertically)
(setq helm-swoop-use-line-number-face t)

;; 
;; helm-rubygems-local
;; 
(defvar helm-c-source-rubygems-local
  '((name . "rubygems")
    (candidates-in-buffer)
    (init . (lambda ()
              (let ((gemfile-dir
                     (block 'find-gemfile
                       (let* ((cur-dir (file-name-directory
                                        (expand-file-name (or (buffer-file-name)
                                                              default-directory))))
                              (cnt 0))
                         (while (and (< (setq cnt (+ 1 cnt)) 10)
                                     (not (equal cur-dir "/")))
                           (when (member "Gemfile" (directory-files cur-dir))
                             (return-from 'find-gemfile cur-dir))
                           (setq cur-dir (expand-file-name (concat cur-dir "/.."))))
                         ))))
                (helm-attrset 'gem-command
                                  (concat (if gemfile-dir
                                              (format "BUNDLE_GEMFILE=%s/Gemfile bundle exec "
                                                      gemfile-dir)
                                            "")
                                          "gem 2>/dev/null"))
                (unless (helm-candidate-buffer)
                  (call-process-shell-command (format "%s list" (helm-attr 'gem-command))
                                              nil
                                              (helm-candidate-buffer 'local))))))
    (action . (lambda (gem-name)
                ;; (message (helm-attr 'gem-command))
                (let ((gem-which (shell-command-to-string
                                  (format "%s which %s"
                                          (helm-attr 'gem-command)
                                          (replace-regexp-in-string "\s+(.+)$" "" gem-name))))
                      (path))
                  (print gem-which)
                  (if (or (null gem-which)
                          (string= "" gem-which)
                          (string-match "^ERROR:" gem-which))
                      (message "Can't find ruby library file or shared library %s" gem-name)
                    (setq path (file-name-directory gem-which))
                    (if (and path (file-exists-p path))
                        (find-file path)
                      (message "no such file or directory: \"%s\"" path))
                    )
                  )))
    ))

(defun helm-rubygems-local ()
  (interactive)
  (helm-other-buffer
   '(helm-c-source-rubygems-local)
   "*anything local gems*"
  ))


