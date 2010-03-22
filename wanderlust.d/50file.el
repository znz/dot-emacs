(setq wl-folders-file
      (expand-file-name "dot-folders.txt" my-private-directory))
;; use LF instead of CRLF on Meadow
(modify-coding-system-alist
 'file
 (concat
  "\\`"
  (regexp-quote (expand-file-name wl-folders-file))
  "\\'")
 'iso-2022-jp-unix)

(setq mime-situation-examples-file
      (expand-file-name "mime-example.el" temporary-file-directory))
(when
    (and (not (file-exists-p mime-situation-examples-file))
         (file-exists-p "~/.mime-example"))
  (rename-file "~/.mime-example" mime-situation-examples-file))

(setq wl-address-file
      (expand-file-name "dot-addresses.txt" my-private-directory))

(setq elmo-passwd-alist-file-name "passwd.gpg")

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
