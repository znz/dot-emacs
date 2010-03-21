(static-when (locate-library "riece")
  (setq riece-variables-file "~/.emacs.d/dot-riece")
  (eval-after-load "riece" '(my-byte-compile-file riece-variables-file))
  (autoload 'riece "riece" "Start Riece" t))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
