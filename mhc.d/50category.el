(let* ((now (decode-time (current-time)))
       (dow (nth 6 now)) ; day of week
       ;;(year (nth 5 now))
       ;;(month (nth 4 now))
       ;;(day (nth 3 now))
       (hour (nth 2 now))
       ;;(minute (nth 1 now))
       ;;(sec (nth 0 now))
       )
  (setq my-holiday (or (memq dow '(0 6))
                       (< hour 10)
                       (< 22 hour))))
;;(setq mhc-default-network-status my-holiday)
;;(setq mhc-default-network-status nil) ;; my private cvs server down
(unless my-holiday
  ;;(setq mhc-default-category "holiday || work || off"))
  (setq mhc-default-category "!private"))

(setq mhc-category-face-alist
      '(
        ("Work"      . (bold "black"  "white"))  ;; お仕事一般
        ("Lecture"   . (nil  "black"  "gray"))   ;; 講議
        ("Seminar"   . (nil  "black"  "orange")) ;; ゼミ
        ("Party"     . (nil  "brown"  "pink"))   ;; 宴会
        ("Gomi"      . (nil  "yellow" nil))      ;; ごみ収集日
        ("Private"   . (nil  "tan"    nil))      ;; プライベート
        ))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
