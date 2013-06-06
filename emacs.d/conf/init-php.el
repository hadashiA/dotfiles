;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-
;; php-mode
(load-library "php-mode")
(require 'php-mode)
(add-hook 'php-mode-hook
          '(lambda ()
             (setq c-basic-offset 4
                   tab-width 4
                   default-tab-width 4
                   ;; indent-tabs-mode (string-match "cmsp" (buffer-file-name))
                   indent-tabs-mode nil
                   c-default-style "linux"
                   )
             (c-set-offset 'case-label' 4)
             (c-set-offset 'arglist-intro' 4)
             (c-set-offset 'arglist-cont-nonempty' 4)
             (c-set-offset 'arglist-close' 0)

             ;; (set-default-coding-systems 'euc-jp)
             ;; (set-buffer-file-coding-system 'euc-jp)
             ;; (set-terminal-coding-system 'euc-jp)
             ;; コメントのスタイル (必要なければコメントアウトする)
             (setq comment-start "// "
                   comment-end   ""
                   comment-start-skip "// *")
             ))

;; http://namazu.org/~satoru/diary/?200203c&to=200203272#200203272
;; 編集中のファイルを開き直す
;; - yes/no の確認が不要;;   - revert-buffer は yes/no の確認がうるさい
;; - 「しまった! 」というときにアンドゥで元のバッファの状態に戻れる
;;   - find-alternate-file は開き直したら元のバッファの状態に戻れない
;;
;; (defun reopen-file ()
;;   (interactive)
;;   (let ((file-name (buffer-file-name))
;;         (old-supersession-threat
;;          (symbol-function 'ask-user-about-supersession-threat))
;;         (point (point)))
;;     (when file-name
;;       (fset 'ask-user-about-supersession-threat (lambda (fn)))
;;       (unwind-protect
;;           (progn
;;             (erase-buffer)
;;             (insert-file file-name)
;;             (set-visited-file-modtime)
;;             (goto-char point))
;;         (fset 'ask-user-about-supersession-threat
;;               old-supersession-threat)))))

;; (defun euc-jp-dos ()
;;   "C-x RET c euc-jp-dos"
;;   (interactive)
;;   (universal-coding-system-argument "euc-jp-dos")
;;   (reopen-file)
;;   )

;; (define-key ctl-x-map "\C-r"  'reopen-file)

(add-to-list 'auto-mode-alist '("\\.tpl$" . html-mode))
