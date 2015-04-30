(require 'helm-projectile)

(setq projectile-completion-system 'helm
      projectile-enable-caching t
      projectile-use-native-indexing t
      projectile-indexing-method 'native)

(projectile-global-mode)
(helm-projectile-on)

(define-key global-map (kbd "C-,") 'helm-projectile)

(setq hp:project-files-filters
      (list
       (lambda (files)
         (remove-if 'file-directory-p files))))

