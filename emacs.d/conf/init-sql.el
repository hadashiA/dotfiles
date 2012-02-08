;;;
;;; sql-mode
;;; http://www.emacswiki.org/cgi-bin/wiki.pl?SqlMode
;;;
(autoload 'sql-mode "sql" "SQL Edit mode" t)
(autoload 'sql-oracle "sql" "SQL Edit mode" t)
(autoload 'sql-ms "sql" "SQL Edit mode" t)
(autoload 'master-mode "master" "Master mode minor mode." t)

;; SQL mode に入った時点で sql-indent / sql-complete を読み込む
(eval-after-load "sql"
  '(progn
     (load-library "sql-indent")
     (load-library "sql-complete")
     (load-library "sql-transform")
     ))

;; デフォルトのデータベースの設定
;; (setq sql-user "scott")
;; (setq sql-database "orcl")

;; SQL モードの雑多な設定
(add-hook 'sql-mode-hook
    (function (lambda ()
                (setq sql-indent-offset 4)
                (setq sql-indent-maybe-tab t)
                (local-set-key "\C-cu" 'sql-to-update) ; sql-transform 
                 ;; SQLi の自動ポップアップ
                   (setq sql-pop-to-buffer-after-send-region t)
                ;; master モードを有効にし、SQLi をスレーブバッファにする
                   (master-mode t)
                (master-set-slave sql-buffer)
                ))
    )
(add-hook 'sql-set-sqli-hook
          (function (lambda ()
                      (master-set-slave sql-buffer))))       
(add-hook 'sql-interactive-mode-hook
          (function (lambda ()
                      ;; 「;」をタイプしたら SQL 文を実行
                         (setq sql-electric-stuff 'semicolon) 
                      ;; comint 関係の設定
                         (setq comint-buffer-maximum-size 500)
                      (setq comint-input-autoexpand t)
                      (setq comint-output-filter-functions 
                            'comint-truncate-buffer)))
          )

(setq sql-mysql-options (list "-u procart" "-pkzm1228" "-h 192.168.39.91" "procart"))

;; SQL モードから SQLi へ送った SQL 文も SQLi ヒストリの対象とする
(defadvice sql-send-region (after sql-store-in-history)
  "The region sent to the SQLi process is also stored in the history."
  (let ((history (buffer-substring-no-properties start end)))
    (save-excursion
      (set-buffer sql-buffer)
      (message history)
      (if (and (funcall comint-input-filter history)
               (or (null comint-input-ignoredups)
                   (not (ring-p comint-input-ring))
                   (ring-empty-p comint-input-ring)
                   (not (string-equal (ring-ref comint-input-ring 0)
                                      history))))
          (ring-insert comint-input-ring history))
      (setq comint-save-input-ring-index comint-input-ring-index)
      (setq comint-input-ring-index nil))))
(ad-activate 'sql-send-region)
