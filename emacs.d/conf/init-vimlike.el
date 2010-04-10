(defvar vimlike-f-recent-char nil)
(defvar vimlike-f-recent-func nil)

(defun vimlike-f (char)
  "search to forward char into current line and move point (vim 'f' command)"
  (interactive "cSearch to forward char: ")
  (when (= (char-after (point)) char)
    (forward-char))
  ;; (search-forward (char-to-string char) (point-at-eol) nil 1)
  (migemo-forward (char-to-string char) (point-at-eol) t 1)
  (backward-char)
  (setq vimlike-f-recent-search-char char
        vimlike-f-recent-search-func 'vimlike-f))

(defun vimlike-F (char)
  "search to forward char into current line and move point. (vim 'F' command)"
  (interactive "cSearch to backward char: ")
  ;; (search-backward (char-to-string char) (point-at-bol) nil 1)
  (migemo-backward (char-to-string char) (point-at-bol) t 1)
  (setq vimlike-f-recent-search-char char
        vimlike-f-recent-search-func 'vimlike-F))

(defun vimlike-semicolon ()
  "search repeat recent vimlike 'f' or 'F' search char (vim ';' command)"
  (interactive)
  (if (and vimlike-f-recent-search-char
             vimlike-f-recent-search-func)
      (funcall vimlike-f-recent-search-func vimlike-f-recent-search-char)
    (message "Empty recent search char.")))

(global-set-key "\M-s" 'vimlike-f)
(global-set-key "\M-r" 'vimlike-F)
(global-set-key "\M-j" 'vimlike-semicolon)

