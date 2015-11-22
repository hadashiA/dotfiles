(global-git-gutter-mode +1)

(smartrep-define-key global-map  "C-x"
  '(("p" . 'git-gutter:previous-hunk)
    ("n" . 'git-gutter:next-hunk)))

