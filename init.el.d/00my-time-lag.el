;; 起動速度を調べる (99my-time-lag.el も参照)
;; http://www.bookshelf.jp/pukiwiki/pukiwiki.php?%B5%AF%C6%B0%C2%AE%C5%D9
(defun my-time-lag ()
  (let* ((now (current-time))
         (min (- (car now) (car my-time-zero)))
         (sec (- (car (cdr now)) (car (cdr my-time-zero))))
         (msec (/ (- (car (cdr (cdr now)))
                     (car (cdr (cdr my-time-zero))))
                  1000))
         (lag (+ (* 60000 min) (* 1000 sec) msec)))
    (message "'.emacs.el' loading time: %d msec." lag)))
(setq my-time-zero (current-time))
;; 起動処理全体の時間は (emacs-init-time)

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
