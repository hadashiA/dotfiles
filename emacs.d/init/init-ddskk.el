(use-package ddskk
  :straight t
  :config
  (setq skk-large-jisyo "~/Library/Application Support/AquaSKK/SKK-JISYO.L"
        ;; skk-server-host "hadashikick.jp"
        ;; skk-server-portnum 1178
        )
  
  ;; 変換時，改行でも確定
  (setq skk-egg-like-newline t)
  
  ;; メッセージは日本語で
  (setq skk-japanese-message-and-error t)
  
  ;;"「"を入力したら"」"も自動で挿入
  (setq skk-auto-insert-paren t)
  
  ;;漢字登録のミスをチェックする
  (setq skk-check-okurigana-on-touroku t)
  
  ;; 変換候補をツールチップに表示
  ;; (setq skk-show-tooltip t)
  
  ;; 変換候補をインラインに表示
  (setq skk-show-inline t)
  
  ;; isearch時にSKKをオフ
  (setq skk-isearch-start-mode 'latin)
  
  ;; 10 分放置すると個人辞書が自動的に保存される設定
  (defvar skk-auto-save-jisyo-interval 600)
  (defun skk-auto-save-jisyo ()
    (skk-save-jisyo)
    (skk-bayesian-save-history)
    (skk-bayesian-corpus-save))
  (run-with-idle-timer skk-auto-save-jisyo-interval
                       skk-auto-save-jisyo-interval
                       'skk-auto-save-jisyo)
  
  (setq skk-use-jisx0201-input-method t)
  
  ;; 入力設定
  (setq skk-rom-kana-rule-list
    '(("z," nil "……")
      (":" nil ":")
      (";" nil ";")
      ("?" nil "？")
      ("!" nil "！")
      ("@" nil "@")
      ("_" nil "——")
      (" " nil "　")
      ("z\\" nil "￥")
      ("z\"" nil "“”")
      ("z'" nil "‘’")
      ("z[" nil "『")
      ("z]" nil "』")
      ("{" nil "【】")
      ("}" nil "〔〕")))
  )
