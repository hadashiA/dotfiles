(require 'rcodetools)
  
(setq rct-find-tag-if-available nil)

(defun make-ruby-scratch-buffer ()
  (let*
      ((buffer-name-base "ruby scratch")
       (exist-buffer-count
        (length
         (remove nil
                 (mapcar
                  '(lambda (arg)
                     (string-match buffer-name-base
                                   (buffer-name arg)))
                  (buffer-list)))))))
    
    (with-current-buffer (get-buffer-create
                          (format "*%s<%s>*"
                                  buffer-name-base
                                  exist-buffer-count))
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

(defvar ruby-elect-keyword
  '("def" "if" "class" "module" "unless" "case"
    "while" "do" "until" "for" "begin" "end"))

