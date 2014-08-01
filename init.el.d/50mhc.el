;;; MHC
;;; 予定表

(static-when (and (file-directory-p "~/Mail/.schedule")
                  (locate-library "mhc"))
  (setq my-dot-mhc-file "~/.emacs.d/dot-mhc")
  ;; mhc-varsより先に設定しないといけない項目があるので
  ;; mhc-*-setupより後でhookに追加する。
  (defun my-dot-mhc ()
    "mhcの設定ファイル読み込み"
    (load my-dot-mhc-file))

  ;; Mew
  (static-when (and (locate-library "mew") (locate-library "mhc-mew"))
    (autoload 'mhc-mew-setup "mhc-mew")
    (add-hook 'mew-init-hook 'mhc-mew-setup)
    (add-hook 'mew-init-hook 'my-dot-mhc)
    )

  ;; Wanderlust
  (static-when (and (locate-library "wl") (locate-library "mhc-wl"))
    (autoload 'mhc-wl-setup "mhc-wl")
    (add-hook 'mhc-draft-finish-hook 'wl-message-buffer-cache-clean-up)
    (add-hook 'wl-init-hook 'mhc-wl-setup)
    (add-hook 'wl-init-hook 'my-dot-mhc)
    )

  ;; Gnus
  (static-when (and (locate-library "gnus") (locate-library "mhc-gnus"))
    (autoload 'mhc-gnus-setup "mhc-gnus")
    (add-hook 'gnus-startup-hook 'mhc-gnus-setup)
    (add-hook 'gnus-startup-hook 'my-dot-mhc)
    )
  )
