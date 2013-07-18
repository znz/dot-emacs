(defvar my-font nil)
(static-cond
 ;((file-exists-p "~/.fonts/Ricty-Regular.ttf")
 ; (setq my-font "ricty-12"))
 ((file-exists-p "/usr/share/fonts/truetype/vlgothic/VL-Gothic-Regular.ttf")
  (setq my-font "VL Gothic"))
 ((or (file-exists-p "~/.fonts/Ricty-Regular.ttf")
      (file-exists-p "~/Library/Fonts/Ricty-Regular.ttf"))
  (set-face-attribute 'default nil
                      :family "Ricty"
                      :height 160)
  (set-fontset-font (frame-parameter nil 'font)
                    'japanese-jisx0208
                    (cons "Ricty" "iso10646-1"))
  (set-fontset-font (frame-parameter nil 'font)
                    'japanese-jisx0212
                    (cons "Ricty" "iso10646-1"))
  (set-fontset-font (frame-parameter nil 'font)
                    'katakana-jisx0201
                    (cons "Ricty" "iso10646-1"))
  )
 ((eq window-system 'ns)
  (setq mac-allow-anti-aliasing t)
  (set-face-attribute 'default nil
                      :family "monaco"
                      :height 140)
  (set-fontset-font
   (frame-parameter nil 'font)
   'japanese-jisx0208
   '("Hiragino Maru Gothic Pro" . "iso10646-1"))
  (set-fontset-font
   (frame-parameter nil 'font)
   'japanese-jisx0212
   '("Hiragino Maru Gothic Pro" . "iso10646-1"))
  (set-fontset-font
   (frame-parameter nil 'font)
   'mule-unicode-0100-24ff
   '("monaco" . "iso10646-1"))
  (setq face-font-rescale-alist
	'(("^-apple-hiragino.*" . 1.2)
	  (".*osaka-bold.*" . 1.2)
	  (".*osaka-medium.*" . 1.2)
	  (".*courier-bold-.*-mac-roman" . 1.0)
	  (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
	  (".*monaco-bold-.*-mac-roman" . 0.9)
	  ("-cdac$" . 1.3)))
  )
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
