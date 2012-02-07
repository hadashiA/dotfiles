(when (require 'smartchr nil)
  (global-set-key (kbd "=") (smartchr '(" = " " == " " != " "=")))

  (add-hook 'cc-mode-hook
            (lambda ()
              (define-key cc-mode-map
                (kbd "+") (smartchr '("+" " + " "++" " += ")))
              (define-key cc-mode-map
                (kbd ">") (smartchr '(">" "->" " >> ")))
              ))

  (add-hook 'c++-mode-hook
            (lambda ()
              (define-key c++-mode-map
                (kbd "+") (smartchr '("+" " + " "++" " += ")))
              (define-key c++-mode-map
                (kbd ">") (smartchr '(">" "->" " >> ")))
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

  (add-hook 'js2-mode-hook
            (lambda ()
              (define-key js2-mode-map
                (kbd "+") (smartchr '("+" " + " "++" " += ")))
              (define-key js2-mode-map
                (kbd "{") (smartchr '("{ `!!' }" "{`!!'}")))
              
              (define-key js2-mode-map
                (kbd "C-8") (smartchr '("(`!!');" "('`!!'');" "({ `!!' });" "(function(`!!') {  });")))
              ))

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

  (add-hook 'php-mode-hook
            (lambda ()
              (define-key php-mode-map (kbd "=")
                (define-key php-mode-map
                  (kbd "+") (smartchr '("+" " + " " += ")))
                (define-key php-mode-map
                  (kbd ">") (smartchr '(">" "->" " => " " => '`!!''" " => \"`!!'\"")))
              )))
  )
