(require 'helm-swoop)
(global-set-key (kbd "M-i") 'helm-swoop)
;; When doing isearch, hand the word over to helm-swoop
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
;; From helm-swoop to helm-multi-swoop-all
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
;; When doing evil-search, hand the word over to helm-swoop
;; (define-key evil-motion-state-map (kbd "M-i") 'helm-swoop-from-evil-search)

;; ;; Save buffer when helm-multi-swoop-edit complete
;; (setq helm-multi-swoop-edit-save t)

;; ;; If this value is t, split window inside the current window
;; (setq helm-swoop-split-with-multiple-windows nil)

;; ;; Split direcion. 'split-window-vertically or 'split-window-horizontally
;; (setq helm-swoop-split-direction 'split-window-vertically)
;; (setq helm-swoop-use-line-number-face t)
