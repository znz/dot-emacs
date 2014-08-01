(defun my-gd-folder (folder)
  (concat "%" folder ":nisiyama/clear" "@" "mx3." "good-day.co.jp" ":993!"))
(defun my-zn-mbf-folder (folder)
  (concat "%INBOX." folder
          ":" "\"" "zn" "@" "mbf.nifty.com" "\""
          "/clear"
          "@" "imap.nifty.com" ":993!"))

;(setq wl-refile-rule-alist nil)
(add-to-list
 'wl-refile-rule-alist
 `("user-agent"
   ("caff" .
    ("to"
     ("@good-day\\.co\\.jp" . ,(my-gd-folder "caff"))
     ("zn\@mbf\\.nifty\\.com" . ,(my-zn-mbf-folder "_tmp.caff"))
     ))))

;; ML
(add-to-list
 'wl-refile-rule-alist
 `("x-ml-name"
   ("\\([A-Za-z0-9][A-Za-z0-9_-]*[A-Za-z0-9]\\)" .
    ,(my-zn-mbf-folder "ML"))
   ))
(add-to-list
 'wl-refile-rule-alist
 `("list-post"
   ("<mailto:\\([A-Za-z0-9][A-Za-z0-9._-]*[A-Za-z0-9]\\)@\\([A-Za-z0-9][A-Za-z0-9.-]*[A-Za-z0-9]\\)>" .
    ,(my-zn-mbf-folder "ML"))
   ))

(add-to-list
 'wl-refile-rule-alist
 `("x-mailer"
   ("tDiary" .
    ("to"
     ("@good-day\\.co\\.jp" . ,(my-gd-folder "tdiary"))
     ))))
