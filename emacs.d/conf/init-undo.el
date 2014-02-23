(global-undo-tree-mode t)
(global-set-key (kbd "M-/") 'undo-tree-redo)

(when (require 'point-undo)
  (global-set-key (kbd "M-?") 'point-undo)
  (global-set-key (kbd "C-c M-?") 'point-redo))

(when (require 'goto-last-change)
  (global-set-key (kbd "C-?") 'goto-last-change))

