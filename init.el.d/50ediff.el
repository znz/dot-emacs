(setq ediff-window-setup-function 'ediff-setup-windows-plain)

(eval-when-compile (autoload 'diff-auto-refine-mode "diff-mode" nil t))
;; http://www.clear-code.com/blog/2012/4/3.html
(defun diff-mode-refine-automatically ()
  (diff-auto-refine-mode t))
(add-hook 'diff-mode-hook 'diff-mode-refine-automatically)

(defvar my-gemdir nil)
(defun my-ediff-gem ()
  (interactive)
  (let ((default-directory my-gemdir))
    (call-interactively #'ediff-directories)))

(defadvice my-ediff-gem (before my-set-gemdir activate)
  (unless my-gemdir
    (setq my-gemdir (shell-command-to-string "echo -n $(rbenv exec gem env gemdir)/gems/"))
    ))
