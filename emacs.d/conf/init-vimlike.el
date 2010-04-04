(defun search-to-char-forward (arg char)
  (interactive "p\ncSearch to forward char: ")
  (search-forward (char-to-string char) nil nil arg)
  (backward-char))

(defun search-to-char-backward (arg char)
  (interactive "p\ncSearch to backward char: ")
  (search-backward (char-to-string char) nil nil arg))

(global-set-key "\M-s" 'search-to-char-forward)
(global-set-key "\M-r" 'search-to-char-backward)