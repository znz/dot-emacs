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
(defvar atdot-simple-paste-languages-alist
  '(("Plain" . "")
    ("ActionScript3" . "as3")
    ("Bash/shell" . "bash")
    ("ColdFusion" . "cf")
    ("C#" . "c-sharp")
    ("C++" . "cpp")
    ("CSS" . "css")
    ("Delphi" . "delphi")
    ("Diff" . "diff")
    ("Erlang" . "erl")
    ("Groovy" . "groovy")
    ("JavaScript" . "js")
    ("Java" . "java")
    ("JavaFX" . "jfx")
    ("Perl" . "perl")
    ("PHP" . "php")
    ("Plain Text" . "plain")
    ("PowerShell" . "ps")
    ("Python" . "py")
    ("Ruby" . "ruby")
    ("Scala" . "scala")
    ("SQL" . "sql")
    ("Visual Basic" . "vb")
    ("XML" . "xml")
    )
  ;; 「ruby -I. -r syntax_highlighter -e 'SH_LANG_NAMES.each{|k,v|puts %Q(    ("#{k}" . "#{v}"))}' | sort」で更新
  "simplepaste が language で受け付けるもの一覧")

(defun atdot-simple-paste-post ()
  "リージョンかバッファの内容を貼り付けて URL をキルリングに入れる。"
  (interactive)
  (call-interactively
   (if (and transient-mark-mode mark-active)
       'atdot-simple-paste-post-region
     'atdot-simple-paste-post-buffer)))

(defun atdot-simple-paste-post-buffer ()
  "バッファの内容を http://www.atdot.net/sp/ に貼り付けて URL をキルリングに入れる。"
  (interactive)
  (atdot-simple-paste-post-with-read
   (buffer-substring (point-min) (point-max))))

(defun atdot-simple-paste-post-region (beg end)
  "リージョンを http://www.atdot.net/sp/ に貼り付けて URL をキルリングに入れる。"
  (interactive "r")
  (atdot-simple-paste-post-with-read
   (buffer-substring beg end)))

(defun atdot-simple-paste-post-with-read (paste_body &optional args)
  "Title と Language を読み込んでから貼り付ける。"
  (let ((title (read-string "Title: " nil nil (buffer-name)))
        (language
         (cdr (assoc
               (completing-read "Language: "
                                atdot-simple-paste-languages-alist
                                nil t nil nil "Plain")
               atdot-simple-paste-languages-alist))))
    (if language
        (setq args (cons `("language" . ,language) args)))
    (if title
        (setq args (cons `("title" . ,title) args)))
    (setq args (cons `("paste_body" . ,paste_body) args))
    (atdot-simple-paste-post-internal args)))

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
