(defun my-gd-folder (folder)
  (concat "%" folder ":nisiyama/clear" "@" "mx3." "good-day.co.jp" ":993!"))
(defun my-zn-mbf-folder (folder)
  (concat "%INBOX.zn_mbf." folder ":z" "@" "mx2." "n-z.jp" ":993!"))

;(setq wl-refile-rule-alist nil)
(add-to-list
 'wl-refile-rule-alist
 `("user-agent"
   ("caff" .
    ("to"
     ("@good-day\\.co\\.jp" . ,(my-gd-folder "caff"))
     ("zn\@mbf\\.nifty\\.com" . ,(my-zn-mbf-folder "_tmp.caff"))
     ))))
(add-to-list
 'wl-refile-rule-alist
 `("x-mailer"
   ("tDiary" .
    ("to"
     ("@good-day\\.co\\.jp" . ,(my-gd-folder "tdiary"))
     ))))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
