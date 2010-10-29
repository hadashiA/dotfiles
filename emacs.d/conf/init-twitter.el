;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; (require 'twit)

(add-to-list 'load-path "~/.emacs.d/elisp/twittering-mode")
(require 'twittering-mode)
(setq twittering-auth-method 'xauth)
(setq twittering-status-format "%i %p%s / %S:\n%FOLD{%T}\n%r %R [%@]")
(setq twittering-timer-interval 75)
(setq twittering-convert-fix-size 48)
;; (setq twittering-update-status-function 'twittering-update-status-from-pop-up-buffer)
(setq twittering-update-status-function 'twittering-update-status-from-minibuffer)
(setq twittering-icon-mode nil)
(setq twittering-scroll-mode nil)

(add-hook 'twittering-mode-hook
          (lambda ()
            (mapc (lambda (pair)
                    (let ((key (car pair))
                          (func (cdr pair)))
                      (define-key twittering-mode-map
                        (read-kbd-macro key) func)))
                  '(("F" . twittering-friends-timeline)
                    ("R" . twittering-replies-timeline)
                    ("U" . twittering-user-timeline)
                    ("W" . twittering-update-status-interactive)))))

;; ;; いくつかのTLをまとめて名前をつけることができる
;; (setq twittering-timeline-spec-alias
;;       `(("related-to" .
;; 	 ,(lambda (username)
;; 	    (if username
;; 		(format ":search/to:%s OR from:%s OR @%s/"
;; 			username username username)
;; 	      ":home")))
;; 	))
;; 起動時に以下のリストを読みこむ
;; (setq twittering-initial-timeline-spec-string
;;       '("$related-to(atauky)"
;; 	"atauky/who-i-met"
;; 	"atauky/conversationlist"
;; 	"atauky/jef-united"
;; 	":direct_messages"
;; 	":home"))
;; (add-hook 'twittering-mode-hook
;;           (lambda ()
;;             (set-face-bold-p 'twittering-username-face t)
;;             (set-face-foreground 'twittering-username-face "DeepSkyBlue3")
;;             (set-face-foreground 'twittering-uri-face "gray60")
;; 	    (setq twittering-status-format "%i %p%s / %S:\n%FOLD{%T}\n%r %R [%@]")
;; 	    (setq twittering-retweet-format " RT @%s: %t")
;;             ;; "F"でお気に入り
;;             ;; "R"でリツイートできるようにする
;;             (define-key twittering-mode-map (kbd "F") 'twittering-favorite)
;;             (define-key twittering-mode-map (kbd "R") 'twittering-native-retweet)
;;             ;; "<"">"で先頭、最後尾にいけるように
;;             (define-key twittering-mode-map (kbd "<") (lambda () (interactive) (goto-char (point-min))))
;;             (define-key twittering-mode-map (kbd ">") (lambda () (interactive) (goto-char (point-max))))))
;; URL短縮サービスをj.mpに
;; YOUR_USER_IDとYOUR_API_KEYを自分のものに置き換えてください
;; from http://u.hoso.net/2010/03/twittering-mode-url-jmp-bitly.html
;; (add-to-list 'twittering-tinyurl-services-map
;; 	     '(jmp . "http://api.j.mp/shorten?version=2.0.1&login=YOUR_USER_ID&apiKey=YOUR_API_KEY&format=text&longUrl="))
;; (setq twittering-tinyurl-service 'jmp)

