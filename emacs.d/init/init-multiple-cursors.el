(use-package multiple-cursors
  :straight t
  :bind
  ("C-S-c C-S-c" . 'mc/edit-lines)
  ("M->" . 'mc/mark-next-like-this)
  ("M-<" . 'mc/mark-previous-lines)
  ("C-c M-<" . 'mc/mark-all-like-this)
  ("C-c C-SPC" . 'set-rectangular-region-anchor))
g
