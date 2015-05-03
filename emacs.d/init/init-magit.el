;; なんか重いし使いずらいから全部ターミナルからやってる
;; ma-git はとりあえず有効にしといてみる
;; vc-gitとかのバックエンドの処理を無効にする
(setq vc-handled-backends nil)

(add-to-list 'process-coding-system-alist '("git" . utf-8))
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map "V" 'magit-status)))
