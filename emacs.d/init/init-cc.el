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

;; (setq c-default-style "gnu")
;; (setq c-default-style "linux")
(setq c-default-style "java")
(add-hook 'c-mode-hook
            '(lambda ()
               (c-toggle-hungry-state t)
               (c-toggle-auto-state t)               
               (setq c-basic-offset 4 indent-tabs-mode nil)
               (define-key c-mode-map (kbd "C-c o") 'ff-find-other-file)
               (define-key c-mode-map (kbd "C-c ,") 'compile-and-go-go)
               (define-key c-mode-map (kbd "C-c C-a") #'align)
               ;; (c-set-offset 'arglist-intro '+)
               ;; (c-set-offset 'arglist-close '+)
               ))

(add-hook 'c++-mode-hook
          (lambda ()
            (c-toggle-hungry-state t)
            (c-toggle-auto-state t)               
            (setq c-basic-offset 4 indent-tabs-mode nil)
            (define-key c++-mode-map (kbd "C-c o") 'ff-find-other-file)
            (define-key c++-mode-map (kbd "C-c ,") 'compile-and-go-go)
            (define-key c++-mode-map (kbd "C-c C-a") #'align)
            (c-set-offset 'access-label '-)
            (c-set-offset 'innamespace 0)
            (c-set-offset 'template-args-cont 0)
            (c-set-offset 'topmost-intro-cont 0)
            ))

(add-hook 'objc-mode-hook
          (lambda ()
            (c-set-offset 'label '-)
            (c-toggle-auto-newline t)
            (define-key objc-mode-map (kbd "C-c o") 'ff-find-other-file)
            (define-key objc-mode-map (kbd "C-c ,") 'compile-and-go-go)
            (define-key objc-mode-map (kbd "C-c C-a") #'align)
            ;; (c-set-offset 'objc-method-call-cont '+)
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


;; c++

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(defun file-in-directory-list-p (file dirlist)
  "Returns true if the file specified is contained within one of
the directories in the list. The directories must also exist."
  (let ((dirs (mapcar 'expand-file-name dirlist))
        (filedir (expand-file-name (file-name-directory file))))
    (and
     (file-directory-p filedir)
     (member-if (lambda (x) ; Check directory prefix matches
                  (string-match (substring x 0 (min(length filedir) (length x))) filedir))
                dirs))))

(defun buffer-standard-include-p ()
  "Returns true if the current buffer is contained within one of
the directories in the INCLUDE environment variable."
  (and (getenv "INCLUDE")
       (file-in-directory-list-p buffer-file-name (split-string (getenv "INCLUDE") path-separator))))

(add-to-list 'magic-fallback-mode-alist '(buffer-standard-include-p . c++-mode))


;; shader
(add-to-list 'auto-mode-alist '("\\.vert$" . c-mode))
(add-to-list 'auto-mode-alist '("\\.frag$" . c-mode))

;; objc

(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@import" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@implementation" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@interface" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@protocol" . objc-mode))

;; (ffap-bindings)
;; ;; 探すパスは ffap-c-path で設定する
;; ;; (setq ffap-c-path
;; ;;     '("/usr/include" "/usr/local/include"))
;; ;; 新規ファイルの場合には確認する
;; (setq ffap-newfile-prompt t)
;; ;; ffap-kpathsea-expand-path で展開するパスの深さ
;; (setq ffap-kpathsea-depth 5)


;; ドキュメントの参照
;; (when (require 'xcode-document-viewer nil t)
;;       (setq xcdoc:document-path "/Developer/Platforms/iPhoneOS.platform/Developer/Documentation/DocSets/com.apple.adc.documentation.AppleiPhone4_0.iPhoneLibrary.docset")
;;       ;; (setq xcdoc:document-path "/Developer/Platforms/iPhoneOS.platform/Developer/Documentation/DocSets/com.apple.adc.documentation.AppleiPhone4_1.iPhoneLibrary.docset")
;;       (setq xcdoc:open-w3m-other-buffer t)
;;       ;; hook の設定
;;       (add-hook 'objc-mode-hook
;;                 (lambda ()
;;                   ;; C-c w で確認してからドキュメントの検索
;;                   (define-key objc-mode-map (kbd "C-c w") 'xcdoc:ask-search))))

;; (setq c-objc-method-arg-min-delta-to-bracket 1
;;       c-objc-method-arg-unfinished-offset 1
;;       c-objc-method-parameter-offset 1)

(setq c-hanging-semi&comma-criteria nil)
