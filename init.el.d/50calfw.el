(when (locate-library "calfw")
  (eval-after-load "calfw"
    '(progn
       (define-key cfw:calendar-mode-map "q"
         '(lambda () (interactive) (kill-buffer nil)))
       )))

(static-when (locate-library "calfw-ical")
  (defun my-cfw-open-IT勉強会カレンダー ()
    (interactive)
    (require 'calfw-ical)
    (cfw:open-ical-calendar
     "http://www.google.com/calendar/ical/fvijvohm91uifvd9hratehf65k%40group.calendar.google.com/public/basic.ics"))
  (define-key my-prefix-map "I" 'my-cfw-open-IT勉強会カレンダー)
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
