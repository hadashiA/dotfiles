;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; M - ;     コメントを挿入
;; M C - p   対応する開き括弧へジャンプ (関数の先頭や末尾また関数と関数の間で使うと、
;;           関数の開始部と終了部を順に上に飛んで行ける)
;; M C - n   対応する閉じ確固へジャンプ (・・・下に・・・・)
;; M - a     ステートメントの先頭へ移動
;; M - e     ステートメントの末尾へ移動
;; M - .     CTAGSで関数にジャンプ
;; M - +     CTAGSでジャンプしてた時に元の場所に戻る

(defun compile-and-go-go ()
  "make and exec compiled object."
  (interactive)
  ;; (if (< 0 (length (shell-command-to-string "find . -name 'Makefile' -maxdepth 1")))
  (if nil
      (compile "make -k && $(find . -perm -u+x -type f -maxdepth 1 | head -1)")
    (let* ((path (buffer-file-name))
           (ext (file-name-extension path))
           (command (cond ((string= ext "cpp") "g++")
                          ((string= ext "m") "gcc -framework Foundation")
                          (t "gcc"))))
      (compile (concat command " " path " && ./a.out")))))

(add-to-list 'auto-mode-alist '("\\.vert$" . c-mode))
(add-to-list 'auto-mode-alist '("\\.frag$" . c-mode))

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


;; BackSpace キーを「賢く」し，インデント幅は4桁，タブはスペースに展開
;; (setq c-default-style "gnu")
;; (setq c-default-style "linux")
(setq c-default-style "java")
(add-hook 'c-mode-common-hook
            '(lambda ()
               (c-toggle-hungry-state t)
               (c-toggle-auto-state t)               
               (setq c-basic-offset 4 indent-tabs-mode nil)
               (define-key cc-mode-map (kbd "C-c o") 'ff-find-other-file)
               (define-key cc-mode-map (kbd "C-c ,") 'compile-and-go-go)
               ;; (c-set-offset 'arglist-intro '+)
               ;; (c-set-offset 'arglist-close '+)
               ))

(add-hook 'c++-mode-hook
          (lambda ()
            (c-set-offset 'access-label '-)
            (c-set-offset 'innamespace 0)
            (c-set-offset 'template-args-cont 0)
            (c-set-offset 'topmost-intro-cont 0)
            ))

(add-hook 'objc-mode-hook
          (lambda ()
            (c-set-offset 'label '-)
            (c-toggle-auto-newline t)
            ))

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
