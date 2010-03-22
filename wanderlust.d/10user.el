(load "~/.emacs.d/private/my-address-list")

(setq wl-from (concat user-full-name " <" user-mail-address ">"))

;; 自分のメールアドレスのリスト
(setq wl-user-mail-address-list
      my-user-mail-address-list)

(add-to-list 'wl-user-mail-address-list
             (wl-address-header-extract-address wl-from))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
