(add-hook
 'c-mode-common-hook
 (function
  (lambda ()
    (make-local-variable 'tab-width)
    (make-local-variable 'indent-tabs-mode)
    (setq tab-width 4)
    (setq indent-tabs-mode t)
    (require 'ruby-style)
    ;;(ruby-style-c-mode)
    (c-set-style "ruby")
    )))

(setq c-style-variables-are-local-p t)

(static-when (fboundp 'global-cwarn-mode)
  (global-cwarn-mode 1))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
