(global-set-key (kbd "M-¥") (lambda () (interactive) (insert "\\")))

(static-when (eq window-system 'ns)
  (static-when (assoc "MacOSX" input-method-alist)
    ;; ime inline patch
    (setq default-input-method "MacOSX")
    (static-when t
      (mac-translate-from-yen-to-backslash)
      (global-set-key (kbd "M-¥") (lambda () (interactive) (insert "¥")))
      )

    (mapc
     (lambda (param)
       (let ((name (car param)))
         (cond
          ((string-match "Japanese\\'" name) ;; ひらがなの日本語入力
           (mac-set-input-method-parameter name 'cursor-color "blue"))
          ((string-match "Japanese" name) ;; カナなどの日本語入力
           (mac-set-input-method-parameter name 'cursor-color "red"))
          ((string-match "Roman" name) ;; 英字
           (mac-set-input-method-parameter name 'cursor-color "black"))
          (t ;; その他
           (mac-set-input-method-parameter name 'cursor-color "yellow"))
          )
         ))
     mac-input-method-parameters)
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
