;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; C-hをBackSpaceに
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\C-x?" 'help-command)

;; C-x C-iでリージョンをインデント
(global-set-key "\C-x\C-i" 'indent-region)

;; C-x ?でヘルプ
(global-set-key "\C-x?" 'help)

;; C-x uで全置引数
(global-set-key "\C-xu" 'universal-argument)

;; C-c C-iでインフォを引く
(global-set-key "\C-c\C-i" 'info-lookup-symbol)

;; [2008-03-13]
;; Teaminal.app上ではダメ。

;; M-< M-> の代わりに C-< C-> を使う
(global-set-key (kbd "C-<") 'beginning-of-buffer)
(global-set-key (kbd "C->") 'end-of-buffer)

;; Terminal.appでC-/が効かないので、M-zで代用
(when run-linux (global-set-key "\M-z" 'undo))

;; キーボードレイアウトをカスタマイズして、[をCtrl、 ]をMetaにしてるの
;; M-} と M-{ を再設定
(global-set-key "\M-9" 'forward-paragraph)
(global-set-key "\M-8" 'backward-paragraph)

;; shellっぽいところで、C-n/pでヒストリ
;;(define-key comint-mode-map "\C-p" 'comint-previous-input)
;;(define-key comint-mode-map  "\C-n" 'comint-next-input)

 	
;; M-y で行のコピー
(defun duplicate-line (&optional numlines)
  "One line is duplicated wherever there is a cursor."
  (interactive "p")
  (let* ((col (current-column))
         (bol (progn (beginning-of-line) (point)))
         (eol (progn (end-of-line) (point)))
         (line (buffer-substring bol eol)))
    (while (> numlines 0)
      (insert "\n" line)
      (setq numlines (- numlines 1)))
    (move-to-column col)))

(define-key esc-map "y" 'duplicate-line)

