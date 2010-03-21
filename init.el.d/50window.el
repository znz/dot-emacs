;; helpなどのwindowを自動的にリサイズ
(static-when (functionp 'temp-buffer-resize-mode)
  (temp-buffer-resize-mode t))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
