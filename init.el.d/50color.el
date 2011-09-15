;; M-x color-theme-select で試して選べばいい。
(when (require 'color-theme nil t)
  (when (fboundp 'color-theme-initialize)
    (color-theme-initialize))
  (color-theme-dark-laptop))

(when (require 'develock nil t)
  (plist-put develock-max-column-plist 'ruby-mode 'w)
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
