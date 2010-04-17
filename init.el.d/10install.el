(setq auto-install-directory "~/.emacs.d/elisp/")
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
