;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; flymake
;; 自動的にシンタックスチェックをかける
(when (require 'flymake nil)
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)

  (set-face-background 'flymake-errline "red4")
  (set-face-foreground 'flymake-errline "black")
  (set-face-background 'flymake-warnline "yellow")
  (set-face-foreground 'flymake-warnline "black")

  ;; 存在するファイルかつ書き込み可能ファイル時のみ flymake-mode を有効にします
  (defun flymake-mode-on-if-file-exists ()
    (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
        (flymake-mode t))
    )

  ;; Invoke ruby with '-c' to get syntax checking
  (defun flymake-ruby-init ()
    (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-inplace))
           (local-file  (file-relative-name
                         temp-file
                         (file-name-directory buffer-file-name))))
      (list "ruby" (list "-c" local-file))))
  
  (push '(".+\\.rb$"    flymake-ruby-init) flymake-allowed-file-name-masks)
  (push '("Rakefile$"   flymake-ruby-init) flymake-allowed-file-name-masks)
  (push '(".+\\.rake$$" flymake-ruby-init) flymake-allowed-file-name-masks)
  (push '(".+\\.erb$$"  flymake-ruby-init) flymake-allowed-file-name-masks)
  (push '(".+\\.rjs$$"  flymake-ruby-init) flymake-allowed-file-name-masks)
  (push '(".+\\.rash$$" flymake-ruby-init) flymake-allowed-file-name-masks)
  (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)
  (add-hook 'ruby-mode-hook 'flymake-mode-on-if-file-exists)
  
  ;; (defun flymake-pylint-init ()
  ;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
  ;;                      'flymake-create-temp-inplace))
  ;;          (local-file (file-relative-name
  ;;                       temp-file
  ;;                       (file-name-directory buffer-file-name))))
  ;;     (list "~/.emacs.d/python/pyflymake.py" (list local-file))))
  ;; (add-to-list 'flymake-allowed-file-name-masks '("\\.py\\'" flymake-pylint-init))
  (defun flymake-pep8-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "pep8" (list local-file))))

  (push '("\\.py$" flymake-pep8-init) flymake-allowed-file-name-masks)
  (add-hook 'python-mode-hook 'flymake-mode-on-if-file-exists)

  (defun flymake-cc-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "gcc" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))

  (push '("\\.c$" flymake-cc-init) flymake-allowed-file-name-masks)
  (push '("\\.h$" flymake-cc-init) flymake-allowed-file-name-masks)
  (add-hook 'c-mode-common-hook 'flymake-cc-init)

  ;; (defvar xcode:gccver "4.2")
  ;; (defvar xcode:sdkver "4.2")
  ;; (defvar xcode:sdkpath "/Developer/Platforms/iPhoneSimulator.platform/Developer")
  ;; (defvar xcode:sdk (concat xcode:sdkpath "/SDKs/iPhoneSimulator" xcode:sdkver ".sdk"))
  ;; ;; (defvar flymake-objc-compiler (concat xcode:sdkpath "/usr/bin/gcc-" xcode:gccver))
  ;; (defvar flymake-objc-compiler (concat xcode:sdkpath "/usr/bin/gcc-" xcode:gccver))
  ;; (defvar flymake-objc-compile-default-options (list "-arch" "i386" "-Wall" "-Wextra" "-fsyntax-only" "-ObjC" "-std=c99" "-isysroot" xcode:sdk))
  ;; (defvar flymake-objc-compile-options '("-I."))
  ;; (defvar flymake-last-position nil)
  (defvar flymake-objc-compiler "gcc")
  (defvar flymake-objc-compile-default-options nil)
  (defvar flymake-objc-compile-options (list "-Wall" "-Wextra" "-fsyntax-only"))
  (defun flymake-objc-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list flymake-objc-compiler (append flymake-objc-compile-default-options flymake-objc-compile-options (list local-file)))))

  ;; 拡張子 m と h に対して flymake を有効にする設定 flymake-mode t の前に書く必要があります
  ;; (push '("\\.m$" flymake-objc-init) flymake-allowed-file-name-masks)
  ;; (push '("\\.h$" flymake-objc-init) flymake-allowed-file-name-masks)
  ;; (add-hook 'objc-mode-hook
  ;;        (lambda ()
  ;;          ;; 存在するファイルかつ書き込み可能ファイル時のみ flymake-mode を有効にします
  ;;          (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
  ;;              (flymake-mode t))))

  (defun flymake-c++-init ()
    (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-inplace))
           (local-file  (file-relative-name
                         temp-file
                         (file-name-directory buffer-file-name))))
      (list "g++" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))
  (push '("\\.cc$" flymake-c++-init) flymake-allowed-file-name-masks)
  (push '("\\.cpp$" flymake-c++-init) flymake-allowed-file-name-masks)
  (push '("\\.mm$" flymake-c++-init) flymake-allowed-file-name-masks)
  (push '("\\.hpp$" flymake-c++-init) flymake-allowed-file-name-masks)
  (add-hook 'c++-mode-hook 'flymake-mode-on-if-file-exists)

  (defun flymake-display-err-minibuffer ()
    "現在行の error や warinig minibuffer に表示する"
    (interactive)
    (let* ((line-no (flymake-current-line-no))
           (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
           (count (length line-err-info-list)))
      (while (> count 0)
        (when line-err-info-list
          (let* ((file (flymake-ler-file (nth (1- count) line-err-info-list)))
                 (full-file (flymake-ler-full-file (nth (1- count) line-err-info-list)))
                 (text (flymake-ler-text (nth (1- count) line-err-info-list)))
                 (line (flymake-ler-line (nth (1- count) line-err-info-list))))
            (message "[%s] %s" line text)))
        (setq count (1- count)))))


  (defadvice flymake-goto-next-error (after display-message activate compile)
    "次のエラーへ進む"
    (flymake-display-err-minibuffer))
  
  (defadvice flymake-goto-prev-error (after display-message activate compile)
    "前のエラーへ戻る"
    (flymake-display-err-minibuffer))

  (defadvice flymake-mode (before post-command-stuff activate compile)
    "エラー行にカーソルが当ったら自動的にエラーが minibuffer に表示されるように
post command hook に機能追加"
    (set (make-local-variable 'post-command-hook)
         (add-hook 'post-command-hook 'flymake-display-err-minibuffer)))

  (define-key global-map (kbd "C-c d") 'flymake-display-err-minibuffer)
  (define-key global-map (kbd "S-C-n") 'flymake-goto-next-error)
  (define-key global-map (kbd "S-C-p") 'flymake-goto-prev-error)
  )
