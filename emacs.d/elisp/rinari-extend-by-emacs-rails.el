;; rinari-extend-by-emacs-rails.el --- http://d.hatena.ne.jp/authorNari/20090611/1244732270

;; rinari-extend-by-emacs-rails.el
(defvar rails-ri-command "fri"
  "ri command"
)

(defvar rails-tags-dirs '("app" "lib" "test" "db" "vendor")
  "make tag target directories"
)

(defvar rails-tags-command "etags %s"
  "make tag target directories"
)

;; helper functions/macros
(defun rails-search-doc-at-point (&optional item)
  (interactive)
  (setq item (if item item (thing-at-point 'sexp)))
  (rails-search-ri item)
)

(defun rails-search-doc (&optional item)
  (interactive)
  (setq item (read-string "Search symbol: " (if item item (thing-at-point 'sexp))))
  (rails-search-ri item)
)

(defun rails-search-doc-for-ri (&optional item)
  (interactive)
  (setq item (thing-at-point 'filename))
  (setq item (if (string-match "," item)
                 (replace-match "" nil nil item)))
  (rails-search-doc item)
)

(defun rails-search-ri (&optional item)
  (if item
      (let ((buf (buffer-name)))
        (unless (string= buf "*ri*")
          (switch-to-buffer-other-window "*ri*"))
        (setq buffer-read-only nil)
        (kill-region (point-min) (point-max))
        (message (concat "Please wait..."))
        (call-process rails-ri-command nil "*ri*" t item)
        (local-set-key [f1] 'rails-search-doc)
        (local-set-key [return] 'rails-search-doc-for-ri)
        (ansi-color-apply-on-region (point-min) (point-max))
        (setq buffer-read-only t)
        (goto-char (point-min)))))

(defun rails-create-tags()
  "Create tags file"
  (interactive)
   (message "Creating TAGS, please wait...")
   (let ((tags-file-name (concat (rinari-root) "TAGS")))
     (shell-command
      (format rails-tags-command tags-file-name
        (mapconcat (function (lambda (s) (concat (rinari-root) "" s)))
                   rails-tags-dirs " ")))
     (visit-tags-table tags-file-name)))

(provide 'rinari-extend-by-emacs-rails)
