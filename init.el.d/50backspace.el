;; C-hもBackSpaceも同じ挙動にする。
(keyboard-translate ?\C-h ?\C-?)  ; translate `C-h' to DEL
;;(keyboard-translate ?\C-? ?\C-h)  ; translate DEL to `C-h'.

;; 1 回の delete-backward-char で複数の whitespace を消したい
;; http://www.fan.gr.jp/~ring/Meadow/meadow.html#backward-delete-char-untabify-method
(setq backward-delete-char-untabify-method 'hungry)

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
