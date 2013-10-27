;; tramp の sudo などで問題が起きるので /bin/sh に変更。
(when (string-match "zsh" (getenv "SHELL"))
  (setenv "SHELL" "/bin/sh"))

;; shell mode用
(setq comint-scroll-show-maximum-output t)

(static-when (locate-library "ansi-color")
  (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
  (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
  )

(add-to-list 'my/favorite-packages 'shell-pop)
(when (require 'shell-pop nil t)
  ;; setq では正常に反映されないので custom-set-variables を使う必要あり。
  (custom-set-variables
   '(shell-pop-shell-type (quote ("ansi-term" "*ansi-term*" (lambda () (ansi-term shell-pop-term-shell)))))
   '(shell-pop-universal-key "C-c t")
   '(shell-pop-window-position "full")
   )
  ;;(global-set-key [f8] 'shell-pop)
 )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
