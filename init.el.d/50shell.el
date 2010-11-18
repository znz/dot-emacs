;; tramp の sudo などで問題が起きるので /bin/sh に変更。
(when (string-match "zsh" (getenv "SHELL"))
  (setenv "SHELL" "/bin/sh"))

;; shell mode用
(setq comint-scroll-show-maximum-output t)

(static-when (locate-library "ansi-color")
  (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
  (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
  )

(when (require 'shell-pop nil t)
  (shell-pop-set-internal-mode "ansi-term")
  (global-set-key [f8] 'shell-pop)
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
