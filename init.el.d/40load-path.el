(mapc
 (lambda (path)
   (when (file-directory-p path)
     (add-to-list 'load-path path)))
 (file-expand-wildcards "~/.emacs.d/site-lisp/*"))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
