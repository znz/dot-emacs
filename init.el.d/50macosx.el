(static-when (eq window-system 'ns)
  (static-when (assoc "MacOSX" input-method-alist)
    ;; ime inline patch
    (setq default-input-method "MacOSX")
    (mac-translate-from-yen-to-backslash)
    )
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
