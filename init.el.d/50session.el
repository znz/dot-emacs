;;; saveplace カーソル位置の保存
(when (require 'saveplace nil t)
  (if (fboundp 'save-place-mode)
      (save-place-mode 1) ; emacs >= 25
    (setq-default save-place t)) ; emacs < 25
  (setq save-place-file
        (expand-file-name "save-place.el" temporary-file-directory)))
