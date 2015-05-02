;; exec-path, PATHの追加
(let* ((pathenv (replace-regexp-in-string "[\r\n]+$" "" (shell-command-to-string "/usr/bin/env zsh -c 'printenv PATH'")))
       (pathlst (split-string pathenv ":")))
  (setq exec-path pathlst)
  (setq eshell-path-env pathenv)
  (setenv "PATH" pathenv))

;; shell-mode
;; パスワードを隠す
;; http://www.namazu.org/~tsuchiya/elisp/#shell-mode
(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)

(setq explicit-shell-file-name "/usr/loca/bin/zsh")


(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(add-to-list 'auto-mode-alist '("\\.zsh$" . shell-script-mode))

