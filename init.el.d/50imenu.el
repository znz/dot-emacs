;; http://www.emacswiki.org/emacs/ImenuMode
 (defun try-to-add-imenu ()
   (condition-case nil (imenu-add-menubar-index) (error nil)))
 (add-hook 'font-lock-mode-hook 'try-to-add-imenu)

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
