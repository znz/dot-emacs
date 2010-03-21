;; copyright の年や GPL のバージョンを更新
(static-when (fboundp 'copyright-update)
  (add-hook 'write-file-hooks 'copyright-update))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
