;; BBDB
(static-when (require 'bbdb nil t)
  (setq bbdb-file (expand-file-name "_bbdb.el" user-emacs-directory))
  (setq bbdb-north-american-phone-numbers-p nil)
  (setq bbdb-use-pop-up nil)
  (setq bbdb-pop-up-target-lines 3)
  (setq bbdb-offer-save 'savenoprompt)
  (setq bbdb/mail-auto-create-p 'bbdb-ignore-some-messages-hook)
  (setq bbdb-ignore-some-messages-alist
        '(( "From" . "no.?reply\\|DAEMON\\|[Dd]aemon\\|root\\|logcheck\\|[Aa]rpwatch")))
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
