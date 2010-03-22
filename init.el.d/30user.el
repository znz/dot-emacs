(defconst my-user-full-name user-full-name
  "元のuser-full-name")
(setq user-full-name "Kazuhiro NISHIYAMA")
(defconst my-user-mail-address user-mail-address
  "元のuser-mail-address")
(setq user-mail-address
      (or (getenv "EMAIL")
          "zn\@mbf.nifty.com"))

(defconst my-private-directory
  "~/.emacs.d/private")

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
