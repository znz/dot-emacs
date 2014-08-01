(add-to-list 'my/favorite-packages 'org)

;; git clone git://repo.or.cz/org-mode.git
;; cd org-mode
;; make lispdir=$HOME/.emacs.d/site-lisp/org-mode infodir=$HOME/.emacs.d/info
;; make lispdir=$HOME/.emacs.d/site-lisp/org-mode infodir=$HOME/.emacs.d/info install
(static-when (locate-library "org-install")
  (require 'org-install)
  (add-to-list 'auto-mode-alist ' ("\\.org\\'" . org-mode))

  (setq my-org-prefix-map (make-keymap))
  (define-key my-prefix-map "o" my-org-prefix-map)

  (define-key my-org-prefix-map "l" 'org-store-link)
  (define-key my-org-prefix-map "c" 'org-capture)
  (define-key my-org-prefix-map "a" 'org-agenda)
  (define-key my-org-prefix-map "b" 'org-iswitchb)
  (define-key my-org-prefix-map "r" 'org-remember)

  (setq org-special-ctrl-a/e t)

  (setq org-directory "~/Org")
  (setq org-agenda-files
        (file-expand-wildcards
         (expand-file-name "*.org" org-directory)))
  (setq org-agenda-files
        (append
         org-agenda-files
         (file-expand-wildcards
          (expand-file-name "*/*/todo.org" howm-directory))))

  ;(org-remember-insinuate)
  (setq org-default-notes-file
        (expand-file-name "notes.org" org-directory))
  (let* ((body "\n   %i\n   %a\n   Added: %U")
         (note (concat "** %?" body)))
    (setq org-remember-templates
          `(("Todo" ?t
             ,(concat "** TODO %?" body)
             "newgtd.org" "Inbox")
            ("Bug" ?b
             ,(concat "** TODO %?   :bug:" body)
             "newgtd.org" "Inbox")
            ("Work" ?w
             ,(concat "** TODO %?   :work:" body)
             "newgtd.org" "Inbox")
            ("Home" ?h
             ,(concat "** TODO %?   :home:" body)
             "newgtd.org" "Inbox")

            ("Event" ?e ,note "schedule.org" "Events")
            ("Scheduling" ?s ,note "schedule.org" "Tasks")

            ("Memo" ?m ,note nil "Memo")
            ("Idea" ?i ,note nil "New Ideas")
            ("GoodThing" ?g ,note nil "Good Things")
            )))

  (setq org-log-done 'time)
  (setq org-startup-folded nil)
  (setq org-startup-truncated nil)

  (setq org-export-latex-coding-system 'euc-jp-unix)
  (setq org-export-latex-date-format "%Y-%m-%d")
  (setq org-latex-to-pdf-process
        '("cd %o && { find -name '*.png' -exec ebb '{}' +; } && platex %b && platex %b && dvipdfmx %b"
          "cd %o && { find -name '*.png' -exec ebb '{}' +; } && platex %b && platex %b && dvipdfmx %b"
          ))

  (static-when (file-exists-p "~/.emacs.d/site-lisp/org-mode/ditaa.jar")
    (setq org-ditaa-jar-path "~/.emacs.d/site-lisp/org-mode/ditaa.jar"))

  (static-when (file-exists-p "~/.emacs.d/site-lisp/org-mode/plantuml.jar")
    (setq org-plantuml-jar-path"~/.emacs.d/site-lisp/org-mode/plantuml.jar")
    (require 'ob-plantuml))

  (defadvice org-insert-time-stamp (around time-locale-set-C activate)
    (let ((system-time-locale "C"))
      ad-do-it))
  (defadvice org-remember-apply-template (around time-locale-set-C activate)
    (let ((system-time-locale "C"))
      ad-do-it))

  (when (fboundp 'org-babel-do-load-languages)
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((dot . t)))
    )

  (defun my-org-confirm-babel-evaluate (lang body)
    (not (string= lang "dot")))  ; don't ask for dot
  ;(setq org-confirm-babel-evaluate t)
  (setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)

  )
