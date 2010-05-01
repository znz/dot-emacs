(setq auto-install-directory "~/.emacs.d/elisp/")
;; (make-directory auto-install-directory)
;; (shell-command-to-string (concat "cd " auto-install-directory " && wget -N http://www.emacswiki.org/emacs/download/auto-install.el"))
;; (shell-command-to-string (concat "cd " auto-install-directory " && curl -O http://www.emacswiki.org/emacs/download/auto-install.el"))
;; (byte-compile-file (expand-file-name "auto-install.el" auto-install-directory))
(static-when (file-directory-p auto-install-directory)
  (add-to-list 'load-path auto-install-directory)
  (require 'auto-install)
  ;;(auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup) ; 互換性確保
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
