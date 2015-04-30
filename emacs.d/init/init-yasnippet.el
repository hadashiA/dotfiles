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

(setq yas-prompt-functions '(yas-dropdown-prompt
                             yas-ido-prompt
                             yas-completing-prompt))


;; yasnippet初期化
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"            ;; personal snippets
        ))

(yas-global-mode 1)

