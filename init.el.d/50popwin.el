;; (auto-install-from-url "https://github.com/m2ym/popwin-el/raw/master/popwin.el")

(when (require 'popwin nil t)
  (setq display-buffer-function 'popwin:display-buffer))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End: