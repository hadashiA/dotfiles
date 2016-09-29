(setq google-translate-default-source-language "en")
(setq google-translate-default-target-language "ja")

(defun my/google-translate (&optional override-p)
  "リージョンがアクティブならkill-region, そうでないならバッファ全体をkill."
  (interactive)
  (if (region-active-p)
      (google-translate-at-point override-p)
    (google-translate-query-translate override-p)))

(define-key global-map (kbd "C-M-t") 'my/google-translate)
