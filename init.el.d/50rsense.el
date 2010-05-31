(static-when (file-expand-wildcards "~/opt/rsense-*")
  (eval-after-load "ruby-mode"
    '(progn
       (setq rsense-home (car (file-expand-wildcards "~/opt/rsense-*")))
       (when rsense-home
         (setq rsense-home (expand-file-name rsense-home))
         (setenv "RSENSE_HOME" rsense-home)
         (add-to-list 'load-path (expand-file-name "etc" rsense-home))
         (require 'rsense)
         ))))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
