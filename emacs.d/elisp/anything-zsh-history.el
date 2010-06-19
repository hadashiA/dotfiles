(require 'anything-complete)

;; (defun anything-zsh-history-from-zle ()
;;   (interactive)
;;   (azh/set-frame)
;;   (let ((anything-samewindow t)
;;         (anything-display-function 'anything-default-display-buffer))
;;     (azh/set-command
;;      (anything-other-buffer
;;       `(((name . "History")
;;          (action
;;           ("Paste" . identity)
;;           ("Edit" . azh/edit-command))
;;          ,@anything-c-source-complete-shell-history))
;;       "*anything zsh history*"))))

;; (defvar azh/tmp-file "/tmp/.azh-tmp-file")
;; (defvar azh/frame nil)

;; (defun azh/set-frame ()
;;   (unless (and azh/frame (frame-live-p azh/frame))
;;     (setq azh/frame (make-frame '((name . "zsh history")
;;                                   (title . "zsh history")))))
;;   (select-frame azh/frame)
;;   (sit-for 0))
;; ;; (progn (azh/set-frame) (anything))
;; (defun azh/set-command (line)
;;   (write-region (or line "") nil azh/tmp-file)
;;   (azh/close-frame))

;; (defun azh/close-frame ()
;;   (ignore-errors (make-frame-invisible azh/frame))
;;   (when (fboundp 'do-applescript)
;;     (funcall 'do-applescript "tell application \"iTerm\"
;;                                 activate
;;                              end")))

;; (defun azh/edit-command (line)
;;   (switch-to-buffer "*zsh command edit*")
;;   (erase-buffer)
;;   (setq buffer-undo-list nil)
;;   (azh/edit-mode)
;;   (insert line)
;;   (recursive-edit)
;;   (buffer-string))

;; (define-derived-mode azh/edit-mode fundamental-mode
;;   "Press C-c C-c to exit!"
;;   "Edit zsh command line"
;;   (define-key azh/edit-mode-map "\C-c\C-c" 'azh/edit-exit))

;; (defun azh/edit-exit ()
;;   (interactive)
;;   (exit-recursive-edit))

(defun anything-zsh-history-from-zle (file &optional input)
  (interactive)
  (let ((anything-samewindow t)
        (anything-display-function 'anything-default-display-buffer))
    (azh/set-command
     (anything
      `(((name . "History")
         (action
          ("Paste" . identity)
          ("Edit" . azh/edit-command))
         ,@anything-c-source-complete-shell-history))
      input
      nil nil nil
      "*anything zsh history*")
     file)))

(defun azh/set-command (line file)
  (write-region (or line "") nil file)
  (delete-frame))

(defun azh/edit-command (line)
  (switch-to-buffer "*zsh command edit*")
  (erase-buffer)
  (setq buffer-undo-list nil)
  (azh/edit-mode)
  (insert line)
  (recursive-edit)
  (buffer-string))

(define-derived-mode azh/edit-mode fundamental-mode
  "Press C-c C-c to exit!"
  "Edit zsh command line"
  (define-key azh/edit-mode-map "\C-c\C-c" 'azh/edit-exit))

(defun azh/edit-exit ()
  (interactive)
  (exit-recursive-edit))

(provide 'anything-zsh-history)

