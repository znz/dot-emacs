(global-set-key (kbd "M-¥") (lambda () (interactive) (insert "\\")))

(static-when (eq window-system 'ns)
  (static-when (assoc "MacOSX" input-method-alist)
    ;; ime inline patch
    (setq default-input-method "MacOSX")
    (static-when t
      (mac-translate-from-yen-to-backslash)
      (global-set-key (kbd "M-¥") (lambda () (interactive) (insert "¥")))
      )
    )

  (defun my-open-firefox ()
    "Open Firefox instead of font-panel.
Firefox などの新規タブのつもりで押してしまったときに
フォント設定が開く (ns-popup-font-panel) 代わりに
Firefox に切り替える。"
    (interactive)
    (shell-command-to-string "open -a firefox"))
  (global-set-key [(super t)] 'my-open-firefox)
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
