;; M-x color-theme-select で試して選べばいい。
(when (require 'color-theme nil t)
  (when (fboundp 'color-theme-initialize)
    (color-theme-initialize))
  (color-theme-dark-laptop))

;; http://www.jpl.org/ftp/pub/elisp/develock.el.gz
(when (require 'develock nil t)
  (plist-put develock-max-column-plist 'change-log-mode 79)
  ;; leading 2 or more tabs
  (setcdr
   (assoc "^\\([\t ][\t ]+\\)[^\t\n]" develock-change-log-font-lock-keywords)
   '(1 (if (and (eq (char-after (develock-point-at-bol)) ?\t)
                (not (= (- (match-end 1) (match-beginning 1) 1)
                        change-log-indent-text)))
           'develock-whitespace-2)))

  (plist-put develock-max-column-plist 'ruby-mode 'w)
  (custom-set-variables
   '(develock-mode-strings
     (list (propertize
            "D"
            'face '(develock-mode :background "black" :foreground "ForestGreen"))
           (propertize
            "F"
            'face '(develock-mode :background "black" :foreground "DarkGoldenRod"))))
   )
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
