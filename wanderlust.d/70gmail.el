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

;; wl-draft-parent-folder の例:
;; "%INBOX:\"GMAIL-ADDRESS\"/clear@imap.gmail.com:993!"
;; "%[Gmail]/ゴミ箱:\"GMAIL-ADDRESS\"/clear@imap.gmail.com:993!"
(defun my-wl-gmail-address-config (name gmail-address user-name)
  (add-to-list
   'wl-draft-config-alist
   `((string-match
      (concat "\\`%.*:\""
	      ,(regexp-quote gmail-address)
	      "\"\\/clear\@imap\\.gmail\\.com\\(:993\\)?\\(!\\)?\\'")
      wl-draft-parent-folder)
     (template . ,name)
     ))
  (add-to-list
   'wl-draft-config-alist
   `(reply ,(concat "^To:.*" gmail-address)
     (template . ,name)
     ) t)
  (add-to-list
   'wl-draft-config-alist
   `(,(concat "^From: .*" gmail-address)
     (template . ,name)
     ))
  (add-to-list
   'wl-draft-config-alist
   `(,(concat "^Sender: .*" gmail-address)
     (template . ,name)
     ))
  (add-to-list
   'wl-template-alist
   `(,(concat "smtp-" name "-ssl")
     (wl-smtp-posting-server . "smtp.gmail.com")
     (wl-smtp-posting-port . 465)
     (wl-smtp-posting-user . ,gmail-address)
     (wl-smtp-authenticate-type . "plain")
     (wl-smtp-authenticate-realm . nil)
     (wl-smtp-connection-type . 'ssl)
     ) t)
  (add-to-list
   'wl-template-alist
   `(,(concat "smtp-" name "-starttls")
     (wl-smtp-posting-server . "smtp.gmail.com")
     (wl-smtp-posting-port . 587)
     (wl-smtp-posting-user . ,gmail-address)
     (wl-smtp-authenticate-type . "plain")
     (wl-smtp-authenticate-realm . nil)
     (wl-smtp-connection-type . 'starttls)
     ) t)
  (add-to-list
   'wl-template-alist
   `(,name
     (wl-from . ,gmail-address)
     ("From" . ,(concat user-name " <" gmail-address ">"))
     ("Bcc" . (wl-address-header-extract-address wl-from))
     ("Organization" . nil)
     (top . nil)
     (bottom . ,(concat "\n-- \n" user-name " <" gmail-address ">"))
     (template . ,(concat "smtp-" name "-ssl"))
     ))
  (add-to-list 'wl-user-mail-address-list gmail-address t) )

(mapc
 (lambda (x)
   (apply #'my-wl-gmail-address-config x))
 my-gmail-address-list)

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
