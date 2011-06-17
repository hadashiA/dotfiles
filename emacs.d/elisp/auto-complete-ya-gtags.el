;;; auto-complete-ya-gtags.el --- a source for auto-complete

;; Copyright (C) 2011 whitypig

;; Author: whitypig <whitypig@gmail.com>
;; Keywords: auto-complete
;; Version: 0.1

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(eval-when-compile
  (require 'cl))
(require 'auto-complete)

;; Variables
(defvar ac-ya-gtags-current-dbpath nil
  "A pathname to the directory in which currently using GTAGS exists.
nil means no GTAGS found.")

(defvar ac-ya-gtags-dbpath nil
  "A pathname to the directory in which GTAGS for the current buffer resides.
This variable becomes buffer-local automatically.")
(make-variable-buffer-local 'ac-ya-gtags-dbpath)

(defvar ac-ya-gtags-completion-table nil
  "A completion table for the currently using GTAGS.")

(defvar ac-ya-gtags-candidate-limit 30
  "The limit number of candidates. nil means no limit.")

(defconst ac-ya-gtags-global-not-found-message "global: GTAGS not found."
  "A message from global when GTAGS is not found.")

;; Face
(defface ac-ya-gtags-candidate-face
  '((t (:background "lightgray" :foreground "navy")))
  "Face for ya-gtags candidates."
  :group 'auto-complete)

(defface ac-ya-gtags-selection-face
  '((t (:background "navy" :foreground "white")))
  "Face for the ya-gtags selected candidate."
  :group 'auto-complete)

;; Functions
(defun ac-ya-gtags-get-tagdir-name ()
  (car (split-string (shell-command-to-string "global -p") "\n")))

(defun ac-ya-gtags-reset ()
  "Reset `ac-ya-gtags-dbpath' to nil, which means that the
currently using pathname will be updated.
Use this command when you have created or updated GTAGS."
  (interactive)
  (setq ac-ya-gtags-dbpath (ac-ya-gtags-get-tagdir-name)))

(defun ac-ya-gtags-require-update ()
  "Return t if `ac-ya-gtags-completion-table' needs an update.

If `ac-ya-gtags-dbpath' is nil, we have to find out if GTAGS
exits. If `ac-ya-gtags-dbpath' is equal to
`ac-ya-gtags-global-not-found-message', we don't need to do
completion using ac-source-ya-gtags because there is no
GTAGS. And if `ac-ya-gtags-get-tagdir-name' points to some
directory and it is not equal to `ac-ya-gtags-current-dbpath',
this means we need to return t to notify that the completion
table needs to be updated."
  (unless ac-ya-gtags-dbpath
    (setq ac-ya-gtags-dbpath (ac-ya-gtags-get-tagdir-name)))
  ;; invariant: ac-ya-gtags-dbpath is not nil.
  (cond
   ((string= ac-ya-gtags-dbpath ac-ya-gtags-global-not-found-message)
    ;; GTAGS is not found, so we don't need to complete using ac-ya-gtags.
    (setq ac-ya-gtags-current-dbpath nil)
    (setq ac-ya-gtags-completion-table nil)
    nil)
   ((string= ac-ya-gtags-dbpath ac-ya-gtags-current-dbpath)
    ;; this buffer's GTAGS and the current GTAGS is the same,
    ;; and the completion table must have already been created,
    ;; so do nothing.
    nil)
   ((not (string= ac-ya-gtags-dbpath ac-ya-gtags-current-dbpath))
    ;; This is a new GTAGS
    (setq ac-ya-gtags-current-dbpath ac-ya-gtags-dbpath)
    t)
   (t (error "This can't happen in ac-ya-gtags-require-update")
      nil)))

(defun ac-ya-gtags-init ()
  "Check and update completeion table if need be."
  (when (ac-ya-gtags-require-update)
    ;; We have to create a new completion table.
    (setq ac-ya-gtags-completion-table
          (split-string (shell-command-to-string (format "global -c")) "\n"))))

(defun ac-ya-gtags-candidate ()
  (ac-ya-gtags-init)
  (when (and ac-ya-gtags-dbpath
             (not (string= ac-ya-gtags-dbpath ac-ya-gtags-global-not-found-message)))
    (let* ((candidates (all-completions ac-target ac-ya-gtags-completion-table))
           (len (length candidates)))
      (when (and (numberp ac-ya-gtags-candidate-limit)
                 (> len ac-ya-gtags-candidate-limit))
        (nbutlast candidates (- len ac-etags-candidates-limit)))
      candidates)))

(ac-define-source ya-gtags
  '((candidates . ac-ya-gtags-candidate)
    (candidate-face . ac-ya-gtags-candidate-face)
    (selection-face . ac-ya-gtags-selection-face)
    (requires . 3)
    (symbol . "s")))

(provide 'auto-complete-ya-gtags)
;;; auto-complete-ya-gtags.el ends here
