(add-to-list 'my/favorite-packages 'helm)
(static-when (executable-find "ag")
  (add-to-list 'my/favorite-packages 'helm-ag))
(define-key my-prefix-map "s" 'helm-ag)

(add-to-list 'my/favorite-packages 'helm-descbinds)

(when (require 'helm nil t)
  (define-key my-prefix-map (kbd "C-a") 'helm-mini)
  (define-key my-prefix-map (kbd "C-x") 'helm-M-x)
  (add-hook
   'emacs-lisp-mode-hook
   (lambda ()
     (local-set-key (kbd "C-M-i") 'helm-lisp-completion-at-point)))
  (when (featurep 'helm-descbinds)
    (helm-descbinds-mode 1))
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
