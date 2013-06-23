;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-
;; ruby-mode
;; http://pub.cozmixng.org/~the-rwiki/rw-cgi.rb?cmd=view;name=Emacs 
(add-to-load-path "~/.emacs.d/elisp/ruby-mode/")
;; (require 'rvm)
;; (rvm-use "1.9.3" "ruby")
;; (rvm-use-default)

(require 'ruby-mode)
;; magickコメントを入れない
(defun ruby-mode-set-encoding () ())

(setq ruby-indent-level 2
      ruby-indent-tabs-mode nil
      ;; ruby-deep-indent-paren-style nil
      ;; ruby-deep-indent-paren-style t
      ruby-deep-indent-paren-style 'space
      )

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
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile.lock" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '(".\\?irbrc" . ruby-mode))
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

;; (and (require 'inf-ruby nil t)
;;      (setq interpreter-mode-alist
;;            (cons '("ruby" . ruby-mode) interpreter-mode-alist))
;;      (let
;;          ((ruby (executable-find "ruby"))
;;           (irb (locate-library "irb" nil exec-path))
;;           (args (list "--inf-ruby-mode" "-Ku")))
       
;;        (and irb
;;             (setq ruby-program-name
;;                   (mapconcat #'identity
;;                              `(,ruby ,irb ,@args) " "))
            
;;             (add-hook 'ruby-mode-hook
;;                       '(lambda ()
;;                          (inf-ruby-keys))))))

(when (require 'ruby-block)
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


;; Software Design 2008-02 P154
;; xmpfilter (rcodetools)
(when (require 'rcodetools)
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

  (add-to-load-path "~/.emacs.d/elisp/rhtml-mode/")
  (require 'rhtml-mode nil t))

(defvar ruby-elect-keyword
  '("def" "if" "class" "module" "unless" "case"
    "while" "do" "until" "for" "begin" "end"))

(defvar ruby-elect-regex (mapconcat (lambda (x) (format "\\<%s\\>" x)) ruby-elect-keyword "\\|"))

(defun ruby-elect-end ()
  (interactive)
  (insert "d")
  (when (and (char-equal (char-before (1- (point))) ?n)
             (char-equal (char-before (- (point) 2)) ?e))
    (ruby-indent-command)
    (let ((orig (point)) open)
      (forward-char -3)
      (when (looking-at "\\<end\\>")
        (setq open (ruby-elect-begin))
        (when open
          (goto-char open)
          (sit-for 0.3)))
      (goto-char orig))))

(defun ruby-elect-begin ()
  (let ((level 0) pos)
    (catch 'loop
      (while (re-search-backward ruby-elect-regex nil t)
        (setq pos (match-beginning 0))
        (cond
         ((string= (match-string 0) "end")
          (setq level (1+ level)))
         ((member (match-string 0) '("if" "unless" "while" "until"))
          (when (ruby-elect-if)
            (if (= level 0) (throw 'loop pos))
            (setq level (1- level))))
         (t
          (if (= level 0) (throw 'loop pos))
          (setq level (1- level))))
        (if (< level 0) (throw 'loop nil))))))

(defun ruby-elect-if ()
  (save-excursion
    (catch 'loop
      (while (/= (point) (point-min))
        (forward-char -1)
        (let ((c (char-after)))
          (cond
           ((or (char-equal c ?\n) (char-equal c ?\()) (throw 'loop t))
           ((or (char-equal c 32) (char-equal c ?\t)) ())
           (t (throw 'loop nil))))))))

(add-hook 'ruby-mode-hook
          (lambda ()
            (define-key ruby-mode-map "d" 'ruby-elect-end)))
