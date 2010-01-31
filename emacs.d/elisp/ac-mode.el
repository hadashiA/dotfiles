;; ac-mode.el さまざまなかたちの補完, インデントをインテリジェントに行う.
;;
;;  AUTHOR: 小松弘幸  Hiroyuki Komatsu <komatsu@taiyaki.org>
;;
;; このコードは GPL に従って配布可能です. (This is GPLed software.)
;; 
;; ■インストール方法
;; 1) 適当なディレクトリにこのファイルをおく (~/elisp/ 内においたとする.)
;; 2) .emacs に次の 2 行を追加する.
;; (setq load-path (cons (expand-file-name "~/elisp") load-path))
;; (autoload 'ac-mode "ac-mode" "Minor mode for advanced completion." t nil)
;; 3) URL の補完をする場合は ~/urls.txt を作成する必要があります.
;;    strings ~/.netscape/history.dat | grep "^http://.*\(/\|\.html\?\)$" \
;;    | sort | uniq > ~/urls.txt 
;; 
;; ■使い方
;; M-x ac-mode と実行すると, ac-mode の状態がトグルします.
;; TAB キー (\C-i) を押すと文脈を (それなりに) 判断して補完, 
;; またはインデントします.
;;
;; ■現在実装されているもの
;; 1) インデント: region (範囲指定) がある場合か,
;;                以下の補完に当てはまらない場合, または行頭行末.
;; 2) URL: ~/urls.txt に並んでいるリストから当てはまるもの.
;;         おそらく http:// で始まるものです.
;; 3) ファイルパス: / や ~ で始まる場合.
;; 4) dabbrev (動的補完): ほとんどの単語上の場合.
;; 5) migemo-dabbrev (http://migemo.namazu.org/): 
;;         日本語として読める 4 文字以上の単語上の場合.
;;
;; ■TODO
;; パスと動的補完を統合する (基底文字列が違うので注意)
;; 静的補完にも対応 (?)
;; 構文にも対応させる
;; インテリジェンスな候補判定 (特に TAB との)
;; 曖昧検索
;; リージョンを指定しない indent-region
;; table.el の利用

;;;; ----------------------------------------------------------------------
;;;; 汎用関数 From MELL  (http://www.taiyaki.org/elisp/mell/)
;;;; ----------------------------------------------------------------------
;; Checking Emacs or XEmacs.
(if (not (boundp 'running-xemacs))
    (defconst running-xemacs nil))

;; Define transient-region-active-p
(if running-xemacs
    (defun transient-region-active-p ()
      (and (boundp 'transient-mark-mode)
	   transient-mark-mode (region-active-p)))
  (defun transient-region-active-p ()
    (and (boundp 'transient-mark-mode)
	 transient-mark-mode
	 (boundp mark-active)
	   mark-active)))

(defun set-minor-mode (name modeline &optional key-map)
  (make-variable-buffer-local name)
  (or (assq name minor-mode-alist)
      (setq minor-mode-alist (cons (list name modeline) minor-mode-alist)))
  (and key-map
       (setq minor-mode-map-alist 
	     (cons (cons name key-map) 
		   (delete-assoc minor-mode-map-alist name)))
       ))

(defun delete-assoc (alist key)
  (let (return-alist)
    (mapcar '(lambda (x)
	       (or (equal key (car x))
		   (setq return-alist (cons x return-alist))))
	    alist)
    (reverse return-alist)
    ))

(defun get-interval (time1 time2)
  (if (or (> (- (nth 0 time1) (nth 0 time2)) 0)
	  (> (- (nth 1 time1) (nth 1 time2)) 1000))
      1000000000 ;; 桁あふれへのいんちき対処
    (+ (* 1000000 (- (nth 1 time1) (nth 1 time2)))
       (- (nth 2 time1) (nth 2 time2))))
  )

(defun minor-mode-key-binding-list (key)
  (delq nil
	(mapcar 
	 '(lambda (x) (mell-lookup-key x key))
	 (current-minor-mode-maps))
  ))

(or (functionp 'sublist)
(defun sublist (list start &optional end)
  (if (< start 0)
      (setq start (+ start (length list))))
  (if (null end)
      (nthcdr start (copy-sequence list))
    (and end (< end 0) 
	 (setq end (+ end (length list))))
    (let (sublist tmp)
      (if (> start end)
	  (progn (setq tmp start)
		 (setq start end)
		 (setq end tmp)))
      (while (< start end)
	(setq end (1- end)
	      sublist (cons (nth end list) sublist)))
      sublist)))
)

(or (functionp 'subarray)
(defun subarray (array start &optional end)
  (apply 'vector (sublist (append array nil) start end)))
)

(or (functionp 'subseq)
(defun subseq (seq start &optional end) ;; For Emacs20
  (cond ((stringp seq) (substring seq start end))
	((listp seq)   (sublist seq start end))
	(t             (subarray seq start end))
	))
)

(defun mell-next-key-binding (&optional keymap command-keys)
  (let ((mode-maps (if keymap (member keymap (current-minor-mode-maps))
		     (current-minor-mode-maps)))
	(command-keys (or command-keys (this-command-keys))))
    (or (car (cdr (delq nil
			(mapcar '(lambda (x) (mell-lookup-key x command-keys))
				mode-maps))))
	(mell-local-key-binding command-keys)
	(mell-global-key-binding command-keys)
	)))

(defun mell-call-next-interactively (&optional keymap command-keys)
  (call-interactively (or (mell-next-key-binding keymap command-keys)
			  'self-insert-command)
		      ))

(defun mell-lookup-key (keymap keys)
  (let ((result (lookup-key keymap keys)))
    (if (numberp result)
	(lookup-key keymap (subseq keys 0 result))
      result)
    ))

(defun mell-local-key-binding (keys)
  (let ((result (local-key-binding keys)))
    (if (numberp result)
	(local-key-binding (subseq keys 0 result))
      result)
    ))

(defun mell-global-key-binding (keys)
  (let ((result (global-key-binding keys)))
    (if (numberp result)
	(global-key-binding (subseq keys 0 result))
      result)
    ))

;; ----------------------------------------------------------------------

(defvar ac-mode nil
  "*Non-nil means in an advanced-complete-mode.")
(make-variable-buffer-local 'ac-mode)

(defvar ac-mode-map nil "")
(defvar ac-mode-exception '(dired-mode)
  "ac-mode-without-exception excepts modes of this list.")

(or ac-mode-map
    (let ((map (make-sparse-keymap)))
      (define-key map "\C-i" 'ac-complete)
      (define-key map " " 'ac-enter)
      (setq ac-mode-map map)
      ))
(set-minor-mode 'ac-mode " AC" ac-mode-map)

;(global-set-key "\C-i" 'ac-complete)
;(global-set-key [muhenkan] 'ac-complete)
(defcustom ac-mode-dabbrev-char "-a-zA-Z0-9_$"
  "Characters for dabbrev-expansion. (Obsolete)")
(defcustom ac-mode-path-char "-a-zA-Z0-9\.#~_+/" "Characters for file path.")
(defcustom ac-mode-url-char "-a-zA-Z0-9.:#~_+/" "Characters for URL.")
(defcustom ac-mode-url-file "~/urls.txt" "File path for url completion")
(defcustom ac-mode-timeout-interval-time 200000
  "ac-mode はこの時間内で候補を探し出す")
(defcustom ac-mode-goto-end-of-word nil
  "nil でない場合, 補完後カーソルは常に単語末に移動する")
(defvar ac-mode-start-time nil)
;; strings ~/.netscape/history.dat | grep "^http://.*\(/\|\.html\?\)$" \
;;  | sort | uniq > ~/urls.txt 
(defvar ac-display-completions-p nil)

(defun ac-mode (&optional arg)
  "Toggle Advanced Complete mode.
With ARG, turn Advanced Complete mode on iff ARG is positive.
When Advanced Complete mode is enabled, [TAB] have abbrev, file and 
URL completing functions and indent function."
  (interactive "P")
  (setq ac-mode (if (null arg)
		    (not ac-mode)
		  (> (prefix-numeric-value arg) 0)))
  )

(defun ac-mode-on ()
  "Turn on Advanced Complete mode."
  (interactive)
  (ac-mode t))

(defun ac-mode-off ()
  "Turn off Advanced Complete mode."
  (interactive)
  (ac-mode -1))

(defun ac-mode-without-exception ()
  "Turn on AC mode without modes which are members of ac-mode-exception."
  (ac-mode (if (memq major-mode ac-mode-exception) -1 t)))

(defvar ac--completoins-path nil)
(defvar ac--completoins-abbrev nil)
(defvar ac--suggest-count 0)
(defvar ac--suggest-target "")
(defvar ac--pre-suggest-region '(nil . nil))

(defvar url-complete--buffer " *url compele*")
(get-buffer-create url-complete--buffer)

(defun ac-complete ()
  (interactive)
  (let ((another-command (ac-another-minor-mode-key-binding)))
    (if another-command
	(ac-call-another-command another-command)
      (or (eq last-command this-command)
	  (setq ac--suggest-count 0))
      (ac-complete-internal)
      )))

; ADVANCED COMPLETE
(defun ac-complete-internal ()
  (if (= ac--suggest-count 0) ; 場合によって上記以外でも 0 である可能性がある
;      (or (setq ac--completoins-skip
;		(> (skip-chars-forward "\\sw\\|\\s_") 0))
	  (setq 
	   ac--completoins-url    (url-complete)
	   ac--completoins-path   (path-complete)
	   ac--completoins-abbrev (if (bolp) nil (ac-dabbrev-completion))
;	   ac--completoins-migemo (if (bolp) nil (ac-migemo-completion))
;	   ac--completoins-abbrev (if (bolp) nil (ac-dabbrev-migemo-completion))
	   ac--completoins-migemo nil
	   ));)
  
  (cond 
   ((transient-region-active-p)
    (ac-indent (region-beginning) (region-end)))
   
   (;(or ac--completoins-skip
	(and (null (cdr ac--completoins-url)) 
	     (null (cdr ac--completoins-path)) 
	     (null (cdr ac--completoins-abbrev))
	     (null (cdr ac--completoins-migemo)));)
    (ac-indent))
	  
   ((= (length (cdr ac--completoins-path)) 1)
    (ac-suggest-nth ac--completoins-path ac--suggest-count))
	   
   ((= (length (cdr ac--completoins-abbrev)) 1)
    (ac-suggest-nth ac--completoins-abbrev ac--suggest-count))
	   
   ((= (length (cdr ac--completoins-url)) 1)
    (ac-suggest-nth ac--completoins-url ac--suggest-count))
	  
   ((= (length (cdr ac--completoins-migemo)) 1)
    (ac-suggest-nth ac--completoins-migemo ac--suggest-count))
	  
   ((cdr ac--completoins-url)
    (ac-suggest-nth ac--completoins-url ac--suggest-count))

   ((cdr ac--completoins-path)
    (ac-suggest-nth ac--completoins-path ac--suggest-count))

   ((cdr ac--completoins-abbrev)
    (ac-suggest-nth ac--completoins-abbrev ac--suggest-count))

   ((cdr ac--completoins-migemo)
    (ac-suggest-nth ac--completoins-migemo ac--suggest-count))
   ))

(defun ac-enter ()
  (interactive)
  (let ((another-command (ac-another-minor-mode-key-binding)))
    (if another-command
	(ac-call-another-command another-command)
      (if (and (not ac-mode-goto-end-of-word)
	       (eq last-command 'ac-complete)
	       (> ac--suggest-count 0)
	       (not (eq (point) (cdr ac--pre-suggest-region)))
	       )
	  (goto-char (cdr ac--pre-suggest-region))
	(mell-call-next-interactively ac-mode-map)
	))
    ))

(defun ac-suggest-nth (suggest nth)
  (and (= ac--suggest-count 0)
       (setq ac--pre-suggest-region 
	     (cons (nth 1 (car suggest)) (nth 3 (car suggest)))))
  (let ((begin (nth 2 (car suggest)))
	(target (car (car suggest)))
	(list   (cdr suggest))
	(list-length (1- (length suggest))))

    (ac-delete-pre-suggest)
    (insert (nth (% nth list-length) list))

    (ac-display-completion-list list nth)
    ; 次回の準備
    (if (= (length list) 1)
	(setq ac--suggest-count 0) 
      (setq ac--suggest-count (1+ ac--suggest-count))
      (setq ac--pre-suggest-region (cons (nth 1 (car suggest)) (point)))
      (or ac-mode-goto-end-of-word
	  (goto-char (min begin (point))))
      )
    ))

(defun ac-delete-pre-suggest ()
  (and ac--pre-suggest-region 
       (delete-region (car ac--pre-suggest-region) 
		      (cdr ac--pre-suggest-region))))

(defun ac-display-completion-list (list nth)
  "Display complations"
  (if ac-display-completions-p
      (with-output-to-temp-buffer "*Completions*"
	(display-completion-list list))
    (let ((list-length (length list)) 
	  (comp-str (concat "[" (nth (% nth list-length) list) "] "))
	  (num 1))
      (while (and (< num 7) (<= num list-length))
	(setq comp-str 
	      (concat comp-str (nth (% (+ nth num) list-length) list) "  "))
	(setq num (1+ num)))
   (message comp-str))))

(defun ac-point-at-eow (&optional regexp)
  (setq regexp (or regexp "\\(\\w\\|\\s_\\)+"))
  (if (looking-at regexp)
      (match-end 0) (point)))

(defun ac-another-minor-mode-key-binding ()
  (car (delq nil
	     (mapcar '(lambda (x) (mell-lookup-key x (this-command-keys)))
		     (cdr (member ac-mode-map (current-minor-mode-maps))))
	     )))

(defun ac-call-another-command (another-command)
  (let (ac-mode)
    (and (eq another-command 'skk-insert)
	 (setq this-command 'skk-insert))
    (call-interactively another-command)
    ))

(defun ac-indent (&optional start end)
  (if (and start end)
      (save-excursion
	(goto-char end)
	(let ((end (point-marker)))
	  (goto-char start)
	  (or (bolp) (forward-line 1))
	  (while (< (point) end)
	    (or (and (bolp) (eolp))
		(mell-call-next-interactively ac-mode-map))
	    (forward-line 1))
	  (move-marker end nil)))
    (mell-call-next-interactively ac-mode-map)
    ))

; PATH の補完
(defun path-complete ()
  (interactive)
  (save-excursion
    (let ((begin (point))
	  (path-regexp (concat "[" ac-mode-path-char "]+")))
      (if (< (skip-chars-backward ac-mode-path-char) 0)
	  (progn
	    (re-search-forward path-regexp begin t)
	    (let ((dir  (file-name-directory (match-string 0)))
		  (file (file-name-nondirectory (match-string 0))))
	      (and dir (file-exists-p dir)
		   (let ((comp-base 
			  (list file (- (match-end 0) (length file))
				(match-end 0)
				(ac-point-at-eow path-regexp)))
			 (comp (file-name-completion file dir))
			 (comp-list (file-name-all-completions file dir)))
		     (cond ((null comp-list) (cons comp-base nil))
			   ((and (stringp comp) (string-lessp file comp))
			    (list comp-base comp))
			   (t (cons comp-base comp-list)))))))))))

; URL の補完
(defun url-complete ()
  (interactive)
  (save-excursion
    (let ((begin (point))
	  (buf (get-buffer url-complete--buffer))
	  (url-regexp (concat "[" ac-mode-url-char "]+"))
	  match-url match-region comp)
      (if (and (< (skip-chars-backward ac-mode-url-char) 0)
	       (looking-at "http:")
	       (file-exists-p ac-mode-url-file))
	  (progn
	    (re-search-forward url-regexp begin t)
	    (setq match-url (match-string 0))
	    (setq match-data 
		  (list (match-string 0) (match-beginning 0) (match-end 0)
			(ac-point-at-eow url-regexp)))
	    (set-buffer url-complete--buffer)
	    (erase-buffer)
	    (call-process "look" nil url-complete--buffer nil match-url
			  (expand-file-name ac-mode-url-file))

	    (let* ((line1 (progn (goto-char (point-min))
				 (re-search-forward "^.+$" nil t)
				 (list (match-string 0))))
		   (line2 (progn (goto-char (point-max))
				 (re-search-backward "^.+$" nil t)
				 (list (match-string 0))))
		   (comp (try-completion match-url (list line1 line2))))
	      (cond ((and (stringp comp) (string-lessp match-url comp))
		     (list match-data comp))
		    (t
		     (cons match-data (split-string (buffer-string))))
		    )))))))

; 動的単語補完 (dabbrev)
(defun ac-dabbrev-completion ()
  (interactive)
  (let (dabbrev-list
	dabbrev-alist
	(search-regexp "\\(\\w\\|\\s_\\)+")
	(current-buffer (current-buffer))
	(begin (point)))
    (if (and (>= (skip-syntax-backward "w_") 0)
	     (or (>= (skip-chars-backward " ")   0)
		 (>= (skip-syntax-backward "w_") 0))
	     )
	(progn (goto-char begin) nil)

      (re-search-forward (concat search-regexp " *") begin t)
      (let* ((mb0 (match-beginning 0))
	     (me0 (match-end 0))
	     (base (match-string 0))
	     (base-data (list base mb0 me0 (ac-point-at-eow)))
	     (search-str (concat "\\<" (regexp-quote base) search-regexp))
	     (current-string (buffer-substring mb0 (ac-point-at-eow)))
	     )
	(and (/= me0 (ac-point-at-eow))
	     (setq dabbrev-alist (list (cons current-string current-string))
		   dabbrev-list (list current-string)))
	
	(setq ac-mode-start-time (current-time))
	(ac-dabbrev-completion--search (buffer-list))
	(set-buffer current-buffer)

	(let ((base-completion (try-completion base dabbrev-alist)))
	  (if (and (stringp base-completion)
		   (string-lessp base base-completion))
	      (if nil ;; 以前の動作
		  (list base-data base-completion)
		(setq base-data 
		      (list base-completion (nth 1 base-data)
			    (+ (nth 1 base-data) (length base-completion))
			    (nth 3 base-data)))
		(cons base-data (reverse dabbrev-list))
		)
	    (cons base-data (reverse dabbrev-list))))
	))))

; 動的 migemo 補完
(defun ac-migemo-completion ()
  (interactive)
  (let ((ac-midemo-search t)
	dabbrev-list
	dabbrev-alist
	(search-regexp (concat "[" ac-mode-dabbrev-char "]+"))
	(current-buffer (current-buffer))
	(begin (point)))
    (if (or (not (featurep 'migemo))
	    (> (skip-chars-backward ac-mode-dabbrev-char) -4)) ; 4 文字以上
	(progn (goto-char begin) nil)

      (re-search-forward search-regexp begin t)
      (let* ((base (match-string 0))
	     (base-data (list base (match-beginning 0) (match-end 0)
			      (ac-point-at-eow)))
;	     (search-str (migemo-get-pattern base)))
	     (search-str (concat "\\(" (migemo-get-pattern base) "\\)"
				 "[^ \n\t、。，．]*\\>")))
	(ac-dabbrev-completion--search (buffer-list))
	(set-buffer current-buffer)

	(let ((base-completion (try-completion base dabbrev-alist)))
	  (if (and (stringp base-completion)
		   (string-lessp base base-completion))
	      (list base-data base-completion)
	    (cons base-data (cdr (reverse dabbrev-list)))))
	))))

; 動的単語補完 (dabbrev) + 動的 migemo 補完
(defun ac-dabbrev-migemo-completion ()
  (interactive)
  (let ((ac-midemo-search t)
	(dabbrev-list nil)
	(dabbrev-alist nil)
	(search-regexp (concat "[" ac-mode-dabbrev-char "]+"))
	(current-buffer (current-buffer))
	(begin (point)))
    (if (or (not (featurep 'migemo))
	    (> (skip-chars-backward ac-mode-dabbrev-char) -1))
					; 0 文字以上 (意味なし)
	(progn (goto-char begin) nil)

      (re-search-forward search-regexp begin t)
      (let* ((base (match-string 0))
	     (base-data (list base (match-beginning 0) (match-end 0)
			      (ac-point-at-eow)))
	     (search-str (concat "\\<" base search-regexp "\\|"
				 "\\(" (migemo-get-pattern base) "\\)"
				 "[^ \n\t、。，．]*")))
;				 "[^ \n\t、。，．]*\\>")))
;dabbrev
;	     (search-str (concat "\\<" base search-regexp)))
;migemo
;	     (search-str (concat "\\(" (migemo-get-pattern base) "\\)"
;				 "[^ \n\t、。，．]*\\>")))
	(setq taiyaki search-str)
	(ac-dabbrev-completion--search (buffer-list))
	(set-buffer current-buffer)

	(cons base-data (reverse dabbrev-list))
;	(let ((base-completion (try-completion base dabbrev-alist)))
;	  (if (and (stringp base-completion)
;		   (string-lessp base base-completion))
;	      (list base-data base-completion)
;	    (cons base-data (cdr (reverse dabbrev-list)))))
	))))

(defun ac-dabbrev-completion--search (buffer-list)
  ; dabbrev-list, dabbrev-alist, search-str を使っている.
  (let ((buffer-list-tmp buffer-list)
	(begin (point)))
    (while buffer-list-tmp
      (set-buffer (car buffer-list-tmp))
      (let* ((current-window (get-buffer-window (current-buffer)))
	     (current-window-start (window-start current-window))
	     (current-window-end   (window-end   current-window)))
	(if current-window
	    (progn
	      (setq buffer-list (delq (current-buffer) buffer-list))
	      (setq begin (point))
  	      ; point が window 内にあるか? (マウスによるスクロール)
	      (if (or (< begin current-window-start)
		      (> begin current-window-end))
		  (goto-char current-window-start)
		(goto-char begin)
		(ac-dabbrev-completion--backward current-window-start)
		(goto-char begin))
	      (ac-dabbrev-completion--forward current-window-end)
	      (goto-char current-window-start)
	      (ac-dabbrev-completion--backward nil)
	      (goto-char current-window-end)
	      (ac-dabbrev-completion--forward nil)
	      (goto-char begin)
	      )))
      (setq buffer-list-tmp (cdr buffer-list-tmp)))
    (setq buffer-list-tmp buffer-list)
    (while buffer-list-tmp
      (if (string-match "^ " (buffer-name (car buffer-list-tmp)))
	  nil
	(set-buffer (car buffer-list-tmp))
	(setq begin (point))
	(ac-dabbrev-completion--backward nil)
	(goto-char begin)
	(ac-dabbrev-completion--forward nil)
	(goto-char begin))
      (setq buffer-list-tmp (cdr buffer-list-tmp)))))

;;;; TODO
; カタカナの途中でヒットするのをさける
; ("スクロール" 中の "クロール" など)
(defun ac-dabbrev-completion--forward (bound)
  (while (and (< (get-interval (current-time) ac-mode-start-time)
		 ac-mode-timeout-interval-time)
	      (re-search-forward search-str bound t))
    (let ((ms0 (match-string 0))
	  (ms1 (match-string 1)))
      (if (not (member ms0 dabbrev-list))
	  (cond 
	   ;; いんちき処理 migemo をいじるべき.
	   ((and (boundp 'ac-migemo-search) ac-migemo-search
		 ms1 (string-match "^[a-zA-Z]+$" ms1))
	    ; do nothing
	    nil)
	   ((string-match "^\\(\\cK+\\|\\cS\\)" ms0)
	    (if (not (member (match-string 1 ms0) dabbrev-list))
		(setq dabbrev-list  (cons (match-string 1 ms0) dabbrev-list)
		      dabbrev-alist (cons (list (match-string 1 ms0)) dabbrev-alist))))
	   ((string-match "^\\(\\cC+\\)" ms0)
	    (if (and (> (length (match-string 1 ms0)) 1)
		     (not (member (match-string 1 ms0) dabbrev-list)))
		(setq dabbrev-list  (cons (match-string 1 ms0) dabbrev-list)
		      dabbrev-alist (cons (list (match-string 1 ms0)) dabbrev-alist))))
	   ((string-match "^\\(\\cH+\\)" ms0)
	    (if (and (> (length (match-string 1 ms0)) 3)
		     (not (member (match-string 1 ms0) dabbrev-list)))
		(setq dabbrev-list  (cons (match-string 1 ms0) dabbrev-list)
		      dabbrev-alist (cons (list (match-string 1 ms0)) dabbrev-alist))))
	   (t
	    (setq dabbrev-list  (cons ms0 dabbrev-list)
		  dabbrev-alist (cons (list ms0) dabbrev-alist)))
	   )))))

(defun ac-dabbrev-completion--backward (bound)
  (while (and (< (get-interval (current-time) ac-mode-start-time)
		 ac-mode-timeout-interval-time)
	      (re-search-backward search-str bound t))
    (let ((ms0 (match-string 0))
	  (ms1 (match-string 1)))
      (if (not (member ms0 dabbrev-list))
	  (cond 
	   ;; いんちき処理 migemo をいじるべき.
	   ((and (boundp 'ac-migemo-search) ac-migemo-search
		 ms1 (string-match "^[a-zA-Z]+$" ms1))
	    ; do nothing
	    nil)
	   ((string-match "^\\(\\cK+\\|\\cS\\)" ms0)
	    (if (not (member (match-string 1 ms0) dabbrev-list))
		(setq dabbrev-list  (cons (match-string 1 ms0) dabbrev-list)
		      dabbrev-alist (cons (list (match-string 1 ms0)) dabbrev-alist))))
	   ((string-match "^\\(\\cC+\\)" ms0)
	    (if (and (> (length (match-string 1 ms0)) 1)
		     (not (member (match-string 1 ms0) dabbrev-list)))
		(setq dabbrev-list  (cons (match-string 1 ms0) dabbrev-list)
		      dabbrev-alist (cons (list (match-string 1 ms0)) dabbrev-alist))))
;;; FIX ME!
; "ああああ" を aa で backward 検索した場合, 後ろの 2 文字と前の 2 文字で
; 分断されてしまい. このままではまずい.
	   ((string-match "^\\(\\cH+\\)" ms0)
	    (if (and (> (length (match-string 1 ms0)) 3)
		     (not (member (match-string 1 ms0) dabbrev-list)))
		(setq dabbrev-list  (cons (match-string 1 ms0) dabbrev-list)
		      dabbrev-alist (cons (list (match-string 1 ms0)) dabbrev-alist))))
	   (t
	    (setq dabbrev-list  (cons ms0 dabbrev-list)
		  dabbrev-alist (cons (list ms0) dabbrev-alist)))
	   )))))

;(defun ac-dabbrev-completion--forward (bound)
;  (while (re-search-forward search-str bound t)
;    (if (and (not (member (match-string 0) dabbrev-list))
;	     (not (and (match-string 1) ;; いんちき処理 migemo をいじるべき.
;		       (string-match "^[a-zA-Z]+$" (match-string 1)))))
;	(setq dabbrev-list  (cons (match-string 0) dabbrev-list)
;	      dabbrev-alist (cons (list (match-string 0)) dabbrev-alist))
;	 )))

;(defun ac-dabbrev-completion--backward (bound)
;  (while (re-search-backward search-str bound t)
;    (if (and (not (member (match-string 0) dabbrev-list))
;	     (not (and (match-string 1) ;; いんちき処理 migemo をいじるべき.
;		       (string-match "^[a-zA-Z]+$" (match-string 1)))))
;	(setq dabbrev-list  (cons (match-string 0) dabbrev-list)
;	      dabbrev-alist (cons (list (match-string 0)) dabbrev-alist))
;	 )))


; face の設定
(setq ac-face (make-face 'ac-face))
(set-face-underline-p ac-face t)


(provide 'ac-mode)
; $Id: ac-mode.el,v 1.1.1.1 2002/08/25 14:24:47 komatsu Exp $
