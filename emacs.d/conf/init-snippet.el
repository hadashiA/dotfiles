;; based upon
;; http://d.hatena.ne.jp/antipop/20080321/1206090430
 
;;(when nil ;(require 'yasnippet nil t) ; pending.
(when (require 'yasnippet nil)
  (setq yas/use-menu nil
        yas/trigger-key (kbd "SPC")    ; default => "TAB"
        yas/next-field-key (kbd "TAB")
        yas/buffer-local-condition
        '(or (not (or (string= "font-lock-comment-face"
                               (get-char-property (point) 'face))
                      (string= "font-lock-string-face"
                               (get-char-property (point) 'face))))
             '(require-snippet-condition . force-in-comment)))
 
  (and (require 'dropdown-list nil t)
       (setq yas/text-popup-function
             #'yas/dropdown-list-popup-for-template))
 
  ;;; [2008-03-17]
  ;;; yasnippet展開中はflymakeを無効にする
 
  (defvar flymake-is-active-flag nil)
 
  (defadvice yas/expand-snippet
    (before inhibit-flymake-syntax-checking-while-expanding-snippet activate)
    (setq flymake-is-active-flag
          (or flymake-is-active-flag
              (assoc-default 'flymake-mode (buffer-local-variables))))
    (when flymake-is-active-flag
      (flymake-mode-off)))
 
 
  (add-hook 'yas/after-exit-snippet-hook
            '(lambda ()
               (when flymake-is-active-flag
                 (flymake-mode-on)
                 (setq flymake-is-active-flag nil))))
 
  ;; http://d.hatena.ne.jp/rubikitch/20080420/1208641182
  (defadvice skk-j-mode-on (after yasnippet activate)
    (yas/minor-mode-off))
  (defadvice skk-latin-mode-on (after yasnippet activate)
    (yas/minor-mode-on))
 
  ;; yasnippet初期化
  (yas/initialize)
  (yas/load-directory (expand-file-name "~/.emacs.d/snippets")))
