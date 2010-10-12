(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@import" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@implementation" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@interface" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@protocol" . objc-mode))

;; (ffap-bindings)
;; ;; 探すパスは ffap-c-path で設定する
;; ;; (setq ffap-c-path
;; ;;     '("/usr/include" "/usr/local/include"))
;; ;; 新規ファイルの場合には確認する
;; (setq ffap-newfile-prompt t)
;; ;; ffap-kpathsea-expand-path で展開するパスの深さ
;; (setq ffap-kpathsea-depth 5)


;; ドキュメントの参照
(when (require 'xcode-document-viewer) nil t
      (setq xcdoc:document-path "/Developer/Platforms/iPhoneOS.platform/Developer/Documentation/DocSets/com.apple.adc.documentation.AppleiPhone4_0.iPhoneLibrary.docset")
      ;; (setq xcdoc:document-path "/Developer/Platforms/iPhoneOS.platform/Developer/Documentation/DocSets/com.apple.adc.documentation.AppleiPhone4_1.iPhoneLibrary.docset")
      (setq xcdoc:open-w3m-other-buffer t)
      ;; hook の設定
      (add-hook 'objc-mode-hook
                (lambda ()
                  ;; C-c w で確認してからドキュメントの検索
                  (define-key objc-mode-map (kbd "C-c w") 'xcdoc:ask-search))))
