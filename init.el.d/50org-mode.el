;; git clone git://repo.or.cz/org-mode.git
;; cd org-mode
;; make lispdir=$HOME/.emacs.d/site-lisp/org-mode infodir=$HOME/.emacs.d/info
;; make lispdir=$HOME/.emacs.d/site-lisp/org-mode infodir=$HOME/.emacs.d/info install
(static-when (locate-library "org-install")
  (require 'org-install)
  (add-to-list 'auto-mode-alist ' ("\\.org\\'" . org-mode))
  (define-key my-prefix-map "l" 'org-store-link)
  (define-key my-prefix-map "a" 'org-agenda)
  (setq org-agenda-files (file-expand-wildcards "~/Org/*.org"))

  (setq org-log-done t)
  (setq org-startup-truncated nil)

  (defadvice org-insert-time-stamp (around time-locale-set-C activate)
    (let ((system-time-locale "C"))
      ad-do-it))
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
