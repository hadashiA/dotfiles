(global-git-gutter-mode +1)

(smartrep-define-key global-map  "C-x"
  '(("p" . 'git-gutter:previous-diff)
    ("n" . 'git-gutter:next-diff)))

