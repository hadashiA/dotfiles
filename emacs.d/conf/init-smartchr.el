(when (require 'smartchr nil)
  (global-set-key (kbd "=") (smartchr '(" = " " == " " != " "=")))

  (add-hook 'c-mode-hook
            (lambda ()
              (define-key c-mode-map
                (kbd "+") (smartchr '("+" " + " "++" " += ")))
              (define-key c-mode-map
                (kbd ">") (smartchr '(">" "->" " >> ")))
              (define-key c-mode-map
                (kbd "C-8") (smartchr '("(`!!');" "(`!!')")))
              ))

  (add-hook 'c++-mode-hook
            (lambda ()
              (define-key c++-mode-map
                (kbd "+") (smartchr '("+" " + " "++" " += ")))
              (define-key c++-mode-map
                (kbd ">") (smartchr '(">" "->" " >> ")))
              (define-key c++-mode-map
                (kbd "C-8") (smartchr '("(`!!');" "(`!!')")))
              ))

  (add-hook 'objc-mode-hook
            (lambda ()
              (define-key objc-mode-map
                (kbd "+") (smartchr '("+" " + " "++" " += ")))
              (define-key objc-mode-map
                (kbd ">") (smartchr '(">" "->" " >> ")))
              ))

  (add-hook 'csharp-mode-hook
            (lambda ()
              (define-key csharp-mode-map
                (kbd "+") (smartchr '("+" " + " "++" " += ")))
              (define-key csharp-mode-map
                (kbd ">") (smartchr '(">" "->" " >> ")))
              ))

  (add-hook 'coffee-mode-hook
            (lambda ()
              (define-key coffee-mode-map
                (kbd "+") (smartchr '("+" " + " "++" " += ")))
              (define-key csharp-mode-map
                (kbd ">") (smartchr '(">" " -> ")))
              ))

  (dolist (hook-sym '(js2-mode-hook js3-mode-hook))
    (add-hook hook-sym
              (lambda ()
                (define-key js3-mode-map
                  (kbd "=") (smartchr '(" = " " == " " === " " != " " !== " "=")))
                (define-key js3-mode-map
                  (kbd "+") (smartchr '("+" " + " "++" " += ")))
                (define-key js3-mode-map
                  (kbd "{") (smartchr '("{ `!!' }" "{`!!'}")))
                
                (define-key js3-mode-map
                  (kbd "C-8") (smartchr '("(`!!');" "('`!!'');" "({ `!!' });" "(function(`!!') {  });")))
                ))    
    )nil
  

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

  (add-hook 'jade-mode-hook
            (lambda ()
              (define-key jade-mode-map (kbd "=")
                (smartchr '("=" "=\"`!!'\"" "=\"{% `!!' %}\"" "=\"{{ `!!' }}\"")))
              ))

  (add-hook 'php-mode-hook
            (lambda ()
              (define-key php-mode-map
                (kbd "=") (smartchr '(" = " " == " " === " " != " " !== " "=")))
              (define-key php-mode-map (kbd "+")
                (smartchr '("+" " + " " += ")))
              (define-key php-mode-map (kbd "+")
                (smartchr '("+" " + " " += ")))
              (define-key php-mode-map (kbd ">")
                (smartchr '(">" " => " " => '`!!''" " => \"`!!'\"")))
              (define-key php-mode-map (kbd ".")
                (smartchr '("." "->")))
              (define-key php-mode-map
                (kbd "[") (smartchr '("[`!!']" "['`!!']" "[\"`!!'\"]")))
              ))
  )
