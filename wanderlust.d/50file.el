(static-when (file-directory-p "~/.emacs.d/icons/wl")
  (setq wl-icon-directory "~/.emacs.d/icons/wl"))

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
(static-when
    (and (not (file-exists-p mime-situation-examples-file))
         (file-exists-p "~/.mime-example"))
  (rename-file "~/.mime-example" mime-situation-examples-file))

(setq wl-address-file
      (expand-file-name "dot-addresses.txt" my-private-directory))

(setq elmo-passwd-alist-file-name
      (expand-file-name "passwd.gpg" my-private-directory))
