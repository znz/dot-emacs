;; mona font
(when (<= emacs-major-version 21)
  (setq navi2ch-mona-enable t)
  (when (eq window-system 'w32)
    (add-hook
     'navi2ch-mona-load-hook
     (lambda ()
       (set-face-attribute 'navi2ch-mona-face nil :family "ＭＳ Ｐゴシック"))))
  (setq navi2ch-mona-disable-board-list '("unix" "linux" "network"))
  (require 'navi2ch-mona))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
