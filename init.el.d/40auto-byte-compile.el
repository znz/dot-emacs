;; skk-byte-compile-init-file を元に作成。
(defun my-byte-compile-file (elisp-file)
  (save-match-data
    (let* ((file (expand-file-name elisp-file))
           (init-file (if (file-exists-p (concat file ".el"))
                          (concat file ".el")
                        file))
           (elc (concat init-file
                        (if (string-match "\\.el$" init-file)
                            "c"
                          ".elc"))))
      (when (and (file-exists-p init-file)
                 (or (not (file-exists-p elc))
                     (file-newer-than-file-p init-file elc)))
        (save-window-excursion
          (message "Byte-compile %s" elisp-file)
          (sit-for 2)
          (byte-compile-file init-file)))
      )))

(eval-after-load "mhc" '(my-byte-compile-file my-dot-mhc-file))
(eval-after-load "navi2ch" '(my-byte-compile-file navi2ch-init-file))
(eval-after-load "riece" '(my-byte-compile-file riece-variables-file))
(eval-after-load "w3m" '(my-byte-compile-file w3m-init-file))
(eval-after-load "wl" '(my-byte-compile-file wl-init-file))
(eval-when-compile
  (add-hook 'after-init-hook
            (lambda ()
	      ;;(my-byte-compile-file "~/.emacs.d/emacs.el")
              (my-byte-compile-file "~/.emacs.d/init")
              )))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
