(when (require 'smartchr nil)
  (global-set-key (kbd "=") (smartchr '(" = " " == " "=")))
  (global-set-key (kbd ">") (smartchr '(">" " => " " => '`!!''" " => \"`!!'\""))))
