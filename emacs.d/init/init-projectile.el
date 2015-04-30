(require 'helm-projectile)

(define-key global-map (kbd "C-,") 'helm-projectile)
(setq projectile-enable-caching t)
(setq projectile-use-native-indexing t)
(define-key global-map (kbd "C-,") 'helm-project)
(setq hp:project-files-filters
      (list
       (lambda (files)
         (remove-if 'file-directory-p files))))

