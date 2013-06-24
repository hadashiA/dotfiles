;;; helm-gtags-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "helm-gtags" "helm-gtags.el" (20936 20119 0
;;;;;;  0))
;;; Generated autoloads from helm-gtags.el

(autoload 'helm-gtags-select "helm-gtags" "\


\(fn)" t nil)

(autoload 'helm-gtags-find-tag "helm-gtags" "\
Jump to definition

\(fn)" t nil)

(autoload 'helm-gtags-find-rtag "helm-gtags" "\
Jump to referenced point

\(fn)" t nil)

(autoload 'helm-gtags-find-symbol "helm-gtags" "\
Jump to the symbol location

\(fn)" t nil)

(autoload 'helm-gtags-find-files "helm-gtags" "\
Find file with gnu global

\(fn)" t nil)

(autoload 'helm-gtags-pop-stack "helm-gtags" "\
Jump to previous point on the stack

\(fn)" t nil)

(autoload 'helm-gtags-show-stack "helm-gtags" "\
Show context stack

\(fn)" t nil)

(autoload 'helm-gtags-clear-stack "helm-gtags" "\
Clear jumped point stack

\(fn)" t nil)

(autoload 'helm-gtags-clear-all-stacks "helm-gtags" "\
Clear all jumped point stacks

\(fn)" t nil)

(autoload 'helm-gtags-mode "helm-gtags" "\
Toggle Helm-Gtags mode on or off.
With a prefix argument ARG, enable Helm-Gtags mode if ARG is
positive, and disable it otherwise.  If called from Lisp, enable
the mode if ARG is omitted or nil, and toggle it if ARG is `toggle'.
\\{helm-gtags-mode-map}

\(fn &optional ARG)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; helm-gtags-autoloads.el ends here
