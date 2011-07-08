;; (auto-install-from-url "http://www.meadowy.org/meadow/netinstall/export/799/branches/3.00/pkginfo/japanese-holidays/japanese-holidays.el")
(static-when (locate-library "japanese-holidays")
  (add-hook
   'calendar-load-hook
   (lambda ()
     (require 'japanese-holidays)
     (setq calendar-holidays
           (append japanese-holidays local-holidays other-holidays))
     )))

(static-when (locate-library "calfw")
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
