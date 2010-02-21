(defvar refe-program-name
  (if (featurep 'meadow)
      "ruby"
    "refe"))
(defvar refe-program-args
  (if (featurep 'meadow)
      '("-S" "refe")
    nil))
(defvar refe-buffer-name "*Refe*")
(defvar refe-completion-table nil)

(defun refe-call-process (buf &rest args)
  (let ((coding-system-for-read 'euc-japan))
    (apply 'call-process refe-program-name nil buf nil
           (append refe-program-args args))))

(defun refe-make-completion-table ()
  (setq refe-completion-table (make-vector 547 0))
  (with-temp-buffer
    (refe-call-process t)
    (goto-char (point-min))
    (while (looking-at "[A-Z][A-Za-z_0-9:]*")
      (intern (match-string 0) refe-completion-table)
      (skip-chars-forward "^ \n")
      (skip-chars-forward " \n")))

  (with-temp-buffer
    (refe-call-process t "")
    (goto-char (point-min))
    (while (looking-at "\\(\\$[^ \n]*\\|[A-Z][A-Za-z_0-9:]*[#.][^ \n]*\\)")
      (intern (match-string 0) refe-completion-table)
      (skip-chars-forward "^ \n")
      (skip-chars-forward " \n")))
  nil)

(refe-make-completion-table)

(defun refe-get-word-at-point ()
  (save-excursion
    (while (looking-at "\\sw\\|\\s_")
      (forward-char 1))
    (if (or (re-search-backward "\\sw\\|\\s_"
                                (save-excursion (beginning-of-line) (point))
                                t)
            (re-search-forward "\\(\\sw\\|\\s_\\)+"
                               (save-excursion (end-of-line) (point))
                               t))
        (progn (goto-char (match-end 0))
               (buffer-substring (point)
                                 (progn (forward-sexp -1)
                                        (while (looking-at "\\s'")
                                          (forward-char 1))
                                        (point))))
      nil)))

(defun refe ()
  (interactive)
  (if (null refe-completion-table)
      (refe-make-completion-table))
  (let* ((default (refe-get-word-at-point))
         (completion-ignore-case t)
         (word (completing-read (if default
                                    (format "Class or Method (default %s): " default)
                                  "Class or Method: ")
                                refe-completion-table nil nil nil nil default))
         (buf (or (get-buffer refe-buffer-name)
                  (generate-new-buffer refe-buffer-name)))
         (pop-up-windows t)
         (pop-up-frames nil))

    (set-buffer buf)
    (setq buffer-read-only nil)
    (erase-buffer)

    (refe-call-process buf word)

    (goto-char (point-min))
    (if (re-search-forward "^---" nil t)
        nil
      (let ((klass-table (make-vector 17 0))
            (completion-ignore-case t)
            klass)
        (goto-char (point-min))
        (while (looking-at "\\([A-Z][A-Za-z_0-9:]*\\)[#.][^ \n]*")
          (intern (match-string 1) klass-table)
          (skip-chars-forward "^ \n")
          (skip-chars-forward " \n"))
        (if (= (point) (point-min))
            nil ; (message "no such class or method: %s" word)
          (setq klass (completing-read "Class: "
                                       klass-table nil nil nil nil nil))
          (erase-buffer)
          (refe-call-process buf "--all" klass word))))

    (set-buffer-modified-p nil)
    (setq buffer-read-only t)
    (goto-char (point-min))
    (display-buffer buf)))

(provide 'refe)
