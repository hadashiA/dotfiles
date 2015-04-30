(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rjs$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.erb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rhtml$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile.lock" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '(".\\?irbrc" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rash$" . ruby-mode))

(add-to-list 'auto-coding-alist '("\\.rb\\'" . utf-8-unix))

(setq ruby-indent-level 2
      ruby-indent-tabs-mode nil
      ;; ruby-deep-indent-paren-style nil
      ruby-deep-indent-paren-style nil
      ;; ruby-deep-indent-paren-style 'space
      )

(add-hook 'ruby-mode-hook
          (lambda ()
            ;; マジックコメント入れない
            (defun ruby-mode-set-encoding () ())
            (define-key ruby-mode-map "\C-m" 'reindent-then-newline-and-indent)
            (define-key ruby-mode-map "\M-n" 'ruby-end-of-block)
            (define-key ruby-mode-map "\M-p" 'ruby-beginning-of-block)))

;; M-x alignの設定 for Ruby - (rubikitch loves (Emacs Ruby CUI))
;; http://d.hatena.ne.jp/rubikitch/20080227/1204051280
(add-hook 'align-load-hook
          (lambda ()
            (add-to-list 'align-rules-list
                         '(ruby-comma-delimiter
                           (regexp . ",\\(\\s-*\\)[^# \t\n]")
                           (repeat . t)
                           (modes  . '(ruby-mode))))
            (add-to-list 'align-rules-list
                         '(ruby-hash-literal
                           (regexp . "\\(\\s-*\\)=>\\s-*[^# \t\n]")
                           (repeat . t)
                           (modes  . '(ruby-mode))))
            (add-to-list 'align-rules-list
                         '(ruby-assignment-literal
                           (regexp . "\\(\\s-*\\)=\\s-*[^# \t\n]")
                           (repeat . t)
                           (modes  . '(ruby-mode))))
            (add-to-list 'align-rules-list          ;TODO add to rcodetools.el
                         '(ruby-xmpfilter-mark
                           (regexp . "\\(\\s-*\\)# => [^#\t\n]")
                           (repeat . nil)
                           (modes  . '(ruby-mode))))))

