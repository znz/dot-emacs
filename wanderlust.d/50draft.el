;; Folder Carbon Copy
(setq wl-fcc "+outbox")
(setq wl-draft-folder "+draft")

;; Bccを自動的につけない
(setq mail-self-blind nil)

;; 送信前に確認する
(setq wl-interactive-send t)

;;; http://lists.airs.net/wl/archive/200003/msg00213.html
(defun wl-draft-subject-check ()
  (interactive)
  (if (and (< (length (std11-field-body "Subject")) 1)
           (null (y-or-n-p "No subject! Send current draft?")))
      (error "Abort.")))
(add-hook 'wl-draft-send-hook 'wl-draft-subject-check)


;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
