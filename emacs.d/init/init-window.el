;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(setq scroll-step 1)

;; 分割したウィンドウでも折り返し
;; C-x 3した時も折り返されるようになる
(setq truncate-partial-width-windows nil)

(setq windmove-wrap-around nil)
(global-set-key (kbd "S-C-h") 'windmove-left)
(global-set-key (kbd "S-C-j") 'windmove-down)
(global-set-key (kbd "S-C-k") 'windmove-up)
(global-set-key (kbd "S-C-l") 'windmove-right)

;; C-x p/C-x oでウィンドウ間を移動する。
;; http://www.fan.gr.jp/~ring/Meadow/meadow.html#previous-window
(define-key ctl-x-map "p"
    #'(lambda (arg) (interactive "p") (other-window (- arg))))

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
