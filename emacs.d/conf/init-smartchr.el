(when (require 'smartchr nil)
  (global-set-key (kbd "=") (smartchr '(" = " " == " " != " "=")))

  (add-hook 'cc-mode-hook
            (lambda ()
              (define-key cc-mode-hook
                (kbd "+") (smartchr '("+" " + " "++" " += ")))
              (define-key cc-mode-hook
                (kbd ">") (smartchr '(">" " >> " "->")))
              ))

  ;; (add-hook 'c++-mode-hook
  ;;           (lambda ()
  ;;             (define-key c++-mode-hook
  ;;               (kbd "+") (smartchr '("+" " + " "++" " += ")))
  ;;             (define-key c++-mode-hook
  ;;               (kbd ">") (smartchr '(">" " >> " "->")))
  ;;             ))

  (add-hook 'ruby-mode-hook
            (lambda ()
              (define-key ruby-mode-map
                (kbd "+") (smartchr '("+" " + " " += ")))
              (define-key ruby-mode-map
                (kbd ">") (smartchr '(">" " => " " => '`!!''" " => \"`!!'\"")))
              ;; (define-key ruby-mode-map
              ;;   (kbd "|") (smartchr '("|" " || " " ||= ")))
              ))

  (add-hook 'python-mode-hook
            (lambda ()
              ;; (define-key python-mode-map (kbd "+") (smartchr '("+" " + " " += ")))
              (global-set-key (kbd "+") (smartchr '("+" " + " " += ")))
              ))

  (add-hook 'html-mode-hook
            (lambda ()
              (define-key html-mode-map (kbd "=")
                (smartchr '("=" "=\"`!!'\"" "=\"{% `!!' %}\"" "=\"{{ `!!' }}\"")))
              ))
  )
