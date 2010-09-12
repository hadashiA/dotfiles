;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; M - ;     コメントを挿入
;; M C - p   対応する開き括弧へジャンプ (関数の先頭や末尾また関数と関数の間で使うと、
;;           関数の開始部と終了部を順に上に飛んで行ける)
;; M C - n   対応する閉じ確固へジャンプ (・・・下に・・・・)
;; M - a     ステートメントの先頭へ移動
;; M - e     ステートメントの末尾へ移動
;; M - .     CTAGSで関数にジャンプ
;; M - +     CTAGSでジャンプしてた時に元の場所に戻る

;; BackSpace キーを「賢く」し，インデント幅は4桁，タブはスペースに展開
(setq c-default-style "gnu")
(add-hook 'c-mode-common-hook
            '(lambda ()
               (c-toggle-hungry-state t)
               (c-toggle-auto-state t)               
               (setq c-basic-offset 4 indent-tabs-mode nil)))

(setq ff-other-file-alist
      '(("\\.mm?$" (".h"))
        ("\\.cc$"  (".hh" ".h"))
        ("\\.hh$"  (".cc" ".C"))

        ("\\.c$"   (".h"))
        ("\\.h$"   (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" ".m" ".mm"))

        ("\\.C$"   (".H"  ".hh" ".h"))
        ("\\.H$"   (".C"  ".CC"))

        ("\\.CC$"  (".HH" ".H"  ".hh" ".h"))
        ("\\.HH$"  (".CC"))

        ("\\.cxx$" (".hh" ".h"))
        ("\\.cpp$" (".hpp" ".hh" ".h"))
        
        ("\\.hpp$" (".cpp" ".c"))))


(add-hook 'cc-mode-hook
          (lambda ()
            (define-key c-mode-base-map (kbd "C-c o") 'ff-find-other-file)
            (gtags-mode 1)
            (gtags-make-complete-list)
            (add-to-list 'anything-sources 'anything-c-source-gtags-select t)
            ))
(define-key c-mode-map (kbd "C-+") 'anything-gtags-select)

(add-hook 'objc-mode-hook
          (lambda ()
            (define-key c-mode-base-map (kbd "C-c o") 'ff-find-other-file)
            (gtags-mode 1)
            (gtags-make-complete-list)
            (add-to-list 'anything-sources 'anything-c-source-gtags-select t)
            ))
(define-key objc-mode-map (kbd "C-+") 'anything-gtags-select)

(add-hook 'align-load-hook
            (lambda ()
              (add-to-list 'align-rules-list
                           '(c-assignment-literal
                             (regexp . "\\(\\s-*\\)=\\s-*[^# \t\n]")
                             (repeat . t)
                             (modes  . '(cc-mode))))
              (add-to-list 'align-rules-list
                           '(objc-assignment-literal
                             (regexp . "\\(\\s-*\\)=\\s-*[^# \t\n]")
                             (repeat . t)
                             (modes  . '(objc-mode))))))




