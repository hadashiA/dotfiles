;; sense-region.el
(require 'sense-region)
(sense-region-on)

;; backward-delete-char-untabify
(defadvice backward-delete-char-untabify
  (around ys:backward-delete-region activate)
  (if (eq sense-region-status 'rectangle)
      (delete-rectangle (region-beginning) (region-end))
    (if (and transient-mark-mode mark-active)
	(delete-region (region-beginning) (region-end))
      ad-do-it)))
(global-set-key "\C-h" 'backward-delete-char-untabify) ; backspace 'Ctrl-h'
