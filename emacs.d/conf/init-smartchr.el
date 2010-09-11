(when (require 'smartchr nil)
  (global-set-key (kbd "=") (smartchr '(" = " " == " " != " "=")))
  (global-set-key (kbd ">") (smartchr '(">" " => " " => '`!!''" " => \"`!!'\"")))
  ;; (global-set-key (kbd "|") (smartchr '("|" " || " " ||= ")))
  (global-set-key (kbd "+") (smartchr '("+" " + " " += ")))

  (add-hook 'cc-mode-hook
            (lambda ()
              (global-set-key (kbd "+") (smartchr '("+" " + " "++" " += ")))
              (global-set-key (kbd ">") (smartchr '(">" " >> " "->")))
              ))
  )



