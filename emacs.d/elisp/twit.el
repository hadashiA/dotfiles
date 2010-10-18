;;; twit.el --- interface with twitter.com

;; Copyright (c) 2007 Theron Tlax
;; Time-stamp: <2007-03-19 18:33:17 thorne>
;; Author: thorne <thorne@timbral.net>
;; Created: 2007.3.16
;; Keywords: comm
;; Favorite Poet: E. E. Cummings

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation version 2.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; For a copy of the GNU General Public License, search the Internet,
;; or write to the Free Software Foundation, Inc., 59 Temple Place,
;; Suite 330, Boston, MA 02111-1307 USA

;;; Commentary:

;; This is the beginnings of a library for interfacing with
;; twitter.com from Emacs.  It is also (more importantly) some
;; interactive functions that use that library.  It's a hack, of
;; course; RMS i am not.  Maybe one of you real programmers would
;; like to clean it up?

;; This uses Twitter's XML-based api, not the JSON one because i
;; would like to avoid making the user install third-party libraries
;; to use it.

;;  Use:

;;                            FOR POSTING

;; There are four main interactive functions:

;;   M-x twit-post RET will prompt for you to type your post directly
;;   in the minibuffer.

;;   M-x twit-post-region RET will post the region and

;;   M-x twit-post-buffer RET will post the entire contents of the
;;   current buffer.

;;   M-X twit-show-recent-tweets RET will create a new buffer and
;;   show your most recent messages in it.

;;   M-x twit-mode RET, if you want to bother, just binds the
;;   interactive functions to some keys.  Do C-h f RET twit-mode RET
;;   for more info.

;;   M-x twit-follow-recent-tweets RET will create a new buffer,
;;   show the most recent tweets, and update it every 90 seconds (idle)

;; But remember that your posts can't be longer than 140 (`twit-size')
;; characters long.  All of these functions will also prompt you for
;; your user name (usually the email address you signed up to twitter
;; with) and password the first time in a given Emacs session.  Note
;; that twitter uses `Basic Authentication' for user authentication,
;; which translates to, basically none.  It's not secure for anything
;; more than casual attacks.

;;                           FOR READING

;; This is a work in progress.  Just stubs.  I have to figure out
;; how to make some use out of `xml-parse-fragment'.  Until then,
;; `twit-list-followers' is incredibly stupid, but works.

;;                           FOR HACKING

;; See `twit-post-function', which is the backend for posting, and
;; `twit-parse-xml' which grabs an xml file from HTTP and turns it
;; into a list structure (using `xml-parse-fragment').  This is a work
;; in progress.

;; Installing:

;; There's not much to it.  It you want it always there and ready, you
;; can add something to your .emacs file like:

;; (load "twit")
;; (twit-mode t)
;; (setq twit-username "YOUR_USERNAME")
;; (setq twit-password "YOUR_PASSWORD")
;; (setq twit-favorite-friends
;;       '("hitoriblog" "otsune" "masui" "miyagawa" "emacs"))

;; or get fancier, to the extent you want and know how (autoloading,
;; keybinding, etc).

;; Notes:

;; `twit-user' gets my vote for variable name of the year.  Ditto
;; `twit-mode' for mode names.

;;; History:

;; 2007-3-16 theron tlax <thorne@timbral.net>
;; * 0.0.1 -- Initial release.  Posting only.
;; 2007-3-17 ''
;; * 0.0.2 -- Near-total rewrite; better documentation; use standard
;;            Emacs xml and url packages; minor mode; a little
;;            abstraction; some stubs for the reading functions.
;; * 0.0.3 -- Doc and other minor changes.
;; * 0.0.4 -- (released as 0.0.3 -- Added twit-show-recent-tweets
;;             by Jonathan Arkell)
;; * 0.0.5 -- Add source parameter to posts
;; * 0.0.6 -- Re-working twit-show-recent-tweets to show more info
;;            (and to get it working for me) -- by H Durer
;; * 0.0.7 -- Keymaps in the buffers for twit-show-recent-tweets and
;;            twit-list-followers; encode the post argument so that it
;;            is a valid post request
;; * 0.0.8 -- faces/overlays to make the *Twit-recent* buffer look
;;            prettier and more readable (at least for me) -- by H Durer
;; * 0.0.9 -- follow-recent-tweets function created so automagickally
;;            follow tweets every 5 mins.  Also removed twit-mode
;;            on twit-show-recent-tweets.  (it was setting twit-mode
;;            globally, and interfering with planner)
;; * 0.0.10 -- twit-post now has interactive character count
;; * 0.0.11 -- interactive character count respects twitter.com
;;             idiosyncrasies; also, added soft character limit

;; 2007-10-7 moyashi <http://moyashi.air-nifty.com/hitori/>
;; * 0.0.11-0.0.1 -- Add some dirty functions by moyashi. Treat this as variant.
;;
;; 2007-10-8 moyashi <http://moyashi.air-nifty.com/hitori/>
;; * 0.0.11-0.0.2 -- redecorate twit-status-mode view
;;                   twit-status-mode reflect localtime
;;                   keymap modified to like navi2ch
;;                   twit-status-mode show shrinked entities on message
;;
;; * 0.0.11-0.0.3 -- "(previous-line)" replace to "(forward-line -1)".
;;                   face ":foreground "black"" remove.
;;
;; * 0.0.11-0.0.4 -- "(kill-buffer (current-buffer))" replace to "(kill-window)".
;;
;; * 0.0.11-0.0.5 -- touch-up twit-delete-status-winow function
;;                   touch-up twit-post-with-user-id function
;;
;; 2007-10-19 moyashi <http://moyashi.air-nifty.com/hitori/>
;; * 0.0.11-0.0.6 -- touch-up twit-post-with-user-id function again (Thank you, dagezi!)
;;                   touch-up "r" keymap
;;                   mapping scroll-up to "j" instead of next-line
;;                   mapping scroll-down to "k" instead of previous-line
;;                   show specified user timeline if push down enter on user-id
;;
;; 2007-10-20 moyashi <http://moyashi.air-nifty.com/hitori/>
;; * 0.0.11-0.0.7 -- touch-up twit-post-with-user-id function again (use overlay)
;;                   browse client url if push down enter on client name
;;                   browse user home page if push down C-u enter on user-id
;;                   show specified user timeline if push down enter on reply header
;;                   make some elements clickable (mouse operation)
;;                   little change on twit-followers-mode (face, read-only, and so on)
;;
;; 2007-10-22 moyashi <http://moyashi.air-nifty.com/hitori/>
;; * 0.0.11-0.0.8 -- twit-followers-mode now fully functionally activated
;;                   show friends list if push down "f"
;;                   show followers list if push down "F"
;;                   Keybinds are just about same as twit-status-mode on twit-followers-mode
;;                   twit-shrink-entities processable Numeric character reference
;;
;; 2007-11-04 moyashi <http://moyashi.air-nifty.com/hitori/>
;; * 0.0.11-0.0.9 -- show specified user friends timeline if push down S-enter on user-id
;;                   (M-enter on non window-system)
;;                   push down "tab" or "S-tab (M-tab on non window-system)": jump to url
;;                   push down "g" and type in friend name: show user timeline directly
;;                   you should set variable "twit-favorite-friends" before try to use this function
;;                   contents of "twit-favorite-friends" are like below:
;;
;;                   (setq twit-favorite-friends '("otsune" "masui" "miyagawa"))
;;
;; 2007-11-07 moyashi <http://moyashi.air-nifty.com/hitori/>
;; * 0.0.11-0.1.0 -- push down "@", show replies
;;                   push down "l", show history
;;
;; 2007-11-09 moyashi <http://moyashi.air-nifty.com/hitori/>
;; * 0.0.11-0.1.1 -- push down "A" on user-id: following current user
;;                   push down "D" on user-id: remove current user
;;                   push down "d" on my user-id with twit-status-mode: delete current status (message)
;;                   push down "i" with twit-status-mode: search with Google
;;                   push down "I" with twit-status-mode: search with Amazon.jp
;;                   push down "M-i" with twit-status-mode: search with iTunes STORE
;;
;; 2007-11-10 moyashi <http://moyashi.air-nifty.com/hitori/>
;; * 0.0.11-0.1.2 -- It become possible to auto login.
;;                   You should set variable twit-username
;;                   and twit-password in .emacs.el
;;
;; 2007-11-10 moyashi <http://moyashi.air-nifty.com/hitori/>
;; * 0.0.11-0.1.3 -- push down "a" on user-id: current status add to favorites
;;                   push down "b": show favorites
;;                   push down "d" on favorite: delete favorite
;;
;; 2009-9-1 amacou <http://d.hatena.ne.jp/amacou/>
;; * 0.0.11-0.1.4 -- add show-user-images option
;;                   setting expample...
;;
;;                   (setq twit-show-user-images t)
;;                   (setq twit-user-image-dir
;;                         (expand-file-name "~/.emacs.d/twiter/"))
;;
;; 2009-9-6 amacou <http://d.hatena.ne.jp/amacou/>
;; * 0.0.11-0.1.5 -- filtering already showed message for TL
;;
;; 2009-9-6 amacou <http://d.hatena.ne.jp/amacou/>
;; * 0.0.11-0.1.6 -- add growl notification option
;;                   download growl.el from http://coderepos.org/share/browser/lang/elisp/emacs-growl/trunk/growl.el
;;                   and setting
;;
;;                   (setq twit-use-growl-notification t)
;;
;; Bugs:

;; * Posts with semicolons are being silently truncated.  I don't
;;   know why.

;;   `twit-list-followers' may not work if it is the first thing you
;;   do.

;; Report bugs to me at the listed email address.  Additionally,
;; report the absence of bugs if you are using a system not in the
;; list below of systems tested at least minimally:

;; Twit 0.0.2 / Emacs 22.0.93.1 / windows-nt
;; Twit 0.0.2 / Emacs 23.0.51.1 / gnu/linux
;; Twit 0.0.3 / Emacs 22.92.1 / gnu/linux
;; Twit 0.0.6 / Emacs 22.0.90.1 / gnu/linux
;; Twit 0.0.8 / Emacs 22.1.1 / gnu/linux
;; Twit 0.0.8 / Emacs 22.0.99.1 / windows

;;; To do:

;; Finish reading, and then add a timer for auto-update.

;;; Code:

(require 'cl)
(require 'xml)
(require 'url)
(require 'regexp-opt)
(require 'timezone)
(require 'growl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar twit-version-number "0.0.11-0.1.3")
(defvar twit-favorite-friends '("otsune" "masui" "miyagawa"))
(defvar twit-status-mode-map (make-sparse-keymap))
(defvar twit-followers-mode-map (make-sparse-keymap))
(defvar twit-post-mode-map minibuffer-local-map)
(defvar twit-username nil)
(defvar twit-password nil)
(defvar twit-visit-history-list nil)
(defvar twit-visit-max-number-of-history 10)
(defvar twit-visit-current-history nil)
(defvar twit-search-function-use-bill nil)
(defvar twit-urlencode-default-coding-system 'sjis)
(defvar twit-urlencode-exceptional-chars "[a-zA-Z0-9]")
(defvar twit-use-growl-notification nil)

;;define-key for twit-post-mode-map
;;not implemented yet.
(dolist (info '(
                ("\C-c\C-c" . exit-minibuffer)
                ))
  (define-key twit-post-mode-map (car info) (cdr info)))

;;define-key for twit-status-mode-map
(dolist (info '(
                ("d" . twit-destroy-status-or-favorite)
                ("a" . twit-create-favorite)
                ("n" . twit-forward-jump-message)
                ("p" . twit-backward-jump-message)
                (">" . twit-jump-to-end-of-status-window)
                ("<" . twit-jump-to-beginning-of-status-window)
                ("l" . twit-wayback-visit-history)
                ("i" . twit-search-function)
                ("I" . twit-amazon-function)
                ("\ei" . twit-itunes-store-function)
                ))
  (define-key twit-status-mode-map (car info) (cdr info)))

;;define-key for both mode
(dolist (info '(
                ("A" . twit-following-create)
                ("b" . twit-show-favorites)
                ("D" . twit-following-destroy)
                ("g" . twit-goto-friends-page)
                ("j" . twit-scroll-up)
                ("k" . twit-scroll-down)
                ("@" . twit-show-replies)
                ("W" . twit-post-with-user-id)
                ("s" . twit-show-recent-tweets)
                ("r" . twit-show-recent-tweets)
                ("F" . twit-list-followers)
                ("f" . twit-list-friends)
                ("w" . twit-post)
                ("1" . delete-other-windows)
                ("q" . twit-delete-status-winow)
                ("\C-m" . twit-enter)
                ([(shift return)] . twit-shift-enter)
                ("\e\C-m" . twit-shift-enter)
                ("\C-\i" . twit-next-tabstop)
                ([(shift tab)] . twit-previous-tabstop)
                ([(shift iso-lefttab)] . twit-previous-tabstop)
                ("\e\C-i" . twit-previous-tabstop)
                ([mouse-1] . twit-mouse-click)
                ))
  (define-key twit-status-mode-map (car info) (cdr info))
  (define-key twit-followers-mode-map (car info) (cdr info)))

;;define-key for twit-followers-mode-map
(dolist (info '(
                ("n" . next-line)
                ("p" . previous-line)
                (">" . end-of-buffer)
                ("<" . beginning-of-buffer)
                ))
  (define-key twit-followers-mode-map (car info) (cdr info)))

(defvar twit-timer
  nil
  "Timer object that handles polling the followers")

(defvar twit-soft-size 140
  "Maximum size for an untruncated Twitter post.")
(defvar twit-hard-size 160
  "Maximum size for a Twitter post.")
(defvar twit-size-format
  (concat "%"
          (format "%d"
                  (1+ (floor (log twit-hard-size 10))))
          "d")
  "String to `format' numbers based on the number of digits of
`twit-hard-size'.")

(defvar twit-minibuffer-setup-hook nil
  "Hook called when setting up prompt for `twit-post'")
(defvar twit-last-message-id nil)
(defvar twit-current-max-message-id nil)
;; Most of this will be used in the yet-to-be-written twitter
;; reading functions.
(defvar twit-base-url "http://twitter.com")

(defconst twit-follow-idle-interval 90)

(defconst twit-update-url
  (concat twit-base-url "/statuses/update.xml"))
(defconst twit-public-timeline-file
  (concat twit-base-url "/statuses/public_timeline.xml"))
(defconst twit-friend-timeline-file
  (concat twit-base-url "/statuses/friends_timeline.xml"))
(defconst twit-replies-file
  (concat twit-base-url "/statuses/replies.xml"))
(defconst twit-statuses-destory-base-url
  (concat twit-base-url "/statuses/destroy/"))
(defconst twit-user-timeline-base-url
  (concat twit-base-url "/statuses/user_timeline/"))
(defconst twit-friends-timeline-base-url
  (concat twit-base-url "/statuses/friends_timeline/"))
(defconst twit-followers-file
  (concat twit-base-url "/statuses/followers.xml"))
(defconst twit-friend-list-file
  (concat twit-base-url "/statuses/friends.xml"))
(defconst twit-following-create-base-url
  (concat twit-base-url "/friendships/create/"))
(defconst twit-following-destroy-base-url
  (concat twit-base-url "/friendships/destroy/"))
(defconst twit-favourings-create-base-url
  (concat twit-base-url "/favourings/create/"))
(defconst twit-favourings-destroy-base-url
  (concat twit-base-url "/favourings/destroy/"))
(defconst twit-favorites-file
  (concat twit-base-url "/favorites.xml"))
(defconst twit-success-msg
  "Post sent (no guarantees, though)")
(defconst twit-too-long-msg
  (format "Post not sent because length exceeds %d characters"
          twit-hard-size))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Faces
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(copy-face 'bold 'twit-uri-face)
(set-face-attribute 'twit-uri-face nil
                    :family 'unspecified
                    :weight 'normal
                    :foreground "blue"
                    :width 'semi-condensed
                    :underline t
                    )

(copy-face 'bold 'twit-user-id-face)
(set-face-attribute 'twit-user-id-face nil
                    :family 'unspecified
                    :weight 'semi-bold
                    :foreground "OliveDrab"
                    :width 'semi-condensed
                    :underline t
                    )

(copy-face 'bold 'twit-protected-user-id-face)
(set-face-attribute 'twit-protected-user-id-face nil
                    :family 'unspecified
                    :weight 'semi-bold
                    :foreground "red"
                    :width 'semi-condensed
                    :underline t
                    )

(copy-face 'bold 'twit-author-face)
(set-face-attribute 'twit-author-face nil
                    :family 'unspecified
                    :weight 'semi-bold
                    :foreground "DarkGreen"
                    :width 'semi-condensed
                    )

(copy-face 'bold 'twit-timestamp-face)
(set-face-attribute 'twit-timestamp-face nil
                    :family 'unspecified
                    :weight 'normal
                    :foreground "SeaGreen"
                    :width 'semi-condensed
                    )

(copy-face 'bold 'twit-message-face)
(set-face-attribute 'twit-message-face nil
                    :family "helv"
                    :height 1.2
                    :weight 'normal
                    :width 'semi-condensed
                    )

(copy-face 'bold 'twit-location-face)
(set-face-attribute 'twit-location-face nil
                    :family 'unspecified
                    :weight 'normal
                    :foreground "SteelBlue"
                    :width 'semi-condensed
                    )

(copy-face 'bold 'twit-src-info-face)
(set-face-attribute 'twit-src-info-face nil
                    :family 'unspecified
                    :weight 'normal
                    :foreground "SlateBlue3"
                    :width 'semi-condensed
                    :underline t
                    )

(copy-face 'minibuffer-prompt 'twit-prompt-warning-face)

(set-face-attribute 'twit-prompt-warning-face nil
                    :foreground "yellow"
                    :weight 'semi-bold
                    )

(copy-face 'minibuffer-prompt 'twit-prompt-error-face)
(set-face-attribute 'twit-prompt-error-face nil
                    :foreground "red"
                    :weight 'bold
                    )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; General purpose library to wrap twitter.com's api
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Added by moyashi
(defun twit-regist-once-auth-storage ()
  ""
  (defvar url-http-real-basic-auth-storage nil)
  (if (progn
        (let ((auth-storage-definedp nil))
          (mapcar
           (function
            (lambda (x)
              (setq auth-storage-definedp
                    (or (numberp (string-match "twitter\.com.*" (car x)))
                        auth-storage-definedp))))
           url-http-real-basic-auth-storage)
          (not auth-storage-definedp)))
      (if (and
           (not (null twit-username))
           (not (null twit-password)))
          (setq url-http-real-basic-auth-storage
                (append
                 url-http-real-basic-auth-storage
                 (list (list "twitter.com:80"
                             (cons "Twitter API"
                                   (base64-encode-string
                                    (format "%s:%s" twit-username twit-password)))
                             )))))))

(defun twit-parse-xml (url)
  "Retrieve file at URL and parse with `xml-parse-fragment'.
Emacs' url package will prompt for authentication info if required."
  (twit-regist-once-auth-storage)
  (let ((result nil))
    (save-window-excursion
                                        ;(with-timeout (3 (ignore))
      (set-buffer (url-retrieve-synchronously url))
                                        ;)
      (goto-char (point-min))
      (setq result (xml-parse-fragment))
      (kill-buffer (current-buffer)))
    result))

(defun twit-post-function (url post)
  (let ((url-request-method "POST")
        (url-request-data
         (concat "source=twit.el&status=" (url-hexify-string post)))
        ;; these headers don't actually do anything (yet?) -- the
        ;; source parameter above is what counts
        (url-request-extra-headers
         `(("X-Twitter-Client" . "twit.el")
           ("X-Twitter-Client-Version" . ,twit-version-number)
           ("X-Twitter-Client-URL" . "http://www.emacswiki.org/cgi-bin/emacs/twit.el"))))
    (message "%s" url-request-data)
    (url-retrieve url (lambda (arg) (kill-buffer (current-buffer))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Helpers for the interactive functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Added by moyashi
(defun twit-visit-push-history (user-id kind)
  ""
  (setq twit-visit-history-list
        (append (list (list user-id kind))
                twit-visit-history-list))
  (if (> (list-length twit-visit-history-list)
         twit-visit-max-number-of-history)
      (setq twit-visit-history-list
            (butlast twit-visit-history-list))
    ))

;;Added by moyashi
(defun twit-visit-pop-history ()
  ""
  (let ((current-user-id (car twit-visit-history-list)))
    (setq twit-visit-history-list
          (cdr twit-visit-history-list))
    current-user-id
    ))

(defun twit-expand-entities (str)
  "Expand the characters counted specially by Twitter ('<' and
'>') to HTML entities.

More efficient than replace-regexp-in-string.  Note that Twitter
doesn't expand '&'."
  (let ((str2 ""))
    (dotimes (i (length str) str2)
      (cond ((eq (elt str i) ?<)
             (setq str2 (concat str2 "&lt;")))
            ((eq (elt str i) ?>)
             (setq str2 (concat str2 "&gt;")))
            (t
             (setq str2 (concat str2 (char-to-string (elt str i)))))))))

;;Added by moyashi from twittering-mode.el
(defmacro twit-ucs-to-char (num)
  (if (functionp 'ucs-to-char)
      `(ucs-to-char ,num)
    `(decode-char 'ucs ,num)))

;;Added by moyashi
(defun twit-shrink-entities (str)
  (let* (entity)
    (progn
      (dolist
          (info '(
                  ("&lt;" . "<")
                  ("&gt;" . ">")
                  ("&amp;" . "&")
                  ("&quot;" . "\"")
                  ("&nbsp;" . " ")
                  ))
        (while (string-match (car info) str)
          (setq str (replace-match (cdr info) nil t str)))
        )
      (while (string-match "&#\\([0-9]+\\);" str)
        (setq entity (match-string-no-properties 1 str))
        (setq str (replace-match
                   (char-to-string
                    (twit-ucs-to-char (string-to-number entity)))
                   t t str)))
      str)))

;;Added by moyashi (from urlencode.el)
(defun twit-urlencode (str &optional coding-system)
  (mapconcat
   (lambda (c)
     (format (if (string-match
                  twit-urlencode-exceptional-chars
                  (char-to-string c))
                 "%c" "%%%02X") c))
   (encode-coding-string
    str
    (or coding-system
        twit-urlencode-default-coding-system))
   ""))

;;Added and modified by moyashi (from navi2ch-http-date.el)
(defconst twit-http-date-wkday-list
  '("Sun" "Mon" "Tue" "Wed" "Thu" "Fri" "Sat"))

;;Added and modified by moyashi (from navi2ch-http-date.el)
(defconst twit-http-date-month-list
  '("Jan" "Feb" "Mar" "Apr" "May" "Jun"
    "Jul" "Aug" "Sep" "Oct" "Nov" "Dec"))

;;Added and modified by moyashi (from navi2ch-http-date.el)
(defun twit-http-date-decode (http-date)
  (if (string-match
       "\\([0-9]+\\)-\\([A-Za-z]+\\)-\\([0-9]+\\)"
       http-date)
      (setq http-date
            (replace-match
             "\\1 \\2 \\3" nil nil http-date)))
  (let ((now (timezone-fix-time http-date "GMT" "GMT")))
    (encode-time (aref now 5)
                 (aref now 4)
                 (aref now 3)
                 (aref now 2)
                 (aref now 1)
                 (aref now 0)
                 (aref now 6))))

;;Added and modified by moyashi (from navi2ch-http-date.el)
(defun twit-http-date-encode (time)
  (let* ((now (timezone-fix-time
               (current-time-string time)
               (current-time-zone time)
               (car (cdr (current-time-zone)))))
         (abs (timezone-absolute-from-gregorian
               (aref now 1)
               (aref now 2)
               (aref now 0)))
         (wkday (nth (% abs 7) twit-http-date-wkday-list))
         (month (nth (1- (aref now 1)) twit-http-date-month-list)))
    (format "%s, %02d %s %04d %02d:%02d:%02d %s"
            wkday
            (aref now 2)
            month
            (aref now 0)
            (aref now 3)
            (aref now 4)
            (aref now 5)
            (car (cdr (current-time-zone))))))

(defun twit-string-length (str)
  "Calculate the length of a string for Twitter.com posts.

Though the Twitter API documentation talks about 'characters',
tests seem to show that they're actually counting 'bytes',
encoded as UTF-8; furthermore, some characters are counted as
HTML entites.  This function returns the final byte count, as of
Oct 2007."

  (length
   (encode-coding-string
    (twit-expand-entities str)
    'utf-8)))

(defun twit-minibuffer-update-prompt ()
  "Called in minibuffer, update prompt.
Helper for `twit-query-for-post'."
  (let* ((inhibit-read-only t)
         (buflen
          (twit-string-length (minibuffer-contents)))
         (teh-face (cond
                    ((<= buflen twit-soft-size)
                     'minibuffer-prompt)
                    ((<= buflen twit-hard-size)
                     'twit-prompt-warning-face)
                    (t 'twit-prompt-error-face))))

    (save-excursion
      (goto-char (point-min))

      (search-forward " (")
      (let ((start-of-num (point)))
        (search-forward "/")
        (forward-char -1)
        (delete-region start-of-num (point))
        (goto-char start-of-num)

        (princ (format twit-size-format buflen)
               (current-buffer))

        ;; properties based on GNU emacs 22.1.1
        (set-text-properties start-of-num (point)
                             `(face ,teh-face
                                    read-only t
                                    field t
                                    rear-nonsticky t
                                    front-sticky t))))))

(defun twit-query-for-post (&optional user-id)
  "Query for a Twitter.com post text in the minibuffer."
  (let ((old-mbuf-setup minibuffer-setup-hook)
        (input nil))
    (if (eq user-id nil)
        (setq user-id ""))
    ;; not very beautiful
    (unwind-protect
        (progn
          (add-hook 'post-command-hook
                    'twit-minibuffer-update-prompt
                    'append)

          (dolist (hook twit-minibuffer-setup-hook)
            (setq minibuffer-setup-hook
                  (append minibuffer-setup-hook (list hook))))

          (setq input (read-from-minibuffer
                       (concat "Post ("
                               (format twit-size-format 0)
                               "/"
                               (format "%d" twit-hard-size)
                               "): ") user-id twit-post-mode-map)))

      (progn
        (remove-hook
         'post-command-hook
         'twit-minibuffer-update-prompt)
        (setq minibuffer-setup-hook old-mbuf-setup)))
    input))

(defun twit-write-tweets (file &optional filtering)
  (save-excursion
    (delete-region (point-min) (point-max))
    (insert (format-time-string "Last updated: %c\n"))
    (labels ((xml-first-child
              (node attr)
              (car (xml-get-children node attr)))
             (xml-first-childs-value
              (node addr)
              (car (xml-node-children
                    (xml-first-child node addr)))))
      (dolist (status-node
               (xml-get-children
                (cadr (twit-parse-xml file))
                'status))
        (let* ((user-info (xml-first-child status-node 'user))
               (user-id (or (xml-first-childs-value user-info 'screen_name) "??"))
               (user-name (xml-first-childs-value user-info 'name))
               (user-img (if twit-show-user-images
                             (twit-get-user-image (xml-first-childs-value user-info 'profile_image_url) user-id)
                           nil))
               (location (xml-first-childs-value user-info 'location))
               (url (xml-first-childs-value user-info 'url))
               (src-info (xml-first-childs-value status-node 'source))
               (timestamp (xml-first-childs-value status-node 'created_at))
               (message (xml-first-childs-value status-node 'text))
               (message-id (xml-first-childs-value status-node 'id)))


          (when message-id
          (if (and twit-current-max-message-id (>= (string-to-int twit-current-max-message-id) (string-to-int message-id)))
              nil
            (setq twit-current-max-message-id message-id)))

          ;;hide alrady shown message when update TL
          (when (or (null filtering)
                    (and filtering
                         (or (null twit-last-message-id)
                             (>= (string-to-int message-id) (string-to-int twit-last-message-id)))))
            (progn
              ;; make URI clickable
              (let* ((regex-index 0))
                (while regex-index
                  (setq regex-index
                        (string-match "https?://[-_.!~*'()a-zA-Z0-9;/?:@&=+$,%#]+"
                                      message
                                      regex-index))
                  (if regex-index
                      (progn
                        (incf regex-index)
                        (add-text-properties
                         (match-beginning 0) (match-end 0)
                         (list 'mouse-face 'highlight
                               'uri (match-string 0 message)
                               'tabstop "dummy"
                               'face 'twit-uri-face)
                         message)
                        ))))

              ;; make reply clickable may be..
              (let* ((regex-index 0))
                (while regex-index
                  (setq regex-index
                        (string-match "@\\([a-zA-Z0-9_]+\\)"
                                      message
                                      regex-index))
                  (if regex-index
                      (progn
                        (incf regex-index)
                        (add-text-properties
                         (match-beginning 1) (match-end 1)
                         (list 'mouse-face 'highlight
                               'uri (match-string 0 message)
                               'tabstop "dummy"
                               'face 'twit-uri-face)
                         message)
                        ))))

              ;; the string-match is a bit weird, as emacswiki.org won't
              ;; accept pages with the href in it per se
              (setq src-url "http://twitter.com/")
              ;; show growl
              (when (and twit-use-growl-notification filtering)
                (when (string-match
                        twit-username
                        message)
                  (growl message)))

              (when (and src-info
                         (string-match
                          (concat "<a h" "ref=\"\\(.*?\\)\">\\(.*\\)<" "/a>")
                          src-info))
                ;; remove the HTML link info; leave just the name
                (setq src-url (match-string 1 src-info))
                (setq src-info (match-string 2 src-info)))
              ;; First line: Name and message
              (twit-insert-with-overlay-attributes
               "-----------------------------------------\n"
               '((face . "twit-author-face")))
              (add-text-properties 0 (length user-id)
                                   (list
                                    'mouse-face 'highlight
                                    'uri url)
                                   user-id)

              (when (and twit-show-user-images user-img)
                (insert " ")
                (insert-image user-img)
                (insert " ")
                (insert "\n"))

              (twit-insert-with-overlay-attributes
               user-id
               (list (cons 'face "twit-user-id-face")
                     (cons 'user-id user-id)
                     (cons 'message-id message-id)
                     (cons 'is-favorite (not (null (string-match ".*/favorites.xml" file))))))
              (twit-insert-with-overlay-attributes
               (format "%s"
                       (concat
                        (if user-name
                            (concat " (" user-name ") ")
                          )))
               '((face . "twit-author-face")))
              (when timestamp
                (twit-insert-with-overlay-attributes
                 (twit-http-date-encode
                  (twit-http-date-decode timestamp))
                 '((face . "twit-timestamp-face")))
                )
              (insert ":\n")
              (insert
               (twit-shrink-entities message))
              (insert "\n")
              (when (or location src-info)
                (insert "from ")
                (when location
                  (twit-insert-with-overlay-attributes
                   location
                   '((face . "twit-location-face"))))
                (when src-info
                  (progn
                    (insert " (via ")
                    (twit-insert-with-overlay-attributes
                     src-info
                     (list (cons 'face "twit-src-info-face")
                           (cons 'src-url src-url)
                           (cons 'mouse-face 'highlight)
                           ))
                    (insert ")")
                    )
                  )
                (insert "\n")))))            ))

    ;; go back to top so we see the latest messages
    (goto-char (point-min))))

;;Added by moyashi
(defun twit-list-friends (file)
  (save-excursion
    (delete-region (point-min) (point-max))
    (labels ((xml-first-child
              (node attr)
              (car (xml-get-children node attr)))
             (xml-first-childs-value
              (node addr)
              (car (xml-node-children
                    (xml-first-child node addr)))))
      (dolist (user-node
               (xml-get-children
                (cadr (twit-parse-xml file))
                'user))
        (let* ((status-info (xml-first-child user-node 'status))
               (timestamp (xml-first-childs-value status-info 'created_at))
               (message (xml-first-childs-value status-info 'text))
               (src-info (xml-first-childs-value status-info 'source))
               (truncated (xml-first-childs-value status-info 'truncated))
               (id (xml-first-childs-value user-node 'id))
               (user-name (xml-first-childs-value user-node 'name))
               (user-id (or (xml-first-childs-value user-node 'screen_name) "??"))
               (location (xml-first-childs-value user-node 'location))
               (description (xml-first-childs-value user-node 'description))
               (url (xml-first-childs-value user-node 'url))
               (protected (xml-first-childs-value user-node 'protected)))

          ;; the string-match is a bit weird, as emacswiki.org won't
          ;; accept pages with the href in it per se
          (setq src-url "http://twitter.com/")
          (when (and src-info
                     (string-match
                      (concat "<a h" "ref=\"\\(.*?\\)\">\\(.*\\)<" "/a>")
                      src-info))
            ;; remove the HTML link info; leave just the name
            (setq src-url (match-string 1 src-info))
            (setq src-info (match-string 2 src-info)))
          ;; First line: Name and message
          (add-text-properties 0 (length user-id)
                               (list
                                'mouse-face 'highlight
                                'uri url)
                               user-id)
          (twit-insert-with-overlay-attributes
           user-id
           (list (if (string= protected "false")
                     (cons 'face "twit-user-id-face")
                   (cons 'face "twit-protected-user-id-face"))
                 (cons 'user-id user-id)))
          (twit-insert-with-overlay-attributes
           (format "%s"
                   (concat
                    (if user-name
                        (concat " (" user-name ") ")
                      )))
           '((face . "twit-author-face")))
          (insert ": ")
          (when (or location src-info)
            (insert "from ")
            (when location
              (twit-insert-with-overlay-attributes
               location
               '((face . "twit-location-face"))))
            (when src-info
              (progn
                (insert " (via ")
                (twit-insert-with-overlay-attributes
                 src-info
                 (list (cons 'face "twit-src-info-face")
                       (cons 'src-url src-url)
                       (cons 'mouse-face 'highlight)
                       ))
                (insert ")")))
            (insert "\n")))))
    ;; go back to top so we see the latest messages
    (goto-char (point-min))))

;;Added by moyashi
(defun twit-write-friends (file)
  (save-excursion
    (delete-region (point-min) (point-max))
    (labels ((xml-first-child
              (node attr)
              (car (xml-get-children node attr)))
             (xml-first-childs-value
              (node addr)
              (car (xml-node-children
                    (xml-first-child node addr)))))
      (dolist (user-node
               (xml-get-children
                (cadr (twit-parse-xml file))
                'user))
        (let* ((status-info (xml-first-child user-node 'status))
               (timestamp (xml-first-childs-value status-info 'created_at))
               (message (xml-first-childs-value status-info 'text))
               (src-info (xml-first-childs-value status-info 'source))
               (truncated (xml-first-childs-value status-info 'truncated))
               (id (xml-first-childs-value user-node 'id))
               (user-name (xml-first-childs-value user-node 'name))
               (user-id (or (xml-first-childs-value user-node 'screen_name) "??"))
               (location (xml-first-childs-value user-node 'location))
               (description (xml-first-childs-value user-node 'description))
               (url (xml-first-childs-value user-node 'url))
               (protected (xml-first-childs-value user-node 'protected)))

          ;; the string-match is a bit weird, as emacswiki.org won't
          ;; accept pages with the href in it per se
          (setq src-url "http://twitter.com/")
          (when (and src-info
                     (string-match
                      (concat "<a h" "ref=\"\\(.*?\\)\">\\(.*\\)<" "/a>")
                      src-info))
            ;; remove the HTML link info; leave just the name
            (setq src-url (match-string 1 src-info))
            (setq src-info (match-string 2 src-info)))
          ;; First line: Name and message
          (add-text-properties 0 (length user-id)
                               (list
                                'mouse-face 'highlight
                                'uri url)
                               user-id)
          (twit-insert-with-overlay-attributes
           user-id
           (list (if (string= protected "false")
                     (cons 'face "twit-user-id-face")
                   (cons 'face "twit-protected-user-id-face"))
                 (cons 'user-id user-id)))
          (twit-insert-with-overlay-attributes
           (format "%s"
                   (concat
                    (if user-name
                        (concat " (" user-name ") ")
                      )))
           '((face . "twit-author-face")))
          (insert ": ")
          (when (or location src-info)
            (insert "from ")
            (when location
              (twit-insert-with-overlay-attributes
               location
               '((face . "twit-location-face"))))
            (when src-info
              (progn
                (insert " (via ")
                (twit-insert-with-overlay-attributes
                 src-info
                 (list (cons 'face "twit-src-info-face")
                       (cons 'src-url src-url)
                       (cons 'mouse-face 'highlight)
                       ))
                (insert ")")))
            (insert "\n")))))
    ;; go back to top so we see the latest messages
    (goto-char (point-min))))

(defun twit-follow-recent-tweets-timer ()
  "Timer function for recent tweets"
  (save-excursion
    (set-buffer "*Twit*")
    (toggle-read-only 0)
    (twit-write-recent-tweets)
    (toggle-read-only 1)))

;;Added by moyashi from navi2ch-util.el
(defun twit-next-property (point prop)
  (when (get-text-property point prop)
    (setq point (next-single-property-change point prop)))
  (when point
    (setq point (next-single-property-change point prop)))
  point)

;;Added by moyashi from navi2ch-util.el
(defun twit-previous-property (point prop)
  (when (get-text-property point prop)
    (setq point (previous-single-property-change point prop)))
  (when point
    (unless (get-text-property (1- point) prop)
      (setq point (previous-single-property-change point prop)))
    (when point
      (1- point))))

;;;; Added by amacou from twit.el(emacs-wiki)
(defvar twit-user-image-list 'nil
  "List containing all user images.")
(setq twit-user-image-list 'nil)

;; Added by amacou from twit.el(emacs-wiki)
(defun twit-get-user-image (url user-id)
  "Retrieve the user image from the list, or from the URL.
USER-ID must be provided."
  (let ((img (assoc url twit-user-image-list)))
    (if (and img (not (bufferp (cdr img))))
        (cdr (assoc url twit-user-image-list))
      (if (file-exists-p (concat twit-user-image-dir
                                 "/" user-id "-"
                                 (file-name-nondirectory url)))
          (let ((img (create-image
                      (concat twit-user-image-dir ;; What's an ana for? lol
                              "/" user-id "-"
                              (file-name-nondirectory url)))))
            (add-to-list 'twit-user-image-list (cons url img))
            img)
        (let* ((url-request-method "GET")
               (url-show-status nil)
               (url-buffer (url-retrieve url 'twit-write-user-image
                                         (list url user-id))))
          (if url-buffer
              (progn
                (add-to-list 'twit-user-image-list (cons url url-buffer))
                )
            nil)
          nil)))))

;; Added by amacou from twit.el(emacs-wiki)
(defun twit-write-user-image (status url user-id)
  "Called by `twit-get-user-image', to write the image to disk.

STATUS, URL and USER-ID are all set by `url-retrieve'."
  (let ((image-file-name
         (concat twit-user-image-dir
                 "/" user-id "-"
                 (file-name-nondirectory url))))
    (when (not (file-directory-p twit-user-image-dir))
      (make-directory twit-user-image-dir))
    (setq buffer-file-coding-system 'no-conversion)
    (setq buffer-file-name image-file-name)
    (goto-char (point-min))
    (delete-region (point-min) (search-forward "\C-j\C-j"))
    (save-buffer)
    (delete (cons url (current-buffer)) twit-user-image-list)
    (kill-buffer (current-buffer))
    (add-to-list 'twit-user-image-list (cons url (create-image image-file-name)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Main interactive functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Added by moyashi
(defun twit-goto-friends-page ()
  (interactive)
  (let ((user-id (completing-read
                  "Friend name: "
                  twit-favorite-friends nil t)))
    (twit-show-recent-tweets
     user-id "user")))

;;Added by moyashi
(defun twit-show-replies()
  (interactive)
  (twit-show-recent-tweets
   nil "replies"))

;;Added by moyashi
(defun twit-show-favorites ()
  (interactive)
  (twit-show-recent-tweets
   nil "favorites"))

;;Added by moyashi from navi2ch-article.el
(defun twit-next-tabstop ()
  "jump to next tabstop"
  (interactive)
  (let ((point (twit-next-property (point) 'tabstop)))
    (if point
        (progn
          (goto-char point)))))

;;Added by moyashi from navi2ch-article.el
(defun twit-previous-tabstop ()
  "jump to previous tabstop"
  (interactive)
  (let ((point (twit-previous-property (point) 'tabstop)))
    (if point
        (progn
          (goto-char point)))))

;;;###autoload
(defun twit-post ()
  "Send a post to twitter.com.
Prompt the first time for password and username \(unless
`twit-user' and/or `twit-pass' is set\) and for the text of the
post; thereafter just for post text.  Posts must be <=
`twit-hard-size' chars long."
  (interactive)
  (let* ((post (twit-query-for-post)))
    (if (> (length post) twit-hard-size)
        (error twit-too-long-msg)
      (if (twit-post-function twit-update-url post)
          (message twit-success-msg)))))

;;;###autoload
(defun twit-post-region (start end)
  "Send text in the region as a post to twitter.com.
Uses `twit-post-function' to do the dirty work and to obtain
needed user and password information.  Posts must be <=
`twit-hard-size' chars long."
  (interactive "r")
  (let ((post (buffer-substring start end)))
    (if (> (length post) twit-hard-size)
        (error twit-too-long-msg)
      (if (twit-post-function twit-update-url post)
          (message twit-success-msg)))))

;;;###autoload
(defun twit-post-buffer ()
  "Post the entire contents of the current buffer to twitter.com.
Uses `twit-post-function' to do the dirty work and to obtain
needed user and password information.  Posts must be <=
`twit-hard-size' chars long."
  (interactive)
  (let ((post (buffer-substring (point-min) (point-max))))
    (if (> (length post) twit-hard-size)
        (error twit-too-long-msg)
      (if (twit-post-function twit-update-url post)
          (message twit-success-msg)))))

;;;###autoload
(defun twit-list-people (file kind)
  "Display a list of all your twitter.com followers' names."
  (pop-to-buffer (concat "*Twit-" kind "*"))
  (toggle-read-only 0)
  (kill-region (point-min) (point-max))
  (twit-write-friends file)
  ;; set up mode as with twit-show-recent-tweets
  (text-mode)
  (toggle-read-only 1)
  (goto-char (point-min))
  (use-local-map twit-followers-mode-map))

;;Added by moyashi
(defun twit-list-followers ()
  (interactive)
  (twit-list-people twit-followers-file "followers"))

;;Added by moyashi
(defun twit-list-friends ()
  (interactive)
  (twit-list-people twit-friend-list-file "following"))

;;; Helper function to insert text into buffer, add an overlay and
;;; apply the supplied attributes to the overlay
(defun twit-insert-with-overlay-attributes (text attributes)
  (let ((start (point)))
    (insert text)
    (let ((overlay (make-overlay start (point))))
      (dolist (spec attributes)
        (overlay-put overlay (car spec) (cdr spec))))))

;;; Added by Jonathan Arkell
;;;###autoload
(defun twit-follow-recent-tweets ()
  "Display, and redisplay the tweets.
This might suck if it bounces the point to the bottom all the time."
  (interactive)
  (twit-show-recent-tweets)
  (setq twit-timer
        (run-with-idle-timer
         twit-follow-idle-interval
         1
         'twit-follow-recent-tweets-timer)))

;;;###autoload
(defun twit-show-recent-tweets (&optional user-id kind)
  "Display a list of the most recent twewets from your followers."
  (interactive)
  (pop-to-buffer "*Twit*")
  (toggle-read-only 0)
  (if user-id
      (progn
        (setq twit-visit-current-history (list user-id kind))
        (if (string= "user" kind)
            (twit-write-tweets
             (concat twit-user-timeline-base-url user-id ".xml"))
          (twit-write-tweets
           (concat twit-friends-timeline-base-url user-id ".xml"))))
    (if (string= "replies" kind)
        (progn
          (setq twit-visit-current-history (list user-id kind))
          (twit-write-tweets twit-replies-file))
      (if (string= "favorites" kind)
          (progn
            (setq twit-visit-current-history (list user-id kind))
            (twit-write-tweets twit-favorites-file))
        (setq twit-visit-current-history ())
        (progn
          (twit-write-tweets
           (concat twit-friend-timeline-file
                   (if twit-last-message-id
                       (concat "?since_id=" twit-last-message-id )
                     "?count=200")
                   )
           t)
          (setq twit-last-message-id twit-current-max-message-id))
        (setq twit-visit-history-list ()))))
  ;; set up some sensible mode and useful bindings
  (text-mode)
  (toggle-read-only 1)
  (use-local-map twit-status-mode-map))

;;Added by moyashi
(defun twit-query-for-create-favourings ()
  ""
  (labels ((xml-first-child
            (node attr)
            (car (xml-get-children node attr)))
           (xml-first-childs-value
            (node addr)
            (car (xml-node-children
                  (xml-first-child node addr)))))
    (let ((temp-overlay (car (overlays-in (point) (+ (point) 1))))
          message-id)
      (if (overlayp temp-overlay)
          (progn
            (setq message-id (overlay-get temp-overlay 'message-id))
            (if message-id
                (if (y-or-n-p "Are you ready to add to favorite this status?: ")
                    (progn
                      (let*
                          ((error-mes
                            (xml-first-childs-value
                             (cadr
                              (twit-parse-xml
                               (concat
                                twit-favourings-create-base-url
                                message-id
                                ".xml"))) 'error)))
                        (if (not (null error-mes))
                            (progn
                              (ding)
                              (message (concat " ERROR: " error-mes)))
                          (message "Add done right.")
                          ))))))))))

;;Added by moyashi
(defun twit-query-for-destroy-status-or-favourings ()
  ""
  (labels ((xml-first-child
            (node attr)
            (car (xml-get-children node attr)))
           (xml-first-childs-value
            (node addr)
            (car (xml-node-children
                  (xml-first-child node addr)))))
    (let ((temp-overlay (car (overlays-in (point) (+ (point) 1))))
          message-id
          is-favorite)
      (if (overlayp temp-overlay)
          (progn
            (setq message-id (overlay-get temp-overlay 'message-id))
            (setq is-favorite (overlay-get temp-overlay 'is-favorite))
            (if message-id
                (if is-favorite
                    (progn
                      (if (y-or-n-p "Are you ready to delete this status from favorites?: ")
                          (progn
                            (let*
                                ((error-mes
                                  (xml-first-childs-value
                                   (cadr
                                    (twit-parse-xml
                                     (concat
                                      twit-favourings-destroy-base-url
                                      message-id
                                      ".xml"))) 'error)))
                              (if (not (null error-mes))
                                  (progn
                                    (ding)
                                    (message (concat " ERROR: " error-mes)))
                                (message "Deleting done right.")
                                )))))
                  (if (y-or-n-p "Are you ready to delete this status?: ")
                      (progn
                        (let*
                            ((error-mes
                              (xml-first-childs-value
                               (cadr
                                (twit-parse-xml
                                 (concat
                                  twit-statuses-destory-base-url
                                  message-id
                                  ".xml"))) 'error)))
                          (if (not (null error-mes))
                              (progn
                                (ding)
                                (message (concat " ERROR: " error-mes)))
                            (message "Deleting done right.")
                            ))))
                  )))))))

;;Added by moyashi
(defun twit-query-for-following (kind)
  ""
  (if (or (string= kind "create") (string= kind "destroy"))
      (progn
        (labels ((xml-first-child
                  (node attr)
                  (car (xml-get-children node attr)))
                 (xml-first-childs-value
                  (node addr)
                  (car (xml-node-children
                        (xml-first-child node addr)))))
          (let ((temp-overlay (car (overlays-in (point) (+ (point) 1))))
                user-id)
            (if (overlayp temp-overlay)
                (progn
                  (setq user-id (overlay-get temp-overlay 'user-id))
                  (if user-id
                      (if (y-or-n-p
                           (concat " Are you ready to "
                                   (if (string= kind "create")
                                       "follow" "remove") " " user-id "?: "))
                          (progn
                            (let*
                                ((error-mes
                                  (xml-first-childs-value
                                   (cadr
                                    (twit-parse-xml
                                     (concat
                                      (if (string= kind "create")
                                          twit-following-create-base-url
                                        twit-following-destroy-base-url)
                                      user-id
                                      ".xml"))) 'error)))
                              (if (not (null error-mes))
                                  (progn
                                    (ding)
                                    (message (concat " ERROR: " error-mes)))
                                (message
                                 (if (string= kind "create")
                                     (concat " You are now following " user-id ".")
                                   (concat " Ok. You are no longer following " user-id ".")))
                                ))))))))))))


;;Added by moyashi
(defun twit-create-favorite ()
  ""
  (interactive)
  (twit-query-for-create-favourings))

;;Added by moyashi
(defun twit-destroy-status-or-favorite ()
  ""
  (interactive)
  (twit-query-for-destroy-status-or-favourings))

;;Added by moyashi
(defun twit-following-create ()
  ""
  (interactive)
  (twit-query-for-following "create"))

;;Added by moyashi
(defun twit-following-destroy ()
  ""
  (interactive)
  (twit-query-for-following "destroy"))

;;Added by moyashi
(defun twit-delete-status-winow ()
  (interactive)
  (if (one-window-p)
      (kill-buffer (current-buffer))
    (delete-window)))

;;Added by moyashi
(defun twit-jump-to-end-of-status-window ()
  (interactive)
  (progn
    (goto-char (point-max))
    (twit-backward-jump-message)
    ))

;;Added by moyashi
(defun twit-jump-to-beginning-of-status-window ()
  (interactive)
  (progn
    (goto-char (point-min))
    (twit-forward-jump-message)
    ))

;;Added by moyashi rewrited by dagezi
(defun twit-post-with-user-id ()
  (interactive)
  (save-excursion
    (beginning-of-line)
    (let* ((temp-overlay (car (overlays-in (point) (+ (point) 1))))
           user-id
           post)
      (if (overlayp temp-overlay)
          (if (setq user-id (overlay-get temp-overlay 'user-id))
              (if (setq post (twit-query-for-post (concat "@" user-id " ")))
                  (if (> (length post) twit-hard-size)
                      (error twit-too-long-msg)
                    (if (twit-post-function twit-update-url post)
                        (message twit-success-msg)))))))))

;;Added by moyashi
(defun twit-jump-message (direction)
  (let ((reg "^-+$"))
    (progn
      (if (eq direction 0)
          (progn
            (forward-line)
            (search-forward-regexp reg nil t))
        (progn
          (forward-line -1)
          (search-backward-regexp reg nil t)))
      (forward-line)
      (beginning-of-line)
      (recenter 0))
    ))

;;Added by moyashi
(defun twit-forward-jump-message ()
  (interactive)
  (twit-jump-message 0))

;;Added by moyashi
(defun twit-backward-jump-message ()
  (interactive)
  (twit-jump-message 1))

;;Added by moyashi
(defun twit-scroll-down ()
  (interactive)
  (scroll-down 1))

;;Added by moyashi
(defun twit-scroll-up ()
  (interactive)
  (scroll-up 1))

;;Added by moyashi
(defun twit-enter (arg)
  (interactive "P")
  (twit-launch arg nil))

;;Added by moyashi
(defun twit-shift-enter (arg)
  (interactive "P")
  (twit-launch arg t))

;;Added by moyashi
(defun twit-wayback-visit-history ()
  (interactive)
  (let ((current-history (twit-visit-pop-history)))
    (if (null current-history)
        (progn
          (twit-show-recent-tweets)
          (setq twit-visit-current-history nil)
          (message "visit history is empty. return to my friends page."))
      (twit-show-recent-tweets
       (first current-history)
       (second current-history)))))

;;Added by moyashi
(defun twit-launch (prefix shift)
  (let ((temp-overlay (car (overlays-in (point) (+ (point) 1))))
        (uri (get-text-property (point) 'uri))
        user-id src-url)
    (if (and (not prefix) (overlayp temp-overlay))
        (progn
          (setq user-id (overlay-get temp-overlay 'user-id))
          (setq src-url (overlay-get temp-overlay 'src-url))
          (if user-id
              (progn
                (if (not (null twit-visit-current-history))
                    (twit-visit-push-history
                     (first twit-visit-current-history)
                     (second twit-visit-current-history)))
                (twit-show-recent-tweets
                 user-id
                 (if shift "user" "friend")))
            (if src-url
                (browse-url src-url)
              )))
      (if uri
          (if (string= (substring uri 0 1) "@")
              (twit-show-recent-tweets (substring uri 1) (if shift "user" "friend"))
            (browse-url uri))))))


;;Added by moyashi
(defun twit-mouse-click ()
  (interactive)
  (twit-launch nil nil))
;;Added by amacou from twit.el(emacs wiki)
(defcustom twit-show-user-images nil
  "Show user images beside each users tweet."
  :type 'boolean
  :group 'twit)
;;Added by amacou from twit.el(emacs wiki)
(defcustom twit-user-image-dir
  (concat (car image-load-path) "twitter")
  "Directory where twitter user images are to be stored.

This directory need not be created."
  :type 'string
  :group 'twit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Misc interactive functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Added by moyashi
(defun twit-get-keyword ()
  ""
  (or (and
       transient-mark-mode
       mark-active
       (buffer-substring-no-properties
        (region-beginning) (region-end)))
      (thing-at-point 'word)))

;;Added by moyashi
;;(setq twit-search-function-use-bill t)
(defun twit-search-function ()
  ""
  (interactive)
  (let* ((prefix (if twit-search-function-use-bill
                     "http://search.live.com/results.aspx?q="
                   "http://www.google.com/search?q="))
         (postfix (if twit-search-function-use-bill "" "&ie=UTF-8&oe=UTF-8"))
         (twit-search-engine (if twit-search-function-use-bill " Live Search" " Google"))
         (keyword
          (url-hexify-string
           (read-from-minibuffer
            (concat twit-search-engine " keyword: ")
            (twit-get-keyword))))
         (url-request-data
          (concat
           prefix
           keyword
           postfix)))
    (unless (string= keyword "")
      (browse-url url-request-data))))

;;Added by moyashi
(defun twit-itunes-store-function ()
  ""
  (interactive)
  (let* ((prefix "http://phobos.apple.com/WebObjects/MZSearch.woa/wa/search?term=")
         (keyword
          (url-hexify-string
           (read-from-minibuffer
            "iTunes STORE search keyword: "
            (twit-get-keyword))))
         (url-request-data
          (concat
           prefix
           keyword)))
    (unless (string= keyword "")
      (if (numberp (string-match ".*apple.*" (version)))
          (do-applescript (concat "
tell application \"iTunes\"
open location \"itms://phobos.apple.com/WebObjects/MZSearch.woa/wa/search?term=" keyword "\"
activate
end tell"))
        (browse-url url-request-data)))))

;;Added by moyashi
(defun twit-amazon-function ()
  ""
  (interactive)
  (let* ((prefix "http://www.amazon.jp/s/?__mk_ja_JP=%83J%83%5E%83J%83i&field-keywords=")
         (postfix "&search-alias=aps")
         (keyword
          (twit-urlencode
           (read-from-minibuffer
            " Amazon search keyword: "
            (twit-get-keyword)) 'sjis))
         (url-request-data
          (concat prefix keyword postfix))
         )
    (unless (string= keyword "")
      (browse-url url-request-data))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Main functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;###autoload
(define-minor-mode twit-mode
  "Toggle twit-mode.
Globally binds some keys to Twit's interactive functions.

With no argument, this command toggles the mode.
Non-null prefix argument turns on the mode.
Null prefix argument turns off the mode.

\\{twit-mode-map}" nil
  " Twit"
  '(("\C-c\C-tw" . twit-post)
    ("\C-c\C-tr" . twit-post-region)
    ("\C-c\C-tb" . twit-post-buffer)
    ("\C-c\C-tf" . twit-list-friends)
    ("\C-c\C-tF" . twit-list-followers)
    ("\C-c\C-ts" . twit-show-recent-tweets))
  :global t
  :group 'twit
  :version twit-version-number)

(provide 'twit)

;;moyashi memo

;; (completing-read
;;  (concat "Friend name"
;;               (format " (%s)" (cdr (assq 'isd '((id "test")(isd "test2")))))
;;               ": ")
;;  '("abc" "def" "ghi") nil t)

;;put out element from association array
;;(cadr (assq 'board '((board "test")(ab "test2"))))

;;object dump as lisp source to file
;; (with-temp-file "/Users/anonymous/Desktop/twitout.txt"
;;            (let ((standard-output (current-buffer))
;;                  print-length print-level)
;;              (prin1 (cons 1 2 3))))

;; following result
;; (user nil
;;        (id nil "0000000")
;;        (name nil "name")
;;        (screen_name nil "name")
;;        (location nil "location")
;;        (description nil "description")
;;        (profile_image_url nil "http://s3.amazonaws.com/twitter_production/profile_images/00000000/picturename_normal.jpg")
;;        (url "url or nil")
;;        (protected nil "false")
;;        (status nil
;;                        (created_at nil "Thu Nov 08 10:24:33 +0000 2007")
;;                        (id nil "000000000")
;;                        (text nil "text")
;;                        (source nil "<a href=\"http://www.naan.net/trac/wiki/TwitterFox\">TwitterFox</a>")
;;                        (truncated nil "false")
;;                        )
;;        )

;; following error 1
;; (hash nil
;;        (error nil "Could not follow user: emacs is already on your list.")
;;        (request nil "/friendships/create/emacs.xml")
;;        )

;; following error 2
;; (hash nil
;;        (error nil "Could not follow user: You can't follow yourself!")
;;        (request nil "/friendships/create/hitoriblog.xml")
;;        )
