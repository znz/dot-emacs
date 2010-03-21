;;; Emacs: $B%+!<%=%k$rF0$+$5$:$K%9%/%m!<%k(B
(defun my-scroll-down-1 ()
  "$B%+!<%=%k$rF0$+$5$:$K%9%/%m!<%k(B"
  (interactive)
  (scroll-down 1))
(defun my-scroll-up-1 ()
  "$B%+!<%=%k$rF0$+$5$:$K%9%/%m!<%k(B"
  (interactive)
  (scroll-up 1))
(put 'my-scroll-down-1 'unscrollable t)
(put 'my-scroll-up-1 'unscrollable t)
(define-key global-map "\M-p" 'my-scroll-down-1)
(define-key global-map "\M-n" 'my-scroll-up-1)

(setq next-screen-context-lines 10) ;; $B2hLL%9%/%m!<%k$G=EJ#I=<($5$l$k9T?t(B

;; 1$B9T$:$D%9%/%m!<%k$9$k$h$&$K$9$k!#(B
;; http://pc2.2ch.net/test/read.cgi/software/1056601345/463
(setq scroll-conservatively 35)
(setq scroll-margin 2)
(setq scroll-step 1)

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: iso-2022-7bit
;;; indent-tabs-mode: nil
;;; End:
