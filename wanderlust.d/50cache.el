;; フォルダ種別ごとのキャッシュの設定
;; (localdir, localnews, maildir はキャッシュできない)
(setq elmo-archive-use-cache nil)
(setq elmo-imap4-use-cache t)
(setq elmo-nntp-use-cache t)
(setq elmo-pop3-use-cache t)
(setq elmo-shimbun-use-cache t)
;; キャッシュをクリアするには、
;; `M-x elmo-cache-expire-by-age'
;; `M-x elmo-cache-expire-by-size'

(setq
 elmo-cache-directory
 (expand-file-name "elmo-cache" temporary-file-directory))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
