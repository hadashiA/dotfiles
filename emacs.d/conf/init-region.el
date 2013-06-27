(global-set-key (kbd "C-@") 'er/expand-region)
(global-set-key (kbd "C-`") 'er/contract-region) ;; リージョンを狭める

;; transient-mark-modeが nilでは動作しませんので注意
(transient-mark-mode t)
