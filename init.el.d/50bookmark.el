(setq bookmark-default-file
      (expand-file-name "_emacs.bmk" user-emacs-directory))

(defadvice bookmark-set (around bookmark-set-ad activate)
  ;; 登録前に最新のブックマークを読み直す
  (when (file-exists-p bookmark-default-file)
    (bookmark-load bookmark-default-file t t))
  ad-do-it
  (bookmark-save))

(defadvice bookmark-jump (before bookmark-set-ad activate)
  (when (file-exists-p bookmark-default-file)
    (bookmark-load bookmark-default-file t t)))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
