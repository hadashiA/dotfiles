(global-undo-tree-mode t)
(global-set-key (kbd "M-/") 'undo-tree-redo)

(global-set-key (kbd "M-?") 'point-undo)
(global-set-key (kbd "C-c M-?") 'point-redo)

(global-set-key (kbd "C-?") 'goto-last-change)

