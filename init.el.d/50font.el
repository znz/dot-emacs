(defvar my-font nil)
(static-cond
 ((file-exists-p "/usr/share/fonts/truetype/vlgothic/VL-Gothic-Regular.ttf")
  (setq my-font "VL Gothic"))
 )
(when my-font
  (set-default-font my-font)
  (add-to-list 'default-frame-alist `(font . ,my-font))
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
