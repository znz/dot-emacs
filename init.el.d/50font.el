(static-when
    (file-exists-p
     "/usr/share/fonts/truetype/vlgothic/VL-Gothic-Regular.ttf")
  (let ((font "VL Gothic"))
    (set-default-font font)
    (add-to-list 'default-frame-alist `(font . ,font))
    ))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
