(use-package markdown-mode
  :straight t
  :init
  (add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
  (setq markdown-fontify-code-blocks-natively t))
