(require 'smartchr)
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

(add-hook 'objc-mode-hook
          (lambda ()
            (define-key objc-mode-map
              (kbd "+") (smartchr '("+" " + " "++" " += ")))
            (define-key objc-mode-map
              (kbd ">") (smartchr '(">" "->" " >> ")))
            (define-key objc-mode-map
              (kbd ".") (smartchr '("." "->")))
            ))

(add-hook 'csharp-mode-hook
          (lambda ()
            (define-key csharp-mode-map
              (kbd "+") (smartchr '("+" " + " "++" " += ")))
            (define-key csharp-mode-map
              (kbd ">") (smartchr '(">" "->" " >> ")))
            (define-key csharp-mode-map
              (kbd "C-8") (smartchr '("(`!!');" "(\"`!!'\");")))
            ))

(add-hook 'coffee-mode-hook
          (lambda ()
            (define-key coffee-mode-map
              (kbd "+") (smartchr '("+" " + " "++" " += ")))
            (define-key coffee-mode-map
              (kbd ".") (smartchr '("." " -> " " => ")))
            (define-key coffee-mode-map
              (kbd "C-8")
              (smartchr '("(`!!')" "(`!!') -> " "('`!!'')" )))
            (define-key coffee-mode-map
              (kbd "#") (smartchr '("#" "#{`!!'}")))
            ))

(add-hook 'js2-mode-hook
          (lambda ()
            (define-key js2-mode-map
              (kbd "=") (smartchr '(" = " " == " " === " " != " " !== " "=")))
            (define-key js2-mode-map
              (kbd "+") (smartchr '("+" " + " "++" " += ")))
            (define-key js2-mode-map
              (kbd "$") (smartchr '("$" "${`!!'}")))
            (define-key js2-mode-map
              (kbd ".") (smartchr '("." " () => { `!!' }")))
            (define-key js2-mode-map
              (kbd "C-8") (smartchr '("(`!!')" "('`!!'')" "({ `!!' })" "((`!!') => {  })" "(function(`!!') {  })")))
            ))


(add-hook 'ruby-mode-hook
          (lambda ()
            (define-key ruby-mode-map
              (kbd "+") (smartchr '("+" " + " " += ")))
            (define-key ruby-mode-map
              (kbd ">") (smartchr '(">" " => " " => '`!!''" " => \"`!!'\"")))
            ;; (define-key ruby-mode-map
            ;;   (kbd "|") (smartchr '("|" " || " " ||= ")))
            (define-key ruby-mode-map
              (kbd "#") (smartchr '("#" "#{`!!'}")))
            ))

(add-hook 'puppet-mode-hook
          (lambda ()
            (define-key puppet-mode-map
              (kbd ">") (smartchr '(">" " => ")))
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
(add-hook 'go-mode-hook
          (lambda ()
            (define-key go-mode-map
              (kbd "=") (smartchr '(" = " " := " " == " " != ")))
            (define-key go-mode-map (kbd "+")
              (smartchr '("+" " + " " += ")))
            ))

