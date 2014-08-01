;; http://pc.2ch.net/test/read.cgi/unix/1065246418/383
(defun my-navi2ch-article-show-matched-filter ()
  "レスに合致したフィルタ条件を表示する。"
  (interactive)
  (let ((name (navi2ch-article-get-current-name))
        (mail (navi2ch-article-get-current-mail))
        (id (navi2ch-article-get-current-id))
        (message (navi2ch-article-get-message-string
                  (navi2ch-article-get-current-number)))
        (print-escape-newlines t)
        pattern)
    (with-output-to-temp-buffer "*matched filter*"
      (dolist (element '(name mail id message))
        (let ((elm (eval element))
              (alist (eval (intern
                            (concat "navi2ch-article-message-filter-by-"
                                    (symbol-name element)
                                    "-alist")))))
          (when (and elm alist)
            (dolist (filter alist)
              (when (listp (setq pattern (car filter)))
                (setq pattern (car pattern)))
              (when (string-match pattern elm)
                (prin1 element)
                (princ ": ")
                (prin1 filter)
                (princ "\n")))))))))
;; http://pc.2ch.net/test/read.cgi/unix/1065246418/393
;(define-key navi2ch-article-mode-map "\C-c\C-d" 'my-navi2ch-article-show-matched-filter)
