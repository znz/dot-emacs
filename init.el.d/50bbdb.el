;; BBDB
(static-when (require 'bbdb nil t)
  (setq bbdb-file (expand-file-name "_bbdb.el" user-emacs-directory))
  (setq bbdb-north-american-phone-numbers-p nil)
  (setq bbdb-use-pop-up nil)
  (setq bbdb-pop-up-target-lines 3)
  (setq bbdb-offer-save 'savenoprompt)
  (setq bbdb-quiet-about-name-mismatches t)
  (setq bbdb/mail-auto-create-p 'bbdb-ignore-some-messages-hook)
  (setq bbdb-ignore-some-messages-alist
        '(("From" . "no.?reply\\|DAEMON\\|daemon\\|root\\|master\\|admin\\|info\\|log\\|arpwatch")
          ("To" . "DAEMON\\|daemon\\|root\\|master\\|admin\\|info\\|log\\|arpwatch")))
  (add-hook 'bbdb-notice-hook 'bbdb-auto-notes-hook)
  (setq bbdb-auto-notes-alist
        '(("X-ML-Name" (".*$" ML 0))
          ("X-Mailing-List" (".*$" ML 0))
          ("X-Sequence" ("^\\([^ ]+\\) \\([0-9]+\\)$" ML 1))
          ("List-Id" ("<\\([^<>]+\\)>" ML 1))
          ("X-URL" (".*" www 0))
          ("X-URI" (".*" www 0))
          ("Organization" (".*" Organization 0))
          ("Newsgroup" ("[^,]+" newsgroups 0))
          ("X-Mailer" (".*$" User-Agent 0))
          ("X-Newsreader" (".*$" User-Agent 0))
          ("User-Agent" (".*$" User-Agent 0))
          ))
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
