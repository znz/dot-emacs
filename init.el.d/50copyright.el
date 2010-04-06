;; copyright の年や GPL のバージョンを更新
(static-when (fboundp 'copyright-update)
  (setq copyright-names-regexp (regexp-quote user-full-name))
  (add-hook 'write-file-hooks 'copyright-update))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
