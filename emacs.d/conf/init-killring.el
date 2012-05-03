;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; C-S-y で行のコピー
(defun duplicate-line (&optional numlines)
  "One line is duplicated wherever there is a cursor."
  (interactive "p")
  (let* ((col (current-column))
         (bol (progn (beginning-of-line) (point)))
         (eol (progn (end-of-line) (point)))
         (line (buffer-substring bol eol)))
    (while (> numlines 0)
      (insert "\n" line)
      (setq numlines (- numlines 1)))
    (move-to-column col)))

;; (define-key esc-map "Y" 'duplicate-line)
(global-set-key (kbd "C-S-y") 'duplicate-line)

(defun copy-current-file-path ()
  (interactive)
  (kill-new buffer-file-name)
  (message "copy \"%s\"" buffer-file-name))

(defun copy-current-directory-path ()
  (interactive)
  (kill-new default-directory)
  (message "Copy \"%s\"" default-directory))

(global-set-key (kbd "C-c c") 'copy-current-file-path)
;; (global-set-key (kbd "C-c d") 'copy-current-directory-path)
