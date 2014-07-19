(add-to-list 'my/favorite-packages 'flycheck)
(static-when (fboundp 'global-flycheck-mode)
  (add-hook 'after-init-hook #'global-flycheck-mode))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
