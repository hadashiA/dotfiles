(require 'csharp-mode)

(add-hook 'csharp-mode-hook
          '(lambda()
             (c-toggle-auto-newline t)
             (setq comment-column 40)
             (setq c-basic-offset 4)
             (c-set-offset 'substatement-open 0)
             (c-set-offset 'case-label '+)
             (c-set-offset 'arglist-intro '+)
             (c-set-offset 'arglist-close 0)
             
             (turn-on-eldoc-mode)
             (electric-pair-mode 0)
             (auto-complete-mode)

             (local-set-key (kbd "{") 'c-electric-brace)
             ))
