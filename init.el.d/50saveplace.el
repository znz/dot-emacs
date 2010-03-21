;;; saveplace カーソル位置の保存
(static-when (locate-library "saveplace")
  (require 'saveplace)
  (setq-default save-place t)
  (setq save-place-file
        (expand-file-name "save-place.el" temporary-file-directory)))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
