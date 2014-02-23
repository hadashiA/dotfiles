(smartparens-global-mode t)

;; By an unknown contributor
(global-set-key "%" 'match-paren)
(global-set-key (kbd "C-%")
                '(lambda ()
                   (interactive)
                   (insert "%")))

;; (defun match-paren (arg)
;;   "Go to the matching paren if on a paren; otherwise insert %."
;;   (interactive "p")
;;   (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
;;         ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
;;         (t (self-insert-command (or arg 1)))))

;; (defvar matelike-delete-pair-alist
;;   '((?{ . ?})
;;     (?[ . ?])
;;     (?( . ?))
;;     (?\" . ?\")
;;     (?\' . ?\'))
;;   "*pair of parentheses alist")

;; (defun matelike-delete-pair ()
;;   (interactive)
;;   (save-excursion
;;     (let ((pair (assoc (char-after (point)) matelike-delete-pair-alist))
;;           (pair-start-point (point))
;;           (pair-end-point nil)
;;           (count 1))

;;       (while (and pair
;;                   (search-forward (char-to-string (cdr pair)) (point-max) t count))
;;         (setq pair-end-point (point))
;;         (if (and
;;              (search-backward (char-to-string (car pair)) pair-start-point t count)
;;              (= (point) pair-start-point))
;;             (setq pair nil)
;;           (progn
;;             (setq count (1+ count))
;;             (goto-char pair-start-point)
;;             ))
;;         )

;;       (if (and pair pair-start-point pair-end-point)
;;           (progn
;;             (message (char-to-string (char-before  pair-start-point)))
;;             (message (char-to-string (char-before  pair-end-point)))
;;             ;; (goto-char pair-start-point)
;;             ;; (delete-char 1)
;;             ;; (goto-char pair-end-point)
;;             ;; (delete-char 1)
;;             ))
;;       )))

;; (defadvice backward-delete-char-untabify
;;   (around matelike-backward-delete-pair activate)
;;   (if (assoc (char-before (point)) matelike-delete-pair-alist)
;;       (progn
;;         (backward-char)
;;         (condition-case nil
;;             (delete-pair)
;;           (error (progn
;;                    (forward-char)
;;                    ad-do-it))))
;;     ad-do-it))

;; (defun matelike-delete-pair (&optional n)
;;   "wrap delete-pair only specify char"
;;   (interactive)
;;   (if (assoc (char-after (point)) matelike-delete-pair-alist)
;;       (condition-case nil
;;           (delete-pair)
;;         (error (delete-char 1)))
;;     (delete-char 1)))
;; (global-set-key "\C-d" 'matelike-delete-pair)

