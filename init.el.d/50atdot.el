(require 'url)

(defvar atdot-simple-paste-auto-commit-terminator
  "http://www.atdot.net/sp/view/"
  "sp/commit/autoが必ず返す文字列の一部")
(defvar atdot-simple-paste-auto-commit-url
  "http://www.atdot.net/sp/commit/auto"
  "sp/commit/autoのURL")
(defvar atdot-simple-paste-auto-commit-result-regexp
  "http://www\\.atdot\\.net/sp/view/[a-z0-9]+"
  "sp/commit/autoでpasteした結果を表示するためのURLを取り出す正規表現")

(defun atdot-simple-paste-post-region (beg end)
  "リージョンを http://www.atdot.net/sp/ に貼り付ける。"
  (interactive "r")
  (atdot-simple-paste-post-internal
   `(("paste_body" . ,(buffer-substring beg end))) ))

(defun atdot-simple-paste-post-internal (args)
  (let ((url-request-method "POST")
	(url-request-extra-headers
	 '(("Content-Type" . "application/x-www-form-urlencoded")))
	(url-request-data
	 (mapconcat (lambda (arg)
		      (concat (url-hexify-string (car arg))
			      "="
			      (url-hexify-string (cdr arg))))
		    args
		    "&")))
    (url-retrieve atdot-simple-paste-auto-commit-url
		  'atdot-simple-paste-parse-url-buffer)
    ))

(defun atdot-simple-paste-parse-url-buffer (status)
  (kill-new
   (save-excursion
     ;;(switch-to-buffer (current-buffer))
     (goto-char (point-min))
     (if (re-search-forward atdot-simple-paste-auto-commit-result-regexp
			    nil t)
	 (match-string 0)
       (error "Paste failed."))))
   (message "Pasted to <%s>" (car kill-ring)))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
