(static-when (fboundp 'turn-on-eldoc-mode)
  (add-hook 'emacs-lisp-mode-hook  'turn-on-eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
