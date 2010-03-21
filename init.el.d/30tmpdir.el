;; $HOME/tmp/$USER が無ければ作成。
;; (getenv "HOME")がnilの場合も考慮して ~/tmpdir/ ではなく /tmp/ 以下にしている。
(setq temporary-file-directory
      (concat (getenv "HOME") "/tmp/emacs-" (user-login-name)))
(make-directory temporary-file-directory t)

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
