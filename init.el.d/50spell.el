(static-when
    (and
     (or (exec-installed-p "aspell")
         (exec-installed-p "ispell"))
     (fboundp 'flyspell-mode))

  (defun my-flyspell-mode-enable ()
    (interactive)
    (unless (file-exists-p "~/.aspell.conf")
      (error "~/.aspell.conf should be 'lang en_US'"))
    (flyspell-mode 1))
  (defun my-flyspell-enable ()
    (interactive)
    (unless (file-exists-p "~/.aspell.conf")
      (error "~/.aspell.conf should be 'lang en_US'"))
    (flyspell-mode 1)
    (flyspell-buffer))
  (defun my-flyspell-disable ()
    (interactive)
    (flyspell-mode -1))

  (define-key my-prefix-map "f" 'my-flyspell-enable)
  (define-key my-prefix-map "F" 'my-flyspell-disable)

  (mapc
   (lambda (hook)
     (add-hook hook 'flyspell-prog-mode))
   '(
     c-mode-common-hook
     emacs-lisp-mode-hook
     ruby-mode-hook
     ))

  (mapc
   (lambda (hook)
     (add-hook hook 'my-flyspell-mode-enable))
   '(
     changelog-mode-hook
     debian-control-mode-hook
     text-mode-hook
     latex-mode-hook
     mime-view-mode-hook
     ))

  (setq flyspell-use-meta-tab nil)
  (define-key my-prefix-map "\M-\t" 'flyspell-auto-correct-word)
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
