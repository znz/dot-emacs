;; copyright の年や GPL のバージョンを更新
(static-when (fboundp 'copyright-update)
  ;; 自作のものだけ更新する。
  (setq copyright-names-regexp (regexp-quote user-full-name))
  ;; GPL のバージョンはいじらない。
  (defadvice copyright-update (around force-physical-line activate)
    (let ((copyright-current-gpl-version nil))
      ad-do-it))
  (add-hook 'write-file-hooks 'copyright-update))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
