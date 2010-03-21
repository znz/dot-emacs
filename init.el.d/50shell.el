;; tramp の sudo などで問題が起きるので /bin/sh に変更。
(when (string-match "zsh" (getenv "SHELL"))
  (setenv "SHELL" "/bin/sh"))

;; shell mode用
(setq comint-scroll-show-maximum-output t)

(static-when (locate-library "ansi-color")
  (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
  (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
