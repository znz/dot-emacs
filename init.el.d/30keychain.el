(defun my-keychain-env ()
  "keychainのファイルから環境変数読み込み"
  (interactive)
  (save-excursion
    (let*
        ((keychain1-filename
          (expand-file-name (concat ".ssh-agent-csh-" (system-name)) "~"))
         (keychain2-filename
          (expand-file-name (concat (system-name) "-csh") "~/.keychain"))
         (keychain2-filename-short
          ;; system-name が FQDN で `uname -n` がドメインなしの場合
          (expand-file-name (concat
                             (car (split-string (system-name) "\\."))
                             "-csh") "~/.keychain"))
         (filename (cond
                    ((file-exists-p keychain2-filename) keychain2-filename)
                    ((file-exists-p keychain2-filename-short)
                     keychain2-filename-short)
                    (t keychain1-filename)))
         (buffer
          (find-file-noselect filename))
         (case-fold-search nil)
         )
      (set-buffer buffer)
      (setq buffer-read-only t)
      (widen)
      (goto-char (point-min))
      (while (re-search-forward "setenv \\(SSH_[A-Z_]+\\) \\([^ ;]+\\);" nil t)
        (setenv (match-string 1) (match-string 2)))
      (kill-buffer buffer)))
  (let ((pid (getenv "SSH_AGENT_PID")))
    (if (and pid (= 0 (shell-command (format "kill -0 %s" pid))))
        (if (interactive-p)
            (message "ssh-agent found at PID %s." pid))
      ;; ssh-agentがいなかったらunsetenv
      (setenv "SSH_AGENT_PID" nil)
      (setenv "SSH_AUTH_SOCK" nil)
      (if (interactive-p)
          (message "ssh-agent not found."))))
  )

(defvar my-pinentry
  (eval-when-compile
    (or (executable-find "pinentry-x11")
        (executable-find "pinentry-gtk-2")))
  "X 上で動く pinentry がインストールされているかどうか。")
(defun my-gpg-agent-info ()
  "gpg-agentが使えないときにはGPG_AGENT_INFOをunsetenvする"
  (interactive)
  ;; ~/.keychain/*-csh-gpg は読み込まない。
  (when (getenv "GPG_AGENT_INFO")
    (cond
     ((not window-system)
      ;; pinentry-cursesはemacsの中では動かないのでunsetenv
      (setenv "GPG_AGENT_INFO" nil))
     ((and (eq window-system 'x)
           (not my-pinentry))
      ;; X上で別windowを出すpinentryがなければunsetenv
      (setenv "GPG_AGENT_INFO" nil))
     )))

(static-cond
 ((eq window-system 'ns)
  ;; Mac OS X の keychain Access は仕組みが違うので余計なことをしない
  )
 (t
  (my-keychain-env)
  (my-gpg-agent-info)
  ))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
