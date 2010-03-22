(static-when (and (locate-library "ssl")
                  (exec-installed-p "gnutls-cli"))
  ;; ssl 接続に gnutls を使う。
  ;; http://d.hatena.ne.jp/buzztaiki/20090715/1247619151
  (setq ssl-program-name "gnutls-cli")
  (setq ssl-program-arguments '("-p" service host)))

(static-when (locate-library "tls")
  ;; ssl 接続に gnutls を使う。
  ;; http://d.hatena.ne.jp/buzztaiki/20090715/1247619151
  (require 'tls)
  (set-alist 'elmo-network-stream-type-alist "!" '(ssl ssl open-tls-stream)))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
