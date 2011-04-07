(when (require 'smartchr nil)
  (global-set-key (kbd "=") (smartchr '(" = " " == " " != " "=")))

  (add-hook 'c-common-mode-hook
            (lambda ()
              (global-set-key (kbd "+") (smartchr '("+" " + " "++" " += ")))
              (global-set-key (kbd ">") (smartchr '(">" " >> " "->")))
              ))

  (add-hook 'ruby-mode-hook
            (lambda ()
              (global-set-key (kbd ">") (smartchr '(">" " => " " => '`!!''" " => \"`!!'\"")))
              (global-set-key (kbd "|") (smartchr '("|" " || " " ||= ")))
              
              ))

  (add-hook 'python-mode-hook
            (lambda ()
              (global-set-key (kbd "+") (smartchr '("+" " + " " += ")))
              ))
  )
