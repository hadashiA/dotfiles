(defvar matelike-delete-pair-alist
  '((?{ . ?})
    (?[ . ?])
    (?( . ?))
    (?\" . ?\")
    (?\' . ?\'))
  "*pair of parentheses alist")

;; (defadvice backward-delete-char-untabify
;;   (before matelike-backward-delete-bracket activate)
;;   (save-excursion
;;     (let ((pair (assoc (char-after (1- (point))) my-delete-pair-alist))
;;           (bracket-start (1- (point)))
;;           (bracket-end nil))
;;       (while (and (pair)
;;                   (setq bracket-end
;;                    (search-forward (char-to-string (cdr pair)) (point-max) t 1)))
;;         (if (search-backward (char-to-string (car pair)) bracket-start)
;;             (delete-char 1)
;;         )))))

;; (defun matelike-backward-delete-pair ()
;;   "backward char and delete-pair"
;;   (interactive)
;;   (if (assoc (char-before (point)) matelike-delete-pair-alist)
;;       (progn
;;         (backward-char)
;;         (delete-pair))
;;     (backward-delete-char-untabify 1)))
;; (global-set-key "\C-h" 'matelike-backward-delete-pair)

(defun matelike-delete-pair ()
  "wrap delete-pair only specify char"
  (interactive)
  (if (assoc (char-after (point)) matelike-delete-pair-alist)
      (delete-pair)
    (delete-char 1)))

(global-set-key "\C-d" 'matelike-delete-pair)

(defadvice backward-delete-char-untabify
  (around matelike-backward-delete-pair activate)
  (if (assoc (char-before (point)) matelike-delete-pair-alist)
      (progn
        (backward-char)
        (delete-pair))
    ad-do-it))

;; (defadvice delete-char
;;   (around matelike-delete-pair activate)
;;   (if (assoc (char-after (point)) matelike-delete-pair-alist)
;;       (delete-char 1)
;;     ad-do-it))
