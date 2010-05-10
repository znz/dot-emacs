(defvar my-user-mail-address-list
  (list
   ;; @nifty 2nd mail address
   "zn\@mbf.nifty.com"
   ;; ruby-lang
   "kazu\@ruby-lang.org"
   ;; gmail のアドレスは下の my-gmail-address-list から
   ;; 70gmail.el で自動追加するので不要
   )
  "wl-user-mail-address-listの初期値")
(defvar my-gmail-address-list
  (list
   ;; gmail
   '("gmail" "kzhr.nsym\@gmail.com" "kazuhiro NISHIYAMA")
   )
  "自分のGmailのアドレスのリスト
wl-template-alist用の名前、メールアドレス、ユーザ名からなるリストのリスト")

;; my-*-address-list に他のアドレスも含めて設定。
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
