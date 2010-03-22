;; ヘッダ中の""でクオートされた文字列もデコードする
(setq mime-header-accept-quoted-encoded-words t)

;; mime-w3m
(static-when (locate-library "mime-w3m")
  (setq mime-setup-enable-inline-html nil)
  (eval-after-load "mime-view"
    '(progn
       (autoload 'mime-w3m-preview-text/html "mime-w3m")
       (ctree-set-calist-strictly
        'mime-preview-condition
        '((type . text)
          (subtype . html)
          (body . visible)
        (body-presentation-method . mime-w3m-preview-text/html)))
       (set-alist 'mime-view-type-subtype-score-alist
                  '(text . html) 3))))

;; 大きいメッセージを送信時に分割しない
(setq mime-edit-split-message nil)

;; 大きいメッセージとみなす行数の設定
;;(setq mime-edit-message-default-max-lines 1000)

;; multipart/aternative で text/html の score を下げる。
(eval-after-load "semi-setup"
  '(set-alist 'mime-view-type-subtype-score-alist '(text . html) 0))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
