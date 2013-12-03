(static-when (locate-library "js2-mode")
  (defun my-js2-mode-hook ()
    (setq js2-basic-offset 2)
    (setq js-indent-level 2)
    (setq indent-tabs-mode nil))
  (add-hook 'js2-mode-hook 'my-js2-mode-hook))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
