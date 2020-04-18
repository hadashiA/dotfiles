;; ;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(setq helm-enable-shortcuts 'alphabet)

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
(global-set-key (kbd "M-x") 'helm-M-x)
(define-key global-map (kbd "C-,") 'helm-projectile)

;; 
;; kill-ring
;; 
;; \M-y でキルリング履歴
(setq kill-ring-max 200) ;; kill-ring の最大値. デフォルトは 30.
(setq helm-kill-ring-threshold 50) ;; anything で対象とするkill-ring の要素の長さの最小値.デフォルトは 10.
(global-set-key "\M-y" 'helm-show-kill-ring)

(require 'helm-imenu)
(defun my/helm-tags ()
  (interactive)
  (helm :sources '(helm-source-imenu
                   helm-source-gtags-select)
        :buffer "*helm gtasg and imenu*"))

(global-set-key (kbd "C-+") 'my/helm-tags)

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

;; 
;; omnisharp
;;

