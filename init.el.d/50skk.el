(when (require 'skk-setup nil t)
  (setq skk-byte-compile-init-file t)
  (setq default-input-method "japanese-skk")
  (setq skk-user-directory
        (expand-file-name "ddskk" user-emacs-directory))
  (setq skk-server-host "localhost")
  (setq skk-server-portnum 1178)
  ;; skk-auto-fill-mode は不要なので skk-mode に変更
  (global-set-key "\C-xj" 'skk-mode)
  ;; dired-x が変更してしまうのを元に戻す。
  (eval-after-load "dired-x"
    '(global-set-key "\C-x\C-j" 'skk-mode))
  )
