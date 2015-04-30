;; find-file時に、大文字・小文字を区別しない
;; http://d.hatena.ne.jp/khiker/20061220/1166643421
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

(require 'ido)
(ido-mode t)
(ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(custom-set-variables
 '(ido-max-directory-size 'const)
 '(ido-enter-matching-directory 'first))
;; (define-key ido-file-dir-completion-map (kbd "SPC") 'ido-exit-minibuffer)
(setq ido-use-filename-at-point 'guess)
(add-hook 'ido-setup-hook 
          (lambda () 
            (define-key ido-file-dir-completion-map (kbd "C-h") 'ido-delete-backward-updir)
            ))
(global-set-key (kbd "C-x C-f") 'ido-find-file)

;; 同名ファイルが複数ある時に、わかりやすくする
;; http://clouder.jp/yoshiki/mt/archives/000673.html
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(require 'minibuf-isearch)
