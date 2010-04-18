;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; M - ;     コメントを挿入
;; M C - p   対応する開き括弧へジャンプ (関数の先頭や末尾また関数と関数の間で使うと、
;;           関数の開始部と終了部を順に上に飛んで行ける)
;; M C - n   対応する閉じ確固へジャンプ (・・・下に・・・・)
;; M - a     ステートメントの先頭へ移動
;; M - e     ステートメントの末尾へ移動
;; M - .     CTAGSで関数にジャンプ
;; M - +     CTAGSでジャンプしてた時に元の場所に戻る

;; BackSpace キーを「賢く」し，インデント幅は4桁，タブはスペースに展開
(setq c-default-style "gnu")
(add-hook 'c-mode-common-hook
            '(lambda ()
               (c-toggle-hungry-state t)
               (c-toggle-auto-state t)               
               (setq c-basic-offset 4 indent-tabs-mode nil)))





