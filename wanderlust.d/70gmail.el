(static-when t
  (defun my-wl-folder-set-if-exist (var folders rest)
    (make-local-variable var)
    (dolist (fld folders)
      (let ((folder (concat fld rest)))
        (when (elmo-folder-exists-p (wl-folder-get-elmo-folder folder))
          (set var folder))
        ))
    )
  (defun my-wl-gmail-folder-updater ()
    (cond
     ((string-match
       ":\"\\([^\"]+\\)\"\\/clear\@imap.gmail.com\\(:993\\)?\\(!\\)?\\'"
       wl-summary-buffer-folder-name)
      (let ((gmail (match-string 0 wl-summary-buffer-folder-name)))
        (my-wl-folder-set-if-exist
         'wl-spam-folder
         '("%[Gmail]/Spam"
           "%[Gmail]/迷惑メール")
         gmail)
        (my-wl-folder-set-if-exist
         'wl-draft-folder
         '("%[Gmail]/Drafts"
           "%[Gmail]/下書き")
         gmail)
        (my-wl-folder-set-if-exist
         'wl-trash-folder
         '("%[Gmail]/Trash"
           "%[Gmail]/ゴミ箱")
         gmail)
        ))
     ))
  (add-hook 'wl-summary-prepared-hook 'my-wl-gmail-folder-updater)

  (add-to-list 'wl-dispose-folder-alist
               '("^%INBOX:.*@imap\\.gmail\\.com" . remove))
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
