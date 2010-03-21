;; M-x customize RETで行うカスタマイズの設定ファイルを.emacsとは別にする。
(setq custom-file
      (concat "~/.emacs.d/custom-" my-flavor ".el"))

(when (file-exists-p custom-file)
  (my-byte-compile-file custom-file)
  (load custom-file))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
