(when (require 'izonmoji-mode nil t)
  (add-hook 'wl-message-redisplay-hook 'izonmoji-mode-on))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
