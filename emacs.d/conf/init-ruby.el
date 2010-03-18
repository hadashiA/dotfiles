;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-
;; ruby-mode
;; http://pub.cozmixng.org/~the-rwiki/rw-cgi.rb?cmd=view;name=Emacs 
(add-to-load-path "~/.emacs.d/elisp/ruby-mode/")
(add-to-load-path "~/.emacs.d/elisp/rhtml-mode/")
(add-to-load-path "~/.emacs.d/elisp/rinari/")
(add-to-load-path "~/.emacs.d/elisp/ri-emacs/")

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
  (add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rash$" . ruby-mode))
 
  (define-key ruby-mode-map "\C-m" 'reindent-then-newline-and-indent)
  
  (define-key ruby-mode-map "\M-n" 'ruby-end-of-block)
  (define-key ruby-mode-map "\M-p" 'ruby-beginning-of-block)
 
  (and (require 'ruby-electric nil t)
       ;; (setq ruby-electric-expand-delimiters-list nil)    
       (add-hook 'ruby-mode-hook
                 '(lambda ()
                    (ruby-electric-mode 1))))
 
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
  (with-temp-buffer
    (call-process-shell-command
     "ruby -e 'require %[devel/which]'" nil t)
    (goto-char (point-min))
    (unless (re-search-forward "LoadError" nil t)
      (defun ffap-ruby-mode (name)
        (shell-command-to-string
         (format "
ruby -e '
require %%[rubygems]
require %%[devel/which]
require %%[%s]
print(which_library(%%[%s]))'"
                 name name))
 
        (defun find-rubylib (name)
          (interactive "sRuby library name: ")
          (find-file (ffap-ruby-mode name)))
 
        (and (require 'ffap nil t)
             (add-to-list 'ffap-alist '(ruby-mode . ffap-ruby-mode))))))
 
  ;; Software Design 2008-02 P153
  ;; ri
  (and
   (executable-find "fastri-server")
   (executable-find "fri")
   (setq ri-ruby-script (executable-find "ri-emacs"))
   (load "ri-ruby" t)
 
   (defun fastri-server-alive-p ()
     (with-temp-buffer
       (let
           ((progname "fastri-server")
            (wmic-tmp-file "TempWmicBatchFile.bat"))
         (cond
          ((and run-w32 run-meadow)
           (call-process "wmic" nil t t "process")
           (when (file-exists-p wmic-tmp-file)
             (delete-file wmic-tmp-file)))
          (t
           (call-process "ps" nil t t "uxww")))
         (goto-char (point-min))
         (not (not (re-search-forward progname nil t))))))
 
   (defun fastri-server-start ()
     (unless (fastri-server-alive-p)
       (message "starting fastri-server. please wait...")
       (let*
           ((progname "fastri-server")
            (buffname (format "*%s*" progname)))
 
         (start-process progname buffname progname)
         (while (not
                 (with-temp-buffer
                   (sit-for 0.5)
                   (call-process
                    "fri" nil t t "Kernel#lambda")
                   (goto-char (point-min))
                   (re-search-forward "lambda" nil t)))))))
 
   (defadvice ri-ruby-get-process (before ri/force-start-fastri-server
                                          activate)
     (fastri-server-start)))
 
  ;; Software Design 2008-02 P154
  ;; xmpfilter (rcodetools)
  (when (require 'rcodetools nil t)
    (and (require 'anything nil t)
         (require 'anything-rcodetools nil t)
         (setq rct-get-all-methods-command "PAGER=cat fri -l")
         (define-key anything-map "\C-z" 'anything-execute-persistent-action))
 
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
               '([(meta i)] rct-complete-symbol)
               '([(meta control i)] rct-complete-symbol)
               '([(control c) (control t)] ruby-toggle-buffer)
               '([(control c) (control d)] xmp)
               '([(control c) (control f)] rct-ri)))))))

(when (require 'rinari nil t)
  (global-set-key "\C-c;c" 'rinari-find-controller)
  (global-set-key "\C-c;e" 'rinari-find-environment)
  (global-set-key "\C-c;f" 'rinari-find-file-in-project)
  (global-set-key "\C-c;h" 'rinari-find-helper)
  (global-set-key "\C-c;v" 'rinari-find-view)
  (global-set-key "\C-c;i" 'rinari-find-migration)
  (global-set-key "\C-c;j" 'rinari-find-javascript)
  (global-set-key "\C-c;p" 'rinari-find-plugin)
  (global-set-key "\C-c;m" 'rinari-find-model)
  (global-set-key "\C-c;n" 'rinari-find-configuration)
  (global-set-key "\C-c;l" 'rinari-find-lib)
  (global-set-key "\C-c;s" 'rinari-find-stylesheet)
  
  (when (require 'rhtml-mode nil t)
    (add-hook 'rhtml-mode-hook
              (lambda () (rinari-launch)))))