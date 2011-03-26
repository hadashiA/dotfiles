(setenv "PYTHONPATH"
        (concat (expand-file-name "~/.emacs.d/python") ":"
                (getenv "PYTHONPATH")))

(defun my-python-settings ()
    (setq py-indent-offset 2
          py-continuation-offset 2
          indent-tabs-mode nil)
    (message "my-python-settings"))

(autoload 'python-mode "python-mode" "Python editing mode." t)
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode) interpreter-mode-alist))
(add-hook 'python-mode-hook 'my-python-settings)

;; Pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(eval-after-load "pymacs"
  '(add-to-list 'pymacs-load-path "~/.emacs.d/python"))

;; python-mode, pycomplete 
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
                                   interpreter-mode-alist))
(add-hook 'python-mode-hook '(lambda ()
                               (require 'pycomplete)
                               ))

