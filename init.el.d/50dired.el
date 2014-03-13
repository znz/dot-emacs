(let ((gls (executable-find "gls")))
  (when gls
    (setq insert-directory-program gls)))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
