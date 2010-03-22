(static-when (locate-library "w3m")
  ;; X-ML-Name: Wanderlust
  ;; X-Mail-Count: 10367
  ;; より
  (defadvice w3m-close-window (after w3m-close-window-wl-select-message activate)
    (if (and wl-current-summary-buffer
             (buffer-live-p wl-current-summary-buffer)
             (get-buffer-window wl-current-summary-buffer))
        (switch-to-buffer
         (with-current-buffer wl-current-summary-buffer
           wl-message-buffer))))
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
