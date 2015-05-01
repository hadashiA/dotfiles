(require 'rcodetools)
  
(setq rct-find-tag-if-available nil)
(defun ruby-mode-hook-rcodetools ()
  (define-key ruby-mode-map "\M-\C-i" 'rct-complete-symbol)
  (define-key ruby-mode-map "\C-c\C-t" 'ruby-toggle-buffer)
  (define-key ruby-mode-map "\C-c\C-d" 'xmp)
  (define-key ruby-mode-map "\C-c\C-f" 'rct-ri))

;(global-set-key (kbd "<C-return>") 'xmp)

(add-hook 'ruby-mode-hook 'ruby-mode-hook-rcodetools)
(defun make-ruby-scratch-buffer ()
  (with-current-buffer (get-buffer-create "*ruby scratch*")
    (ruby-mode)
    (current-buffer)))

(defun ruby-scratch ()
  (interactive)
  (pop-to-buffer (make-ruby-scratch-buffer)))

(add-hook
 'ruby-mode-hook
 '(lambda ()
    (mapc (lambda (pair)
            (apply #'define-key ruby-mode-map pair))
          (list
           ;; '([(meta i)] rct-complete-symbol)
           ;; '([(meta control i)] rct-complete-symbol)
           ;; '([(control c) (control t)] ruby-toggle-buffer)
           '([(control c) (control f)] rct-ri)
           '([(control c) (control d)] xmp)))))
