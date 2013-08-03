(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(global-set-key (kbd "C-x SPC") 'ace-jump-mode-pop-mark)
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)
