;; bbstable の URL。
;(setq navi2ch-list-bbstable-url "http://menu.2ch.net/bbsmenu.html")

;; 板一覧に板IDを表示する。
(setq navi2ch-list-display-board-id-p t)

;;; http://pc8.2ch.net/test/read.cgi/unix/1106152504/718
;; (dolist (ita '("avi" "blog" "bsoft" "cdr" "cg" "db" "desktop" "dtm"
;;                "esite" "friend" "gamedev" "hack" "hard" "hosting" "hp"
;;                "internet" "isp" "jobs" "linux" "mmag" "mobile" "mysv"
;;                "network" "nifty" "nntp" "os" "pc" "pcnews" "pcqa"
;;                "php" "printer" "prog" "sec" "sns" "software" "swf"
;;                "tech" "unix" "win"))
;;   (add-to-list 'navi2ch-list-moved-board-alist
;;                (cons (format "http://pc5.2ch.net/%s/" ita)
;;                      (format "http://pc8.2ch.net/%s/" ita))))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
