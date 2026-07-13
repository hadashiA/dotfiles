;; gumshoe: カーソル移動履歴の自動記録 (point-undo の後継)
;; https://github.com/Overdr0ne/gumshoe
(use-package gumshoe
  :straight t
  :init
  (global-gumshoe-mode +1)
  :config
  (setf gumshoe-slot-schema '(time buffer position line))

  ;; backtracking mode 中の移動キー。
  ;; 標準では paragraph 移動コマンドに割り当てたキー (自分の場合 M-8/M-9) で
  ;; 前後移動するが、C-p/C-n でも動くようにする。
  ;; これらは gumshoe--backtracking-p が認識するコマンドなので、押しても
  ;; backtracking が自動キャンセルされない。
  (define-key gumshoe-backtracking-mode-map (kbd "C-p") #'gumshoe-backtracking-back)
  (define-key gumshoe-backtracking-mode-map (kbd "C-n") #'gumshoe-backtracking-forward)

  ;; footprint に表示される番号を入力して直接ジャンプする。
  ;; 番号 N は内部インデックス (- 総数 N) に対応する。
  (defun my/gumshoe-backtrack-to-number (n)
    "backtracking 中に、footprint 番号 N の位置へジャンプする。"
    (interactive "NGumshoe #: ")
    (let ((bt (oref gumshoe-mode backtracker)))
      (with-slots (filtered) bt
        (let ((index (- (length filtered) n)))
          (if (and (>= index 0) (< index (length filtered)))
              (gumshoe--jump-to-index bt index (format "Gumshoe: entry #%i" n))
            (message "Gumshoe: #%i は範囲外です (1-%i)" n (length filtered)))))))

  (defun my/gumshoe-backtrack-digit ()
    "直前に押した数字キーの footprint 番号へジャンプする。"
    (interactive)
    (my/gumshoe-backtrack-to-number (- last-command-event ?0)))

  ;; 1-9 は即ジャンプ、g は 2 桁以上の番号を minibuffer から入力
  (dolist (d '("1" "2" "3" "4" "5" "6" "7" "8" "9"))
    (define-key gumshoe-backtracking-mode-map (kbd d) #'my/gumshoe-backtrack-digit))
  (define-key gumshoe-backtracking-mode-map (kbd "g") #'my/gumshoe-backtrack-to-number)

  ;; 番号ジャンプ後も backtracking を維持する (自動キャンセルさせない)
  (advice-add 'gumshoe--backtracking-p :around
              (lambda (orig-fn &rest args)
                (or (memq this-command '(my/gumshoe-backtrack-digit
                                         my/gumshoe-backtrack-to-number))
                    (apply orig-fn args))))
  :bind (("M-o" . gumshoe-backtrack)
         ("C-c g o" . gumshoe-buf-backtrack)))

;; consult 統合: 履歴をプレビュー付きで一覧選択
(use-package consult-gumshoe
  ;; ローカルの MELPA レシピにまだ無いので明示レシピで指定
  :straight (consult-gumshoe :type git :host github :repo "Overdr0ne/gumshoe"
                             :files ("extensions/consult-gumshoe/*.el"))
  :bind (("C-c g g" . consult-gumshoe-peruse-in-backlog)
         ("C-c g b" . consult-gumshoe-peruse-in-buffer)))
