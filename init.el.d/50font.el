(static-cond
 ((= emacs-major-version 23)
  (when (eq window-system 'x)
    (set-frame-font "Monospace 12")
    (set-fontset-font (frame-parameter nil 'font)
                      'japanese-jisx0208
                      '("VL Gothic 12" . "unicode-bmp"))
    (set-fontset-font (frame-parameter nil 'font)
                      'katakana-jisx0201
                      '("VL Gothic 12" . "unicode-bmp"))
    (set-fontset-font (frame-parameter nil 'font)
                      'ascii
                      '("VL Gothic 12" . "unicode-bmp"))
    (set-fontset-font (frame-parameter nil 'font)
                      'unicode
                      '("VL Gothic 12" . "unicode-bmp"))
    )))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
