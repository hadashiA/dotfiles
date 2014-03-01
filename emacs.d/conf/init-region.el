(delete-selection-mode)

(global-set-key (kbd "C-@") 'er/expand-region)
(global-set-key (kbd "C-`") 'er/contract-region) ;; リージョンを狭める

;; transient-mark-modeが nilでは動作しませんので注意
(transient-mark-mode t)

;; (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

;; (global-set-key (kbd "C->") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "M->") 'mc/mark-next-like-this)
(global-set-key (kbd "M-<") 'mc/mark-previous-lines)
(global-set-key (kbd "C-c M-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c C-@") 'set-rectangular-region-anchor)
(global-set-key (kbd "C-c C-SPC") 'set-rectangular-region-anchor)

