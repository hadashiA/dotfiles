;; based upon

;; http://d.hatena.ne.jp/antipop/20080321/1206090430

(defun file-name-camelize ()
  (replace-regexp-in-string "[_-]" "" 
                            (capitalize (file-name-nondirectory
                                         (file-name-sans-extension
                                          (or (buffer-file-name)
                                              (buffer-name (current-buffer))))))))

(require 'yasnippet)

(add-hook 'js2-mode-hook
          #'(lambda ()
              (setq yas/mode-symbol 'js2-mode)))

(add-hook 'js3-mode-hook
          #'(lambda ()
              (setq yas/mode-symbol 'js3-mode)))

;; (and (require 'dropdown-list nil t)
;;      (setq yas/text-popup-function
;;            #'yas/dropdown-list-popup-for-template))
(require 'dropdown-list)
(setq yas-prompt-functions '(yas/dropdown-prompt))

  ;;; [2008-03-17]
  ;;; yasnippet展開中はflymakeを無効にする

(defvar flymake-is-active-flag nil)

(defadvice yas-expand-snippet
  (before inhibit-flymake-syntax-checking-while-expanding-snippet activate)
  (setq flymake-is-active-flag
        (or flymake-is-active-flag
            (assoc-default 'flymake-mode (buffer-local-variables))))
  (when flymake-is-active-flag
    (flymake-mode-off)))


(add-hook 'yas-after-exit-snippet-hook
          '(lambda ()
             (when flymake-is-active-flag
               (flymake-mode-on)
               (setq flymake-is-active-flag nil))))

;; http://d.hatena.ne.jp/rubikitch/20080420/1208641182
(defadvice skk-j-mode-on (after yasnippet activate)
  (yas-minor-mode-off))
(defadvice skk-latin-mode-on (after yasnippet activate)
  (yas-minor-mode-on))

(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(yas-global-mode 1)
