(mapc
 (lambda (path)
   (when (file-directory-p path)
     (add-to-list 'exec-path path)))
 (file-expand-wildcards "/opt/local/*bin") ; MacPorts
 )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End: