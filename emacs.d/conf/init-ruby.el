;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-
;; ruby-mode
;; http://pub.cozmixng.org/~the-rwiki/rw-cgi.rb?cmd=view;name=Emacs 
(add-to-load-path "~/.emacs.d/elisp/ruby-mode/")
(when (require 'ruby-mode nil t)
  ;; magickコメントを入れない
  (defun ruby-mode-set-encoding () ())

  (setq ruby-indent-level 2
        ruby-indent-tabs-mode nil
        ruby-deep-indent-paren-style nil)
 
  (add-to-list 'auto-coding-alist '("\\.rb\\'" . utf-8-unix))
 
  ;; (mapc '(lambda (arg)
  ;;          (cons arg auto-mode-alist))
  ;;       (list '("\\.rb$"   . ruby-mode)
  ;;             '("\\.rash$" . ruby-mode)
  ;;             '("\\.rake$" . ruby-mode)
  ;;             '("\\.rjs$"  . ruby-mode)
  ;;             '("Rakefile" . ruby-mode)))

  (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rjs$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.erb$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rhtml$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rash$" . ruby-mode))
 
  (define-key ruby-mode-map "\C-m" 'reindent-then-newline-and-indent)
  
  (define-key ruby-mode-map "\M-n" 'ruby-end-of-block)
  (define-key ruby-mode-map "\M-p" 'ruby-beginning-of-block)

  ;; [2010-03-28]
  ;; yasnippetとか、regionをクォートするやつとかと競合するのでコメント
  ;; アウト
  ;; (and (require 'ruby-electric nil t)
  ;;      ;; (setq ruby-electric-expand-delimiters-list nil)    
  ;;      (add-hook 'ruby-mode-hook
  ;;                '(lambda ()
  ;;                   (ruby-electric-mode 1))))
 
  (and (require 'inf-ruby nil t)
       (setq interpreter-mode-alist
             (cons '("ruby" . ruby-mode) interpreter-mode-alist))
       (let
           ((ruby (executable-find "ruby"))
            (irb (locate-library "irb" nil exec-path))
            (args (list "--inf-ruby-mode" "-Ku")))
 
         (and irb
              (setq ruby-program-name
                    (mapconcat #'identity
                               `(,ruby ,irb ,@args) " "))
 
              (add-hook 'ruby-mode-hook
                        '(lambda ()
                           (inf-ruby-keys))))))

  (when (require 'ruby-block nil t)
    (setq ruby-block-highlight-toggle t)
    (ruby-block-mode t))
  
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

  (require 'rspec-mode nil t)

  ;; Software Design 2008-02 P152
  ;; devel/which and ffap
  ;; http://raa.ruby-lang.org/project/devel-which/
  (defun ffap-ruby-mode (name)
    (shell-command-to-string
     (format "
ruby -e '
require %%[rubygems]
require %%[devel/which]
require %%[%s]
print(which_library(%%[%s]))'"
             name name)))
    
  (defun find-rubylib (name)
    (interactive "sRuby library name: ")
    (find-file (ffap-ruby-mode name)))
  
  (require 'ffap)
  (add-to-list 'ffap-alist '(ruby-mode . ffap-ruby-mode))
 
  ;; ;; Ruby リファレンスマニュアルを Emacs で参照・ anything.el との連携（改訂版） - (rubikitch loves (Emacs Ruby CUI))
  ;; ;; http://d.hatena.ne.jp/rubikitch/20080102/rubyrefm
  ;; (defun refe2x (kw)
  ;;   (interactive "sReFe2x: ")
  ;;   (let ((coding-system-for-read 'euc-japan))
  ;;     (with-current-buffer (get-buffer-create (concat "*refe2x:" kw "*"))
  ;;       (when (zerop (buffer-size))
  ;;         (call-process "refe2x" nil t t kw)
  ;;         (diff-mode))
  ;;       (setq minibuffer-scroll-window (get-buffer-window (current-buffer) t))
  ;;       (goto-char (point-min))
  ;;       (display-buffer (current-buffer)))))

  ;; (defun anything-c-source-static-escript (symbol desc filename &rest other-attrib)
  ;;   `((name . ,desc)
  ;;     (candidates . ,symbol)
  ;;     ,@other-attrib
  ;;     (init
  ;;      . (lambda ()
  ;;          (unless (and (boundp ',symbol) ,symbol)
  ;;            (with-current-buffer (find-file-noselect ,filename)
  ;;              (setq ,symbol (split-string (buffer-string) "\n" t))))))
  ;;     (action
  ;;      ("Eval it"
  ;;       . (lambda (cand)
  ;;           (with-temp-buffer
  ;;             (insert cand)
  ;;             (cd ,(file-name-directory filename))
  ;;             (backward-sexp 1)
  ;;             (eval (read (current-buffer)))))))))
  ;; (setq anything-c-source-refe2x
  ;;       (anything-c-source-static-escript
  ;;        'anything-c-refe2x-candidates "ReFe2x"
  ;;        "~/rurema/bitclust/refe2x.e"
  ;;        '(delayed)
  ;;        '(requires-pattern . 3)))
  ;; (add-to-list 'anything-sources 'anything-c-source-refe2x t)

  ;; Software Design 2008-02 P153
  ;; ri
  ;; (and
  ;;  (executable-find "fastri-server")
  ;;  (executable-find "fri")
  ;;  (setq ri-ruby-script (executable-find "ri-emacs"))
  ;;  (load "ri-ruby" t)
 
  ;;  (defun fastri-server-alive-p ()
  ;;    (with-temp-buffer
  ;;      (let
  ;;          ((progname "fastri-server")
  ;;           (wmic-tmp-file "TempWmicBatchFile.bat"))
  ;;        (cond
  ;;         ((and run-w32 run-meadow)
  ;;          (call-process "wmic" nil t t "process")
  ;;          (when (file-exists-p wmic-tmp-file)
  ;;            (delete-file wmic-tmp-file)))
  ;;         (t
  ;;          (call-process "ps" nil t t "uxww")))
  ;;        (goto-char (point-min))
  ;;        (not (not (re-search-forward progname nil t))))))
 
  ;;  (defun fastri-server-start ()
  ;;    (unless (fastri-server-alive-p)
  ;;      (message "starting fastri-server. please wait...")
  ;;      (let*
  ;;          ((progname "fastri-server")
  ;;           (buffname (format "*%s*" progname)))
 
  ;;        (start-process progname buffname progname)
  ;;        (while (not
  ;;                (with-temp-buffer
  ;;                  (sit-for 0.5)
  ;;                  (call-process
  ;;                   "fri" nil t t "Kernel#lambda")
  ;;                  (goto-char (point-min))
  ;;                  (re-search-forward "lambda" nil t)))))))
 
  ;;  (defadvice ri-ruby-get-process (before ri/force-start-fastri-server
  ;;                                         activate)
  ;;    (fastri-server-start)))

  ;; Rsense
  ;;   RSense - ユーザーマニュアル
  ;; http://cx4a.org/software/rsense/manual.ja.html#.E3.82.A4.E3.83.B3.E3.82.B9.E3.83.88.E3.83.BC.E3.83.AB
  (setq rsense-home (expand-file-name "~/opt/rsense"))
  (add-to-list 'load-path (concat rsense-home "/etc"))
  (when (require 'rsense nil t)
    (setq rsense-rurema-home (expand-file-name "~/src/rurema")))
 
  ;; Software Design 2008-02 P154
  ;; xmpfilter (rcodetools)
  (when (require 'rcodetools nil t)
    ;; (and (require 'anything nil t)
    ;;      (require 'anything-rcodetools nil t)
    ;;      (setq rct-get-all-methods-command "PAGER=cat fri -l")
    ;;      (define-key anything-map "\C-z" 'anything-execute-persistent-action))
 
    (setq rct-find-tag-if-available nil)
 
    (defun make-ruby-scratch-buffer ()
      (let*
          ((buffer-name-base "ruby scratch")
           (exist-buffer-count
            (length
             (remove nil
                     (mapcar
                      '(lambda (arg)
                         (string-match buffer-name-base
                                       (buffer-name arg)))
                      (buffer-list))))))
 
        (with-current-buffer (get-buffer-create
                              (format "*%s<%s>*"
                                      buffer-name-base
                                      exist-buffer-count))
          (ruby-mode)
          (current-buffer))))
 
    (defun ruby-scratch ()
      (interactive)
      (pop-to-buffer (make-ruby-scratch-buffer)))
 
    (add-hook
     'ruby-mode-hook
     '(lambda ()
        (mapc (lambda (pair)
                (apply #'define-key ruby-mode-map pair))
              (list
               ;; '([(meta i)] rct-complete-symbol)
               ;; '([(meta control i)] rct-complete-symbol)
               ;; '([(control c) (control t)] ruby-toggle-buffer)
               '([(control c) (control f)] rct-ri)
               '([(control c) (control d)] xmp)))))

  (add-to-load-path "~/.emacs.d/elisp/rinari/")
  (setq rinari-minor-mode-prefixes (list "\C-c"))
  (require 'rinari nil t)
  
  (add-to-load-path "~/.emacs.d/elisp/rhtml-mode/")
  (when (require 'rhtml-mode nil t)
    (add-hook 'rhtml-mode-hook
              (lambda () (rinari-launch))))))