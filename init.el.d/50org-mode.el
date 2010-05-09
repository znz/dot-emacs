;; git clone git://repo.or.cz/org-mode.git
;; cd org-mode
;; make lispdir=$HOME/.emacs.d/site-lisp/org-mode infodir=$HOME/.emacs.d/info
;; make lispdir=$HOME/.emacs.d/site-lisp/org-mode infodir=$HOME/.emacs.d/info install
(static-when (locate-library "org-install")
  (require 'org-install)
  (add-to-list 'auto-mode-alist ' ("\\.org\\'" . org-mode))

  (define-key my-prefix-map "l" 'org-store-link)
  (define-key my-prefix-map "a" 'org-agenda)
  (define-key my-prefix-map "r" 'org-remember)

  (setq org-directory "~/Org")
  (setq org-agenda-files
        (file-expand-wildcards
         (expand-file-name "*.org" org-directory)))

  (org-remember-insinuate)
  (setq org-default-notes-file
        (expand-file-name "notes.org" org-directory))
  (setq org-remember-templates
      '(("Todo" ?t "** TODO %?\n   %i\n   %a\n   %t" nil "Inbox")
        ("Bug" ?b "** TODO %?   :bug:\n   %i\n   %a\n   %t" nil "Inbox")
        ("Idea" ?i "** %?\n   %i\n   %a\n   %t" nil "New Ideas")
        ))

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
