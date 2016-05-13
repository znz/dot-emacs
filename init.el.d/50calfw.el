(add-to-list 'my/favorite-packages 'japanese-holidays)
(static-when (locate-library "japanese-holidays")
  (add-hook
   'calendar-load-hook
   (lambda ()
     (require 'japanese-holidays)
     (setq calendar-holidays ; 他の国の祝日も表示させたい場合は適当に調整
           (append japanese-holidays holiday-local-holidays holiday-other-holidays))
     (setq calendar-mark-holidays-flag t) ; 祝日をカレンダーに表示
     ;; 土曜日・日曜日を祝日として表示する場合、以下の設定を追加します。
     ;; 変数はデフォルトで設定済み
     (setq japanese-holiday-weekend '(0 6)     ; 土日を祝日として表示
           japanese-holiday-weekend-marker     ; 土曜日を水色で表示
           '(holiday nil nil nil nil nil japanese-holiday-saturday))
     (add-hook 'calendar-today-visible-hook 'japanese-holiday-mark-weekend)
     (add-hook 'calendar-today-invisible-hook 'japanese-holiday-mark-weekend)
     ;; “きょう”をマークするには以下の設定を追加します。
     (add-hook 'calendar-today-visible-hook 'calendar-mark-today)
     )))

(add-to-list 'my/favorite-packages 'calfw)
(static-when (locate-library "calfw")
  (autoload 'cfw:open-calendar-buffer "calfw" nil t))

(static-when (locate-library "calfw-ical")
  (autoload 'cfw:open-ical-calendar "calfw-ical" nil t)
  (defun my-cfw-open-IT勉強会カレンダー ()
    (interactive)
    (cfw:open-ical-calendar
     "http://www.google.com/calendar/ical/fvijvohm91uifvd9hratehf65k%40group.calendar.google.com/public/basic.ics"))
  ;(define-key my-prefix-map "I" 'my-cfw-open-IT勉強会カレンダー)
  )

;;(auto-install-from-url "https://raw.github.com/kiwanami/emacs-calfw/master/calfw-org.el")
(static-when (locate-library "calfw-org")
  (autoload 'cfw:open-org-calendar "calfw-org" nil t)
  ;(define-key my-prefix-map "C" 'cfw:open-org-calendar)
  )
