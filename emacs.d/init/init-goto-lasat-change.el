(global-set-key (kbd "C-?") 'goto-last-change)

(add-hook 'undo-tree-mode
          '(lambda ()
             (define-key undo-tree-map (kbd "C-?") nil)
             ))



