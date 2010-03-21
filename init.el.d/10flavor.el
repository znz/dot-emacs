;; initz-flavorより。
(defconst my-flavor
  (if (featurep 'xemacs)
      (concat "xemacs" (number-to-string emacs-major-version))
    (static-if (featurep 'meadow)
        (concat "meadow"
                (let ((mver (Meadow-version)))
                  (if (string-match "Meadow-\\([0-9]+\\.[0-9]+\\)"
                                    mver)
                      (match-string 1 mver))))
      (concat "emacs" (number-to-string emacs-major-version)))))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
