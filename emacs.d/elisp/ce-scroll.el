;;------ common editor scroll ------
;; Author: Ein Terakawa (Applause) <applause@tky.3web.ne.jp>
;; Version: 1.11
;; WhereToGet: http://www.tky.3web.ne.jp/~applause/emacs-lisp/

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with your Emacs; if not, write to the Free Software
;; Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
;; Also you can get the GPL from http://www.gnu.org/copyleft/gpl.txt .


;; To change height of barrier, do
;; (setq ce-barrier-lines N)
;; in .emacs .
(defvar ce-barrier-lines 2
  "Height of barrier in lines, where cursor wouldn't enter but scroll.")

(defvar ce-smooth-scroll t
  "Set to non-nil enables smooth (line by line) scrolling." )

(defun ce-lines-to-scroll (a)
  "Return a number of lines to scroll.
Re-define this function to customize.
\"A\" is an argument passed to ce-scroll-up/down."
  (or a (min 30 (- (window-height) 1 next-screen-context-lines))))


;; Comment out followings if you don't need it.
(define-key global-map [next] 'ce-scroll-up)
(define-key global-map [prior] 'ce-scroll-down)
(define-key global-map "\C-v" 'ce-scroll-up)
(define-key global-map "\M-v" 'ce-scroll-down)
(define-key global-map [up] 'ce-previous-line)
(define-key global-map [down] 'ce-next-line)
(define-key global-map [M-up] 'ce-scroll-down-1)
(define-key global-map [M-down] 'ce-scroll-up-1)
(define-key global-map [home] 'ce-beginning-of-line)
(define-key global-map [end] 'ce-end-of-line)
(define-key global-map "\C-a" 'ce-beginning-of-line)
(define-key global-map "\C-e" 'ce-end-of-line)
(define-key global-map "\C-p" 'ce-previous-line)
(define-key global-map "\C-n" 'ce-next-line)


(defvar ce-temporary-goal-row 0)
(defvar ce-dead-end-flag nil)
(defvar ce-temporary-scroll-lines 0)

(defvar ce-line-save-column-list 
  '(next-line previous-line ce-next-line ce-previous-line))
(defvar ce-scroll-save-column-list
  '(ce-scroll-up ce-scroll-down ce-scroll-up-1 ce-scroll-down-1))

(defun ce-current-line ()
  "Print the current line number (in the buffer) of point."
  (interactive)
  (save-restriction
    (widen)
    (save-excursion
      (beginning-of-line)
	       (1+ (count-lines 1 (point))))))

(defun ce-current-row ()
  (save-excursion
    (save-restriction
      (narrow-to-region (window-start) (point-max))
      (- (vertical-motion (- (window-height)))))))

(defun ce-flob-p ()
"Return t if point is at the first line of the buffer."
  (save-excursion
    (= (vertical-motion -1) 0)
    )
  )

(defun ce-llob-p ()
"Return t if point is at the last line of the buffer."
  (save-excursion
    (= (vertical-motion 1) 0)
    )
  )


(defun ce-lliw-p ()
"Return t if the last line of the buffer is in the window."
  (pos-visible-in-window-p (point-max))
  )

(defun ce-fliw-p ()
"Return t if the first line of the buffer is in the window."
  (pos-visible-in-window-p (point-min))
)


(defun ce-eolp ()
  (let ((p (point)))
    (save-excursion
      (ce-end-of-line)
      (= p (point)))))

(defun ce-bolp ()
  (let ((p (point)))
    (save-excursion
      (ce-beginning-of-line)
      (= p (point)))))


(defun ce-current-column ()
  (let ((cc (current-column)))
    (save-excursion
      (vertical-motion 0)
      (- cc (current-column)))))

(defun ce-move-to-column (c)
  (let (p)
    (if (= (vertical-motion 1) 0)
	(progn
	  (vertical-motion 0)
	  (move-to-column (+ (current-column) c)))
      (setq p (point))
      (vertical-motion -1)
      (move-to-column (+ (current-column) c))
      (if (>= (point) p)
	  (progn
	    (goto-char p)
	    (backward-char 1)))
      )
    )
  )

(defun ce-temporary-goal-column ()
  (if (and track-eol (ce-eolp)
	   ;; Don't count beg of empty line as end of line
	   ;; unless we just did explicit end-of-line.
	   (or (not (ce-bolp))
	       (memq last-command '(end-of-line ce-end-of-line))))
      9999
    (ce-current-column)
    )
  )
(defun ce-previous-line (a) (interactive "p")
  (if (not (memq last-command 
		 ce-line-save-column-list))
      (setq temporary-goal-column (ce-temporary-goal-column)))
  (if (ce-flob-p) (ding)
    (setq f 
	  (if (> (ce-current-row) ce-barrier-lines) nil
	    (not (ce-fliw-p))))
    (if f (scroll-down 1))
    (vertical-motion -1)
    (ce-move-to-column (or goal-column temporary-goal-column))
    )
  )

(defun ce-next-line (a) (interactive "p")
  (if (not (memq last-command 
		 ce-line-save-column-list))
      (setq temporary-goal-column (ce-temporary-goal-column)))
  (if (ce-llob-p)(ding)
    (let (f)
      (setq f 
	    (if (< (ce-current-row) (- (window-height) (+ 2 ce-barrier-lines))) nil
	      (not (ce-lliw-p))))
      (if f (scroll-up 1))
      (vertical-motion 1)
      (ce-move-to-column (or goal-column temporary-goal-column))
      )
    )
  )


(defun ce-scroll-up (a &optional b)(interactive "P")
  (if (memq last-command ce-scroll-save-column-list) nil
    (setq temporary-goal-column
	    (ce-temporary-goal-column))
    (setq ce-temporary-goal-row
	  (ce-current-row))
    (setq ce-dead-end-flag nil)
    (setq ce-temporary-scroll-lines 0)
    )
  (setq a (ce-lines-to-scroll a))
  (if (< a 0)(ce-scroll-down a b)
    (if (and ce-dead-end-flag (memq last-command '(ce-scroll-down ce-scroll-down-1)))
      (progn
	(setq ce-dead-end-flag nil)
	(move-to-window-line ce-temporary-goal-row))
      (if (< 0 ce-temporary-scroll-lines)
	(progn
	  (if ce-smooth-scroll
	    (let ((i 0))
	      (while (< i ce-temporary-scroll-lines)
		(scroll-up 1)
		(sit-for 0)
		(setq i (1+ i))))
	    (scroll-up ce-temporary-scroll-lines))
	  (move-to-window-line ce-temporary-goal-row)
	  (setq ce-temporary-scroll-lines 0))
	(if (ce-lliw-p)
	    (if (or b (ce-llob-p))(ding)
	      (goto-char (point-max))
	      (setq ce-dead-end-flag t))
	  (let (tmp (i 0))
	    (setq tmp (save-excursion 
			(move-to-window-line (- (window-height) 2))
			(vertical-motion a)))
	    (if (= tmp a) nil 
	      (setq a tmp)
	      (setq ce-temporary-scroll-lines (- a)))
	    (if ce-smooth-scroll
		(while (< i a)
		  (scroll-up 1)
		  (sit-for 0)
		  (setq i (1+ i)))
	      (scroll-up a))
	    )
	  (move-to-window-line ce-temporary-goal-row)
	  )
	)
      )
    (ce-move-to-column (or goal-column temporary-goal-column))
    )
  )


(defun ce-scroll-down (a &optional b)(interactive "P")
  (if (memq last-command ce-scroll-save-column-list) nil
    (setq temporary-goal-column
	  (ce-temporary-goal-column))
    (setq ce-temporary-goal-row
	  (ce-current-row))
    (setq ce-dead-end-flag nil)
    (setq ce-temporary-scroll-lines 0)
    )
  (setq a (ce-lines-to-scroll a))
  (if (< a 0)(ce-scroll-up a b)
    (if (and ce-dead-end-flag (memq last-command '(ce-scroll-up ce-scroll-up-1)))
      (progn
	(setq ce-dead-end-flag nil)
	(move-to-window-line ce-temporary-goal-row))
      (if (> 0 ce-temporary-scroll-lines)
	  (progn
	    (setq ce-temporary-scroll-lines (- ce-temporary-scroll-lines))
	    (if ce-smooth-scroll
		(let ((i 0))
		  (while (< i ce-temporary-scroll-lines)
		    (scroll-down 1)
		    (sit-for 0)
		    (setq i (1+ i))))
	      (scroll-down ce-temporary-scroll-lines))
	    (move-to-window-line ce-temporary-goal-row)
	    (setq ce-temporary-scroll-lines 0))
	(if (ce-fliw-p)
	    (if (or b (ce-flob-p))(ding)
	      (goto-char (point-min))
	      (setq ce-dead-end-flag t))
	  (let (tmp (i 0))
	    (setq tmp (save-excursion 
			(move-to-window-line 0)
			(- (vertical-motion (- a)))))
	    (if (= tmp a) nil 
	      (setq a tmp)
	      (setq ce-temporary-scroll-lines a))
	    (if ce-smooth-scroll
		(while (< i a)
		  (scroll-down 1)
		  (sit-for 0)
		  (setq i (1+ i)))
	      (scroll-down a)
	      )
	    )
	  (move-to-window-line ce-temporary-goal-row)
	  )
	)
      )
    (ce-move-to-column (or goal-column temporary-goal-column))
    )
  )

(defun ce-beginning-of-line ()(interactive)
  (vertical-motion 0)
  )

(defun ce-end-of-line ()(interactive)
  (if (= (vertical-motion 1) 0)
    (goto-char (point-max))
    (backward-char)))

(defun ce-scroll-up-1 ()(interactive)
  (ce-scroll-up 1 t))
(defun ce-scroll-down-1 ()(interactive)
  (ce-scroll-down 1 t))
