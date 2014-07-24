(let ((gls (executable-find "gls")))
  (when gls
    (setq insert-directory-program gls)))
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
