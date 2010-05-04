(defadvice navi2ch-goto-url
  (before navi2ch-cut-ime.nu activate)
  (ad-set-arg 0 (navi2ch-replace-string "//ime\\.nu/" "//"  (ad-get-arg 0))))
(defadvice navi2ch-browse-url
  (before navi2ch-cut-ime.nu activate)
  (ad-set-arg 0 (navi2ch-replace-string "//ime\\.nu/" "//"  (ad-get-arg 0))))
(defadvice navi2ch-article-select-current-link-url
  (before navi2ch-cut-ime.nu activate)
  (ad-set-arg 0 (navi2ch-replace-string "//ime\\.nu/" "//"  (ad-get-arg 0))))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
