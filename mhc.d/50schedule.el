(defun my-mhc-schedule-file (dot-schedule-files)
  (let ((dot-schedule (expand-file-name (car dot-schedule-files))))
     (if (file-exists-p dot-schedule)
         (setq mhc-schedule-file dot-schedule)
       (my-mhc-schedule-file (cdr dot-schedule-files)))))

(my-mhc-schedule-file
 (list
  (expand-file-name "~/.schedule") ; default of mhc-vars.el
  (expand-file-name "DOT.schedule.sample.jp" user-emacs-directory)
  "/usr/share/doc/mhc/examples/DOT.schedule.sample.jp"))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
