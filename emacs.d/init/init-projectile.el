(require 'helm-projectile)

(setq projectile-completion-system 'helm
      projectile-enable-caching t
      projectile-use-native-indexing t
      projectile-indexing-method 'native)

(projectile-global-mode)
(helm-projectile-on)

(define-key global-map (kbd "C-,") 'helm-projectile)
(define-key projectile-mode-map (kbd "C-c o") 'projectile-toggle-between-implementation-and-test)

(setq projectile-indexing-method 'alien)
