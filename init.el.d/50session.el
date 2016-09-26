;;; saveplace カーソル位置の保存
(static-cond
 ((locate-library "session")
  (setq session-save-file
        (expand-file-name (concat "saved-session-" my-flavor ".el")
                          temporary-file-directory))
  (static-when (< emacs-major-version 23)
    (setq session-save-file-coding-system 'iso-2022-7bit-unix))
  (require 'session)
  ;; 30keychain.el で開いたものも無視する。
  (setq session-set-file-name-exclude-regexp
        (concat session-set-file-name-exclude-regexp "\\|\\.ssh-agent-csh-"))
  ;; mhc-*-hist なども保存する。
  (setq session-globals-regexp "-\\(ring\\|hist\\(ory\\)?\\)\\'")
  (setq session-initialize '(de-saveplace session places keys menus)
        session-globals-include '((kill-ring 50)
                                  (session-file-alist 500 t)
                                  (file-name-history 10000)))
  (setq session-globals-max-string 100000000)
  (setq history-length t)
  (setq session-undo-check -1)
  (add-hook 'after-init-hook 'session-initialize))
 ((locate-library "saveplace")
  (require 'saveplace)
  (if (fboundp 'save-place-mode)
      (save-place-mode 1) ; emacs >= 25
    (setq-default save-place t)) ; emacs < 25
  (setq save-place-file
        (expand-file-name "save-place.el" temporary-file-directory))))
