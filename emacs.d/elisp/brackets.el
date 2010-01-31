;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;  brackets.el -- 
;;;	author: nakai <nakai@mcl.chem.tohoku.ac.jp>
;;;	create day  : Sun Nov 17 17:48:56 2002
;;;     last updated: Sun Nov 17 18:25:29 2002
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun insert-braces (arg)
  "A pair of brace is insert automatically."
  (interactive "p")
  (let()
    (progn
      (insert "{}")
      (backward-char 1)))
  )
(defun insert-brackets (arg)
  "A pair of square bracket is insert automatically."
  (interactive "p")
  (let()
    (progn
      (insert "[]")
      (backward-char 1)))
  )
(defun insert-parens (arg)
  "A pair of round bracket is insert automatically."
  (interactive "p")
  (let()
    (progn
      (insert "()")
      (backward-char 1)))
  )
(defun insert-double-quotation (arg)
  "A pair of double quatation is insert automatically."
  (interactive "p")
  (let()
    (progn
      (insert "\"\"")
      (backward-char 1)))
  )
(defun insert-angle (arg)
  "A pair of angle bracket is insert automatically."
  (interactive "p")
  (let()
    (progn
      (insert "<>")
      (backward-char 1)))
  )
(defun insert-braces-region (beg end &optional open close)
  (interactive "r")
  (save-excursion
    (goto-char end)
    (insert (or close "}"))
    (goto-char beg)
    (insert (or open "{"))))
(defun insert-brackets-region (beg end)
  (interactive "r")
  (insert-braces-region beg end "[" "]"))
(defun insert-parens-region (beg end)
  (interactive "r")
  (insert-braces-region beg end "(" ")"))
(defun insert-double-quotation-region (beg end)
  (interactive "r")
  (insert-braces-region beg end "\"" "\""))
(defun insert-angle-region (beg end)
  (interactive "r")
  (insert-braces-region beg end "<" ">"))

