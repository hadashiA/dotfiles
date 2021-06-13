(use-package super-save
  :straight t
  :ensure t
  :config
  (super-save-mode +1)
  (setq super-save-auto-save-when-idle t)
  (setq auto-save-default nil)
  (setq super-save-remote-files nil)
  (setq super-save-exclude '(".gpg" ".dll")))
