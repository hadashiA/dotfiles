;; sense-region.el
(when (require 'sense-region)
  (sense-region-on)
  ;; backward-delete-char-untabify
  (defadvice backward-delete-char-untabify
    (around ys:backward-delete-region activate)
    (if (eq sense-region-status 'rectangle)
        (delete-rectangle (region-beginning) (region-end))
      (if (and transient-mark-mode mark-active)
          (delete-region (region-beginning) (region-end))
        ad-do-it)))
  (global-set-key "\C-h" 'backward-delete-char-untabify))

;; リージョンを引用符で囲む
(defun wrap-region (left right beg end)
  "Wrap the region in arbitrary text, LEFT goes to the left and RIGHT goes to the right."
  (interactive)
  (save-excursion
    (goto-char beg)
    (insert left)
    (goto-char (+ end (length left)))
    (insert right)))

(defmacro wrap-region-with-function (left right)
  "Returns a function which, when called, will interactively `wrap-region-or-insert` using LEFT and RIGHT."
  `(lambda () (interactive)
     (wrap-region-or-insert ,left ,right)))

(defun wrap-region-with-tag-or-insert ()
  (interactive)
  (if (and mark-active transient-mark-mode)
      (call-interactively 'wrap-region-with-tag)
    (insert "<")))

(defun wrap-region-with-tag (tag beg end)
  "Wrap the region in the given HTML/XML tag using `wrap-region'. If any
attributes are specified then they are only included in the opening tag."
  (interactive "*sTag (including attributes): \nr")
  (let* ((elems    (split-string tag " "))
         (tag-name (car elems))
         (right    (concat "</" tag-name ">")))
    (if (= 1 (length elems))
        (wrap-region (concat "<" tag-name ">") right beg end)
      (wrap-region (concat "<" tag ">") right beg end))))

(defun wrap-region-or-insert (left right)
  "Wrap the region with `wrap-region' if an active region is marked, otherwise insert LEFT at point."
  (interactive)
  (if (and mark-active transient-mark-mode)
      (wrap-region left right (region-beginning) (region-end))
    (insert left)))

(global-set-key "'"  (wrap-region-with-function "'" "'"))
(global-set-key "\"" (wrap-region-with-function "\"" "\""))
(global-set-key "`"  (wrap-region-with-function "`" "`"))
(global-set-key "("  (wrap-region-with-function "(" ")"))
(global-set-key "["  (wrap-region-with-function "[" "]"))
(global-set-key "{"  (wrap-region-with-function "{" "}"))
(global-set-key "<"  'wrap-region-with-tag-or-insert)