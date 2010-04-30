;;; sorter.el --- cycles dired listing between name/date/extension/size

;; Author: Tom Wurgler (twurgler@goodyear.com)   4/27/1999
;; Modify: Hideyuki SHIRAI <shirai@meadowy.org>  2008-03-04

;; sorter.el is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; sorter.el is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, you can either send email to this
;; program's maintainer or write to: The Free Software Foundation,
;; Inc.; 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

;; Requires GNU ls from fileutils at the standard GNU sites.

;;; Usage
;; Add these lines to your .emacs file and set insert-directory-program
;; to point to your GNU ls.

;; (add-hook 'dired-load-hook
;;	  (lambda ()
;;	    (require 'sorter))))
;; (setq insert-directory-program "~/GNUls")

(defun dired-toggle-sort (&optional reset)
  "Toggle between sort by name/date/extension/size and refresh the dired.
If called with '\\[universal-argument]', return to original switches."
  (interactive "P")
  (cond
   (reset
    (setq dired-actual-switches dired-listing-switches)
    (dired-sort-other dired-actual-switches))
   ((string-match "t" dired-actual-switches)
    (setq dired-actual-switches
	  (sorter-translate  dired-actual-switches "t" "S"))
    (dired-sort-other dired-actual-switches))
   ((string-match "S" dired-actual-switches)
    (setq dired-actual-switches
	  (sorter-translate  dired-actual-switches "S" "X"))
    (dired-sort-other dired-actual-switches))
   ((string-match "X" dired-actual-switches)
    (setq dired-actual-switches
	  (sorter-translate  dired-actual-switches "X" ""))
    (dired-sort-other dired-actual-switches))
   (t (setq dired-actual-switches
	   (concat dired-actual-switches "t"))
     (dired-sort-other dired-actual-switches))))

(add-hook 'dired-mode-hook
	  (lambda ()
	    (define-key dired-mode-map "s" 'dired-toggle-sort)))

(defun dired-sort-set-modeline ()
  ;; Setq modeline display according to dired-actual-switches.
  ;; Modeline display of "by name" or "by date" guarantees the user a
  ;; match with the corresponding regexps.  Non-matching switches are
  ;; shown literally.
  (setq mode-name
	(let (case-fold-search)
	  (cond
	   ((string-match dired-sort-by-name-regexp dired-actual-switches)
	    "Dired by name")
	   ((string-match dired-sort-by-date-regexp dired-actual-switches)
	    "Dired by date")
	   ((string-match "X" dired-actual-switches)
	    "Dired by ext")
	   ((string-match "S" dired-actual-switches)
	    "Dired by size")
	   (t
	    (concat "Dired " dired-actual-switches)))))
  (force-mode-line-update))

(defun dired-toggle-hidden ()
  "Toggles between showing hidden files and not showing them."
  (interactive)
  (if (string-match "a" dired-actual-switches)
      (setq dired-actual-switches
	    (sorter-translate dired-actual-switches "a" ""))
    (setq dired-actual-switches (concat dired-actual-switches "a")))
  (dired-sort-other dired-actual-switches))

(defun sorter-translate (string1 string2 string3)
  "Change every occurence in STRING of FSTRING with RSTRING."
  (let ((case-fold-search nil))
    (while (string-match string2 string1)
      (if (string-equal string3 "")
	  (setq string1 (concat
			 (substring string1 0 (match-beginning 0))
			 (substring string1 (match-end 0))))
	(aset string1
	      (match-beginning 0) (string-to-char string3)))))
  string1)

(provide 'sorter)
