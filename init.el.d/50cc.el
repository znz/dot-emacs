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

(setq hide-ifdef-initially t)
(setq hide-ifdef-shadow t)
;;(custom-set-faces
;; '(hide-ifdef-shadow
;;   ((t (:background "light gray")))))
(custom-set-faces
 '(hide-ifdef-shadow
   ((((class color) (background dark))
     (:background "gray"))
    (((class color) (background light))
     (:background "light gray")))))
(add-hook 'c-mode-common-hook 'hide-ifdef-mode)
