(static-when (locate-library "recentf")
  (require 'recentf)
  (setq recentf-save-file
        (expand-file-name "recentf-save.el" temporary-file-directory))

  ;; migration
  (when
      (and (not (file-exists-p recentf-save-file))
           (file-exists-p "~/.recentf"))
    (rename-file "~/.recentf" recentf-save-file))
  (when (file-exists-p recentf-save-file)
    ;; chmod 0600
    (set-file-modes recentf-save-file 384))

  (setq recentf-max-menu-items 10)
  (setq recentf-max-saved-items 2000)

  ;; TRAMP を除外
  (static-when (boundp 'tramp-file-name-regexp)
    (add-to-list 'recentf-exclude tramp-file-name-regexp))

  ;(setq recentf-auto-cleanup 'never)
  (static-when (fboundp 'file-remote-p)
    (add-to-list 'recentf-keep 'file-remote-p))
  (recentf-mode 1)
  ;(global-set-key "\C-cf" 'recentf-open-files)
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
