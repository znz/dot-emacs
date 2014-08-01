(static-when (locate-library "ruby-style")
  (autoload 'ruby-style-c-mode "ruby-style")
  (add-hook 'c-mode-hook 'ruby-style-c-mode)
  (add-hook 'c++-mode-hook 'ruby-style-c-mode)
  )

(defun my-c-set-style ()
  (interactive)
  (make-local-variable 'tab-width)
  (make-local-variable 'indent-tabs-mode)
  (setq tab-width 4)
  (setq indent-tabs-mode t)
  (require 'ruby-style)
  (c-set-style "ruby"))

(static-when (locate-library "xcscope")
  (eval-after-load "cc-mode"
    '(require 'xcscope)))

(setq c-style-variables-are-local-p t)

(static-when (fboundp 'global-cwarn-mode)
  (global-cwarn-mode 1))
