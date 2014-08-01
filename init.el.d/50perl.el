(eval-when-compile (autoload 'Man-getpage-in-background "man"))
(defun perldoc (word)
  (interactive "sperldoc: ")
  (let ((manual-program))
    (setq manual-program "perldoc")
    (Man-getpage-in-background word)))

(defun my-perl-mode-hook ()
  (set (make-local-variable 'compile-command)
        (concat "perl -cw " buffer-file-name))
  )
(add-hook 'perl-mode-hook #'my-perl-mode-hook)
(add-hook 'cperl-mode-hook #'my-perl-mode-hook)

;; http://d.hatena.ne.jp/odz/20070528/1180331830
(defun perltidy-region (beg end)
  (interactive "r")
  (shell-command-on-region beg end "perltidy -q" nil t))
