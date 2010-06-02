(defvar my-font nil)
(static-cond
 ((file-exists-p "/usr/share/fonts/truetype/vlgothic/VL-Gothic-Regular.ttf")
  (setq my-font "VL Gothic"))
 ((eq window-system 'ns)
  (setq mac-allow-anti-aliasing t)
  (set-fontset-font
   (frame-parameter nil 'font)
   'japanese-jisx0208
   '("Hiragino Maru Gothic Pro" . "iso10646-1"))
  (setq face-font-rescale-alist
	'(("^-apple-hiragino.*" . 1.2)
	  (".*osaka-bold.*" . 1.2)
	  (".*osaka-medium.*" . 1.2)
	  (".*courier-bold-.*-mac-roman" . 1.0)
	  (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
	  (".*monaco-bold-.*-mac-roman" . 0.9)
	  ("-cdac$" . 1.3)))
  (setq my-font "Monaco"))
 )
(when my-font
  (static-if (fboundp 'set-frame-font)
      (set-frame-font my-font)
    (set-default-font my-font))
  (add-to-list 'default-frame-alist `(font . ,my-font))
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
