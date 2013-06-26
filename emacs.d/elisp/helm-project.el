;;; helm-project.el -- finding any resource of a project

;; Author: IMAKADO <ken.imakado@gmail.com>
;; blog: http://d.hatena.ne.jp/IMAKADO (japanese)

;; Author: Shigenobu Nishikawa

;; Contributors:
;;     Shinya Yamaoka

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.


;;; Commentary:
;; helm-project.el is pure emacs lisp version of helm-find-project-resources.el.
;; many ideas from
;; http://trac.codecheck.in/share/browser/lang/elisp/helm-find-project-resources/trunk/helm-find-project-resources.el
;; and
;; http://blog.jrock.us/articles/eproject.POD

;;; Installation:

;; drop this file into a directory in your `load-path',
;; and put these lines into your .emacs file.

;; (require 'helm-project)
;; (global-set-key (kbd "C-c C-f") 'helm-project)

;; type C-c C-f to invoke helm with project files.
;; project root directory is automatically detected by helm-project.el

;; clear cache, If `helm-project' function is called with prefix arg (C-u M-x helm-project)


;;; Configuration:
;; you can add new project rule by `hp:add-project' function
;; keywords :look-for, :include-regexp and :exclude-regexp can be regexp or list of regexp
;; below are few samples

;; (hp:add-project
;;  :name 'perl
;;  :look-for '("Makefile.PL" "Build.PL") ; or
;;  :include-regexp '("\\.pm$" "\\.t$" "\\.pl$" "\\.PL$") ;or
;;  )

;; (hp:add-project
;;  :name 'perl
;;  :look-for '("Makefile.PL" "Build.PL")
;;  :include-regexp '("\\.pm$" "\\.t$" "\\.pl$" "\\.PL$")
;;  :exclude-regexp "/tmp" ; can be regexp or list of regexp
;;  )

(require 'helm)

(defvar hp:has-deferred-p nil
  "this variable becomes t when deferred.el is installed.")

(when (locate-library "deferred")
  (require 'deferred)
  (setq hp:has-deferred-p t))

(defvar hp:my-projects nil)
(defvar hp:history nil)

(defvar hp:default-directory-filter-regexps nil)

(defvar hp:default-filter-regexps
  '("\\.pm$" "\\.t$" "\\.pl$" "\\.PL$"))

;; almost copied from `helm-find-resource--project-root-files'.
(defvar hp:default-project-root-files
    '("build.xml" "prj.el" ".project" "pom.xml"
      "Makefile" "configure" "Rakefile" "Info.plist"
      "NAnt.build" "xpi" "Makefile.SH" ".git"

      "CVS"
      ))

;; Internal variables
(defvar hp:projects nil)
(defvar hp:root-directory "")
(defvar hp:--cache nil)

(defvar hp:global-look-for nil
  "this variable must be let bindded!!")
(defvar hp:global-include-regexp nil
  "this variable must be let bindded!!")
(defvar hp:global-exclude-regexp nil
  "this variable must be let bindded!!")
(defvar hp:global-grep-extensions nil
  "this variable must be let bindded!!")

(defvar hp:project-files-filters  (list 'identity)
  "list of function filter project-files.
each function is called with one arg(list of project-file)")

(defun hp:mk-list (a)
  (if (listp a) a (list a)))

(defun hp:apply-filters (filter-fns files)
  (let ((ret nil))
  (loop for filter-fn in hp:project-files-filters
        do (setq ret (funcall filter-fn files))
        finally return ret)))

(defun* hp:add-project (&key name look-for (include-regexp ".*") (exclude-regexp nil) (exclude-directory-regexp nil) (grep-extensions nil))
  (assert (not (null look-for)))
  (assert (and (not (null name))
               (symbolp name)))
  (assert (or (null grep-extensions)
              (listp grep-extensions)))
  (setq hp:projects (assq-delete-all name hp:projects))
  (add-to-list 'hp:projects
               `(,name . ((,:look-for . ,(hp:mk-list look-for))
                          (,:include-regexp . ,(hp:mk-list include-regexp))
                          (,:exclude-regexp . ,(hp:mk-list exclude-regexp))
                          (,:grep-extensions . ,grep-extensions)))))

;; (hp:get-project-data 'perl :look-for)


(defun hp:get-project-data (name type)
  (let ((sym (intern (concat "hp:global-"
                             (replace-regexp-in-string "^:" "" (symbol-name type))))))
    (cond
     ((when (and (boundp sym)
                  (not (null sym))))
      sym)
     (t
       (let ((alist (assoc-default name hp:projects)))
         (when alist
           (assoc-default type alist)))))))

(defun hp:get-project-keys ()
  (let* ((keys (loop for alist in hp:projects
                     collect (first alist)))
         (keys (delete 'default keys)))
    (add-to-list 'keys 'default t)))

(defun hp:root-directory-p (root-files-or-fn files)
  (cond
   ((functionp (car-safe root-files-or-fn))
    (ignore-errors
      (funcall (car root-files-or-fn) files)))
   (t
    (some
     (lambda (file)
       (find file
             files
             :test 'string=))
     root-files-or-fn))))

(defun hp:current-directory ()
  (file-name-directory
   (expand-file-name
    (or (buffer-file-name)
        default-directory))))

(defun* hp:root-detector (current-dir &optional (project-key :default))
  (let* ((current-dir (expand-file-name current-dir))
         (files-or-fn (hp:get-project-data project-key :look-for)))
    (hp:root-directory-p files-or-fn (directory-files current-dir))))


(defvar hp:get-root-directory-limit 10)
(defun hp:get-root-directory-aux (key)
  (let ((cur-dir (hp:current-directory)))
    (ignore-errors
      (loop with count = 0
            until (hp:root-detector cur-dir key)
            if (= count hp:get-root-directory-limit)
            do (return nil)
            else
            do (progn (incf count)
                      (setq cur-dir (expand-file-name (concat cur-dir "../"))))
            finally return cur-dir))))

(defun hp:get-root-directory ()
  (let ((project-keys (hp:get-project-keys)))
    (loop for key in project-keys
          for ret = (values (hp:get-root-directory-aux key) key)
          until (car ret)
          finally return ret)))
;;; add-to-history
(defadvice hp:get-root-directory (after add-to-history activate)
  (ignore-errors
    (destructuring-bind (root-dir key) ad-return-value
      (when (and root-dir key (stringp root-dir))
        (add-to-list 'hp:history root-dir)))))

(defsubst hp:any-match (regexp-or-regexps file-name)
  (when regexp-or-regexps
    (let ((regexps (if (listp regexp-or-regexps) regexp-or-regexps (list regexp-or-regexps))))
      (some
       (lambda (re)
         (string-match re file-name))
       regexps))))

(defun* hp:directory-files-recursively (regexp &optional directory type (dir-filter-regexp nil))
  (let* ((directory (or directory default-directory))
         (predfunc (case type
                     (dir 'file-directory-p)
                     (file 'file-regular-p)
                     (otherwise 'identity)))
         (files (directory-files directory t "^[^.]" t))
         (files (mapcar 'hp:follow-symlink files))
         (files (remove-if (lambda (s) (string-match (rx bol (repeat 1 2 ".") eol) s)) files)))
    (loop for file in files
          when (and (funcall predfunc file)
                    (hp:any-match regexp (file-name-nondirectory file)))
          collect file into ret
          when (and (file-directory-p file)
                    (not (hp:any-match dir-filter-regexp file)))
          nconc (hp:directory-files-recursively regexp file type dir-filter-regexp) into ret
          finally return  ret)))

(defun hp:follow-symlink (file)
  (cond ((file-symlink-p file)
         (expand-file-name (file-symlink-p file)))
        (t (expand-file-name file))))

(defun hp:truncate-file-name (root-dir files)
  (let* ((root-dir (replace-regexp-in-string "/$" "" root-dir))
         (re (concat "^" root-dir "\\(.*\\)$")))
    (let* ((truncate (lambda (f)
                       (if (string-match re f)
                         (match-string-no-properties 1 f)
                         f))))
      (mapcar truncate files))))

(defun hp:get-project-files (&optional clear-cache)
  (let* ((values (hp:get-root-directory))
         (root-dir (first values))
         (key (second values)))
    (when (and root-dir key)
      ;; clear cache if command invoked with prefix(C-u).
      (when clear-cache
        (setq hp:--cache
              (delete-if (lambda (ls) (equal root-dir ls))
                         hp:--cache
                         :key 'car)))
      (hp:get-project-files-aux root-dir key))))

(defun hp:get-project-files-aux (root-dir key)
  (lexical-let ((root-dir root-dir)
                (key key))
    (setq hp:root-directory root-dir)
    (hp:cache-get-or-set
     root-dir
     (lambda ()
       (message "getting project files...")
       (let ((include-regexp (or hp:global-include-regexp (hp:get-project-data key :include-regexp)))
             (exclude-regexp (or hp:global-exclude-regexp (hp:get-project-data key :exclude-regexp))))
         (let* ((files (hp:directory-files-recursively include-regexp root-dir 'identity exclude-regexp))
                (files (hp:apply-filters hp:project-files-filters files))
                (files (hp:truncate-file-name root-dir files)))
           files))))))

(defvar hp:global-cache-key "")
(defun hp:cache-get-or-set (root-dir get-files-fn)
  (let ((cache-key (concat root-dir hp:global-cache-key)))
    (let ((cache (assoc-default cache-key hp:--cache)))
      (if cache
          cache                         ; cache hit!!
        (let ((files (funcall get-files-fn)))
          (when files
            (add-to-list 'hp:--cache
                         `(,cache-key . ,files))
            files))))))

(defun hp:expand-file (file)
  (let ((root-dir (replace-regexp-in-string "/$" "" hp:root-directory)))
    (concat root-dir file)))

(if (fboundp 'helm-run-after-quit)
    (defalias 'hp:helm-run-after-quit 'helm-run-after-quit)
  (defun hp:helm-run-after-quit (function &rest args)
    "Perform an action after quitting `helm'.
The action is to call FUNCTION with arguments ARGS."
    (setq helm-quit t)
    (apply 'run-with-idle-timer 0 nil function args)
    (helm-exit-minibuffer)))

(defun hp:project-files-init-msg ()
  (message "Buffer is not project file. buffer: %s" (hp:current-directory)))

(defun* hp:project-files-init (&optional cache-clear files)
  (let ((files (or files (hp:get-project-files cache-clear)))
        (cands-buf (helm-candidate-buffer 'local)))
    (cond
     (files
      (with-current-buffer cands-buf
        (insert (mapconcat 'identity files "\n"))))
     (t
      (hp:helm-run-after-quit
       'hp:project-files-init-msg)))))


;;;; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;;;; Project Grep
;;;; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

(defun helm-project-grep ()
  (interactive)
  (cond
   ((require 'helm-grep  nil t)
    (hp:do-project-grep))
   (t
    (message "`helm-grep' is not installed. this command requires `helm-grep'"))))

(defun hp:helm-c-project-grep-init ()
  "Build shell command and execute it in a `helm' context."
  (destructuring-bind (root-dir key) (hp:get-root-directory)
    (when (and root-dir key)
      (lexical-let* ((query (read-string "Grep query: " (or (thing-at-point 'symbol) "")))
                     (grep-command (hp:build-grep-command key))
                     (shell-command (format (hp:preprocess-grep-command grep-command)
                                            (shell-quote-argument query)))
                     (candidate-buffer (helm-candidate-buffer 'global)))
        (helm-attrset 'recenter t)
        (if hp:has-deferred-p
            (deferred:$
              (deferred:next
                (lambda () (message "now grepping...")))
              (deferred:process-shell-bufferc it shell-command)
              (deferred:nextc it
                (lambda (buffer)
                  (with-current-buffer buffer
                    (let ((content (buffer-string)))
                      (with-current-buffer candidate-buffer
                        (insert content))))))
              (deferred:nextc it
                (lambda () (message "finish grepping!"))))
          (hp:run-grep-command-synchronously candidate-buffer shell-command))))))

(defun hp:run-grep-command-synchronously (buffer command)
  "Run grep commmand synchronously."
  (with-current-buffer buffer
    (let ((grep-result (call-process-shell-command command nil t nil)))
      (cond ((= grep-result 1) (error "no match"))
            ((not (= grep-result 0)) (error "Failed grep"))))))

(defvar hp:helm-c-project-grep-source
  '((name . "helm project grep")
    (init . hp:helm-c-project-grep-init)
    (candidates-in-buffer)
    (type . file-line)
    (candidate-number-limit . 9999)))

(defun hp:do-project-grep ()
  "Execute grep command in the root directory of a project."
  (let ((buf (get-buffer-create "*helm project grep*")))
    (helm :sources '(hp:helm-c-project-grep-source)
          :buffer buf)))

(defun hp:build-grep-command (key)
  (let ((grep-extensions (hp:get-grep-extensions key))
        (ack-command (hp:get-ack-command))
        (xargs-command (hp:get-xargs-command))
        (egrep-command (hp:get-egrep-command)))
    (concat
     ack-command " -afG " grep-extensions
     " | "
     xargs-command
     " "
     egrep-command " -Hin "
     "%s")))

(defun hp:preprocess-grep-command (command)
  "Quote `$buffers' in grep command and return the whole command."
  (with-temp-buffer
    (insert command)
    (goto-char 1)
    (when (search-forward "$buffers" nil t)
      (delete-region (match-beginning 0) (match-end 0))
      (insert (mapconcat 'shell-quote-argument
                         (delq nil (mapcar 'buffer-file-name (buffer-list))) " ")))
    (buffer-string)))


;;  (hp:build-grep-command  'perl "sub")
;; hp:build-grep-command
; (hp:get-grep-extensions 'perl)

(defun hp:get-xargs-command ()
  (or (executable-find "xargs")
           (error "can't find 'xargs' command in PATH!!")))

(defun hp:get-egrep-command ()
  (or (executable-find "egrep")
           (error "can't find 'egrep' command in PATH!!")))

(defun hp:get-ack-command ()
  (or (executable-find "ack")
      (executable-find "ack-grep")
      (error "can't find 'ack' command in PATH!!"))) ; debian

;; "ack -afG '(m|t|tt2|tt|yaml|yml|p[lm]|js|html|xs)$' | xargs egrep -Hin %s"
(defun hp:get-grep-extensions (key)
  (let ((list-of-grep-extention
         (cond
          ((or hp:global-grep-extensions
               (hp:get-project-data key :grep-extensions)))
          (t
           (hp:get-project-data key :include-regexp)))))
    ;; build, '(m|t|tt2|tt|yaml|yml|p[lm]|js|html|xs)$'
    (concat
     "'("
     (mapconcat 'identity list-of-grep-extention "|")
     ")$'")))

;;;; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;;;; Commands
;;;; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

;; copied from anything-config.el
(defun hp:helm-c-open-dired (file)
  "Opens a dired buffer in FILE's directory.  If FILE is a
directory, open this directory."
  (if (file-directory-p file)
      (dired file)
    (dired (file-name-directory file))
    (dired-goto-file file)))


(defvar helm-c-source-project
  '((name . "Project Files")
    (init . (lambda ()
              (hp:project-files-init (if (boundp 'cache-clear) ; KLUDGE!!
                                         cache-clear
                                       current-prefix-arg))))
    (candidates-in-buffer)
    (action . (("Find file" .
                (lambda (c)
                  (find-file (hp:expand-file c))))
               ("Find file other window" .
                (lambda (c)
                  (find-file-other-window (hp:expand-file c))))
               ("Find file other frame" .
                (lambda (c)
                  (find-file-other-frame (hp:expand-file c))))
               ("Open dired in file's directory" .
                (lambda (c)
                  (hp:helm-c-open-dired (hp:expand-file c))))))
    ))

(defvar helm-c-source-my-projects
  `((name . "Projects")
    (candidates . (lambda () hp:my-projects))
    (action . (("helm project" .
                (lambda (c)
                  (flet ((buffer-file-name () nil))
                    (let ((default-directory c))
                      (call-interactively 'helm-project)))
                  ))))
    ))

(defvar helm-c-source-projects-history
  `((name . "Projects history")
    (candidates . (lambda () hp:history))
    (action . (("helm project" .
                (lambda (c)
                  (flet ((buffer-file-name () nil))
                    (let ((default-directory c))
                      (call-interactively 'helm-project)))
                  ))))
    ))

(defun helm-my-project ()
  (interactive)
  (helm '(helm-c-source-my-projects
              helm-c-source-projects-history)))

;; copied from anything-config.el
(defun hp:shorten-home-path (files)
  "Replaces /home/user with ~."
  (mapcar (lambda (file)
            (let ((home (replace-regexp-in-string "\\\\" "/" ; stupid Windows...
                                                  (getenv "HOME"))))
              (if (string-match home file)
                  (cons (replace-match "~" nil nil file) file)
                file)))
          files))

(defun helm-project (&optional cache-clear)
  (interactive "P")
  (helm 'helm-c-source-project
            nil "Project files: "))


;;;; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;;;; Default Project (Samples)
;;;; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

;; utils
(defun hp:all-files-exist (project-files files)
  (subsetp project-files
           files
           :test 'string=))

(hp:add-project
 :name 'default
 :look-for hp:default-project-root-files
 )

(hp:add-project
 :name 'ruby
 :look-for '("Rakefile" "Gemfile")
 :exclude-regexp '("/tmp" "/log" ) ; can be regexp or list of regexp
)

(hp:add-project
 :name 'perl
 :look-for '("Makefile.PL" "Build.PL")
 :include-regexp '("\\.pm$" "\\.t$" "\\.pl$" "\\.PL$")
)

;;; PHP symfony
(hp:add-project
 :name 'symfony
 :look-for 'hp:symfony-root-detector
 :grep-extensions '("\\.php"))

(defun hp:symfony-root-detector (files)
  (let ((symfony-files '("symfony" "apps" "config")))
    (every
     (lambda (file)
       (find file
             files
             :test 'string=))
     symfony-files)))

;;; PHP cake
(hp:add-project
 :name 'cake
 :look-for 'hp:cake-root-detector
 :grep-extensions '("\\.php"))
(defun hp:cake-root-detector (files)
  (hp:all-files-exist '("index.php" "controllers" "config") files))

(provide 'helm-project)

