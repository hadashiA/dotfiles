(use-package vertico
  ;; Special recipe to load extensions conveniently
  :straight (vertico :files (:defaults "extensions/*")
                     :includes (vertico-indexed
                                vertico-flat
                                vertico-grid
                                vertico-mouse
                                vertico-quick
                                vertico-buffer
                                vertico-repeat
                                vertico-reverse
                                vertico-directory
                                vertico-multiform
                                vertico-unobtrusive
                                ))  
  :init
  (vertico-mode)
  (define-key vertico-map "?" #'minibuffer-completion-help)
  (define-key vertico-map (kbd "<escape>") #'minibuffer-keyboard-quit)

  (global-set-key "\M-:" #'vertico-repeat)
  (add-hook 'minibuffer-setup-hook #'vertico-repeat-save)
  
  )

;; (:keymaps '(normal insert visual motion)
;;           "M-:" #'vertico-repeat)

(use-package orderless
  :straight t
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (partial-completion))))))

(use-package emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  (defun crm-indicator (args)
    (cons (concat "[CRM] " (car args)) (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Grow and shrink minibuffer
  ;;(setq resize-mini-windows t)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))

;; Enable richer annotations using the Marginalia package
(use-package marginalia
  :straight t
  ;; Either bind `marginalia-cycle` globally or only in the minibuffer
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  :custom
  (marginalia-max-relative-age 0)
  (marginalia-align 'right)  
  ;; The :init configuration is always executed (Not lazy!)
  :init

  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))
