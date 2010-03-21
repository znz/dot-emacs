;; navi2ch
(static-when
    (and
     (file-directory-p "~/.navi2ch")
     (locate-library "navi2ch"))
  (setq navi2ch-init-file "~/.emacs.d/dot-navi2ch")
  (eval-after-load "navi2ch" '(my-byte-compile-file navi2ch-init-file))
  (autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t nil))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
