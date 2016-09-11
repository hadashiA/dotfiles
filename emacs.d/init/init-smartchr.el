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

(add-hook 'csharp-mode-hook
          (lambda ()
            (define-key csharp-mode-map
              (kbd "+") (smartchr '("+" " + " "++" " += ")))
            (define-key csharp-mode-map
              (kbd ">") (smartchr '(">" " => `!!'" "() => `!!'" "(`!!') => ")))
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
              (kbd ">") (smartchr '(">" " => `!!'" "() => `!!'" "(`!!') => ")))
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


(add-hook 'rust-mode-hook
          (lambda ()
            (define-key rust-mode-map
              (kbd "+") (smartchr '("+" " + " " += ")))
            (define-key rust-mode-map
              (kbd ">") (smartchr '(">" " => " " => '`!!''" " => \"`!!'\"")))
            ))
