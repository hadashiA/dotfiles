(setq lunekichi-mode-map (make-keymap))

(defun lunekichi-insert-message (char)
  "insert lunekichi-message"
  (interactive)
  (insert (concat "僕luneえもん" char "ナリよ")))

(defun lunekichi-set-keybind (char)
  "set alphabet insert 僕luneえもんAナリよ"
  (interactive)
  (define-key lunekichi-mode-map char
    '(lambda ()))
  )

(defun lunekichi-mode ()
  "僕るねえもんナリよ."
  (interactive)
  (setq major-mode 'luneikichi-mode
        mode-name "僕luneえもんナリよ"))

  

  (dolist (char (string-to-list "abcdefghijklmnopqrstuvwxyz"))
    (define-key lunekichi-mode-map (char-to-string char)
      ;; '(lambda () (interactive) (lunekichi-insert-message (char-to-string char)))
      '(lambda () (interactive) (insert (char-to-string char))
      ))
  (use-local-map lunekichi-mode-map)))
  



