;; By an unknown contributor
(global-set-key "%" 'match-paren)
(global-set-key (kbd "C-%")
                '(lambda ()
                   (interactive)
                   (insert "%")))

(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))
