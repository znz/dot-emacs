(static-when (fboundp 'server-start)
  (require 'server)
  (if (and (fboundp 'server-running-p)
           (not (server-running-p)))
      (server-start)))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
