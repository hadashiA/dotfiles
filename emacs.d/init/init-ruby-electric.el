(require 'ruby-electric)

(add-hook 'ruby-mode-hook
          (lambda ()
            (define-key ruby-mode-map "d" 'ruby-elect-end)))

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
