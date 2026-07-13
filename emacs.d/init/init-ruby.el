;;; init-ruby.el --- Ruby + RBS (ruby-lsp via eglot) -*- lexical-binding: t; -*-

;; 補完 UI (in-buffer popup)。eglot の補完候補をその場に出すために必要。
(use-package corfu
  :straight t
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)            ;; 自動でポップアップ
  (corfu-auto-delay 0.1)
  (corfu-auto-prefix 2)
  (corfu-cycle t)
  :config
  ;; TAB でインデント、候補があれば補完
  (setq tab-always-indent 'complete))

;; .rbs ファイルのメジャーモード（シンタックス + インデント）
(use-package rbs-mode
  :straight t
  :mode "\\.rbs\\'")

;; LSP クライアントは内蔵の eglot。flymake と連携（consult-flymake が使える）。
(use-package eglot
  :straight (:type built-in)
  :hook ((ruby-mode    . eglot-ensure)
         (ruby-ts-mode . eglot-ensure))
  :config
  ;; ruby-mode / ruby-ts-mode は ruby-lsp で起動する。
  ;; ruby-lsp が sig/*.rbs を読み、.rb 内で RBS ベースの補完・ホバー・定義ジャンプを提供する。
  (add-to-list 'eglot-server-programs
               '((ruby-mode ruby-ts-mode) . ("ruby-lsp"))))

(provide 'init-ruby)
;;; init-ruby.el ends here
