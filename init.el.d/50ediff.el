(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; http://www.clear-code.com/blog/2012/4/3.html
(defun diff-mode-refine-automatically ()
  (diff-auto-refine-mode t))
(add-hook 'diff-mode-hook 'diff-mode-refine-automatically)

(defvar gemdir nil)
(defun my-ediff-gem ()
  (interactive)
  (let ((default-directory gemdir))
    (call-interactively #'ediff-directories)))

(defadvice my-ediff-gem (before my-set-gemdir activate)
  (unless gemdir
    (setq gemdir (shell-command-to-string "echo -n $(rbenv exec gem env gemdir)/gems/"))
    ))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End: