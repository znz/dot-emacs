(global-set-key (kbd "M-¥") (lambda () (interactive) (insert "\\")))

(static-when (eq window-system 'ns)
  ;; This variable is obsolete since 24.5.
  ;; see https://ja.osdn.net/projects/macemacsjp/lists/archive/users/2017-April/001758.html
  (setq redisplay-dont-pause nil)

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
          ((string-match "Japanese\\(\\.base\\)?\\'" name) ;; ひらがなの日本語入力
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
    (mac-set-input-method-parameter "com.apple.keylayout.US" 'cursor-color "black")
    )

  (defvar terminal-notifier-command
    (executable-find "terminal-notifier")
    "The path to terminal-notifier.")
  (defvar terminal-notifier-bundle-identifier
    "org.gnu.Emacs"
    "The bundle identifier of an application.
It is in its Info.plist file inside the application bundle.")
  (defun terminal-notifier-notify (message &optional title)
    (when terminal-notifier-command
      (start-process
       "terminal-notifier"
       "*terminal-notifier*"
       terminal-notifier-command
       "-title" (or title "Emacs")
       "-activate" terminal-notifier-bundle-identifier
       "-sender" terminal-notifier-bundle-identifier
       "-message" message)))
  (defalias 'my-notify 'terminal-notifier-notify)

  (defun my-open-firefox ()
    "Open Firefox instead of font-panel.
Firefox などの新規タブのつもりで押してしまったときに
フォント設定が開く (ns-popup-font-panel) 代わりに
Firefox に切り替える。"
    (interactive)
    (shell-command-to-string "open -a firefox"))
  (global-set-key [(super t)] 'my-open-firefox)
  )
