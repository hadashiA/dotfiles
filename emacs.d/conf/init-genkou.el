;; Emacs で 400 字詰め原稿用紙換算枚数を割り出すマイナーモード : miura-takeshi.com
;; http://www.miura-takeshi.com/2009/1004-152224.html
;; バインド出来るコマンドは以下の４つ。

;;     * genkou-count 「400字換算」
;;     * genkou-save 「保存して400字換算」
;;     * genkou-tex-export 「TeXにエクスポート」
;;     * genkou-count-preview 「プレビュー」
(autoload 'genkou-mode "genkou" "minor mode for Japanese manuscript." t)
(add-hook 'genkou-mode-hook
          '(lambda ()
             (define-key genkou-mode-map (kbd "C-c C-s") 'genkou-save)
             (define-key genkou-mode-map (kbd "C-c g") 'genkou-count)))
