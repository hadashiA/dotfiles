;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; 分割したウィンドウでも折り返し
;; C-x 3した時も折り返されるようになる
(setq truncate-partial-width-windows nil)

;; windmove
;; http://hovav.net/elisp/
(require 'windmove)
(setq windmove-wrap-around nil)
(global-set-key (kbd "S-C-h") 'windmove-left)
(global-set-key (kbd "S-C-j") 'windmove-down)
(global-set-key (kbd "S-C-k") 'windmove-up)
(global-set-key (kbd "S-C-l") 'windmove-right)

;; C-x p/C-x oでウィンドウ間を移動する。
;; http://www.fan.gr.jp/~ring/Meadow/meadow.html#previous-window
(define-key ctl-x-map "p"
    #'(lambda (arg) (interactive "p") (other-window (- arg))))

;; 画面を1行ずつスクロールする + 物理行単位での移動
;; http://www.bookshelf.jp/soft/meadow_31.html#SEC420
(load "ce-scroll")
(setq ce-smooth-scroll nil)
(setq scroll-preserve-screen-position nil)

;; C-tで次のウインドウへ移動。ウインドウが1つだけのときは分割して移動
;; http://d.hatena.ne.jp/rubikitch/20100210/emacs
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1))

(global-set-key "\C-t" 'other-window-or-split)

;; (require 'popwin)
;; (setq display-buffer-function 'popwin:display-buffer)
;; (setq anything-samewindow nil)
;; (push '("*anything*" :height 20) popwin:special-display-config)
;; (push '(dired-mode :position top) popwin:special-display-config)
