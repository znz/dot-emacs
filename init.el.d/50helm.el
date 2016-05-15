(add-to-list 'my/favorite-packages 'helm)
(static-when (executable-find "ag")
  (add-to-list 'my/favorite-packages 'helm-ag))
(define-key my-prefix-map "g" 'helm-ag)

(add-to-list 'my/favorite-packages 'helm-descbinds)
(add-to-list 'my/favorite-packages 'helm-ghq)
(define-key my-prefix-map (kbd "M-g") 'helm-ghq)

(static-when (locate-library "helm")
  (require 'helm)
  (define-key my-prefix-map (kbd "C-a") 'helm-mini)
  (define-key my-prefix-map (kbd "C-x") 'helm-M-x)
  (add-hook
   'emacs-lisp-mode-hook
   (lambda ()
     (local-set-key (kbd "C-M-i") 'helm-lisp-completion-at-point)))
  (static-when (featurep 'helm-descbinds)
    (helm-descbinds-mode 1))
  )
