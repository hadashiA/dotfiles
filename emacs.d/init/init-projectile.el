(setq projectile-completion-system 'helm
      projectile-enable-caching t
      projectile-use-native-indexing t
      projectile-indexing-method 'alien
      projectile-globally-ignored-file-suffixes '(".meta" ".dll" ".pbd" ".csproj" ".fbx" ".FBX")
      )

(projectile-global-mode)

(define-key projectile-mode-map (kbd "C-c o") 'projectile-toggle-between-implementation-and-test)



