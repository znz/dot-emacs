;; BBDB
(static-when (and (locate-library "bbdb") (locate-library "bbdb-wl"))
  (require 'bbdb-wl)
  (setq bbdb-wl-ignore-folder-regexp "^[-$&@']\\|^\\+\\(draft\\|lost\\+found\\|outbox\\|queue\\|sent\\|trash\\)")
  (bbdb-wl-setup))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
