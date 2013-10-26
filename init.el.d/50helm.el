(when (require 'helm nil t)
  (define-key my-prefix-map (kbd "C-a") 'helm-mini)
  (define-key my-prefix-map (kbd "C-x") 'helm-M-x)
  (add-hook
   'emacs-lisp-mode-hook
   (lambda ()
     (local-set-key (kbd "C-M-i") 'helm-lisp-completion-at-point)))
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
