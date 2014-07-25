(add-to-list 'my/favorite-packages 'scss-mode)
(when (require 'scss-mode nil t)
  (setq scss-compile-at-save nil)
  (add-hook 'scss-mode-hook #'my-scss-mode-hook)
  )
(defun my-scss-mode-hook ()
  (set (make-local-variable 'css-indent-offset) 2)
  (flymake-mode -1) ; do not use flymake (default)
  (flycheck-mode -1) ; do not use flycheck (default) and avoid to create .sass-cache/
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
