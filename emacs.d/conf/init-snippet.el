;; based upon

;; http://d.hatena.ne.jp/antipop/20080321/1206090430

(defun file-name-camelize ()
  (replace-regexp-in-string "[_-]" "" 
                            (capitalize (file-name-nondirectory
                                         (file-name-sans-extension
                                          (or (buffer-file-name)
                                              (buffer-name (current-buffer))))))))

(require 'yasnippet)

(define-key yas-minor-mode-map (kbd "C-o") 'yas-expand)
(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)

(setq yas-use-menu nil
      yas-buffer-local-condition
      '(or (not (or (string= "font-lock-comment-face"
                             (get-char-property (point) 'face))
                    (string= "font-lock-string-face"
                             (get-char-property (point) 'face))))
           '(require-snippet-condition . force-in-comment)))

(add-hook 'js2-mode-hook
          #'(lambda ()
              (setq yas/mode-symbol 'js2-mode)))

(add-hook 'js3-mode-hook
          #'(lambda ()
              (setq yas/mode-symbol 'js3-mode)))

;; (and (require 'dropdown-list nil t)
;;      (setq yas/text-popup-function
;;            #'yas/dropdown-list-popup-for-template))
(require 'dropdown-list)
(setq yas-prompt-functions '(yas-dropdown-prompt
                             yas-ido-prompt
                             yas-completing-prompt))

;;; [2008-03-17]
;;; yasnippet展開中はflymakeを無効にする

;; (defvar flymake-is-active-flag nil)

;; (defadvice yas/expand-snippet
;;   (before inhibit-flymake-syntax-checking-while-expanding-snippet activate)
;;   (setq flymake-is-active-flag
;;         (or flymake-is-active-flag
;;             (assoc-default 'flymake-mode (buffer-local-variables))))
;;   (when flymake-is-active-flag
;;     (flymake-mode-off)))


;; (add-hook 'yas/after-exit-snippet-hook
;;           '(lambda ()
;;              (when flymake-is-active-flag
;;                (flymake-mode-on)
;;                (setq flymake-is-active-flag nil))))

;; yasnippet初期化
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"            ;; personal snippets
        ))
(yas-global-mode 1)

