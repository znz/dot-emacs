;; Folder Carbon Copy
(setq wl-fcc "+outbox")
(setq wl-draft-folder "+draft")

;; Bccを自動的につけない
(setq mail-self-blind nil)

;; 送信前に確認する
(setq wl-interactive-send t)

;; wl-draft-send-and-exit、wl-draft-send の実行時に自動的に
;; wl-draft-config-alist を適用しない。
(remove-hook 'wl-draft-send-hook 'wl-draft-config-exec)
;; ドラフトバッファの作成時に自動的に wl-draft-config-alist を適用する。
(add-hook 'wl-mail-setup-hook 'wl-draft-config-exec)
;; サマリモードから 'E'(wl-summary-reedit)を押してメールを編集する時にも
;; 自動的に wl-draft-config-alist を適用する。
(add-hook 'wl-draft-reedit-hook 'wl-draft-config-exec)

;; ドラフトバッファでC-c C-j もしくは M-x wl-template-select で適用
(add-to-list
 'wl-template-alist
 `("default"
   ("From" . wl-from)
   ("Bcc" . (wl-address-header-extract-address wl-from))
   ;; ("Organization" . "デフォルトの組織名")
   (top . "西山和広です。\n\n")
   (bottom
    . ,(concat
        "\n"
        "-- \n"
        "|ZnZ(ゼット エヌ ゼット)\n"
        "|西山和広(Kazuhiro NISHIYAMA)"
        ))
   (template . "smtp-nifty-vs2nd")
   ))

(add-to-list
 'wl-template-alist
 '("smtp-nifty-vs2nd"
   (wl-smtp-posting-server . "vs2nd.nifty.com")
   (wl-smtp-posting-port . 587)
   (wl-smtp-posting-user . "zn\@mbf.nifty.com")
   (wl-smtp-authenticate-type . "cram-md5")
   (wl-smtp-authenticate-realm . nil)
   (wl-smtp-connection-type . nil)
   ))

(add-to-list
 'wl-template-alist
 '("smtp-localhost"
   (wl-smtp-posting-server . "localhost")
   (wl-smtp-posting-port . nil)
   (wl-smtp-posting-user . nil)
   (wl-smtp-authenticate-type . nil)
   (wl-smtp-authenticate-realm . nil)
   (wl-smtp-connection-type . nil)
   ))

;; wl-draft-config-alist の適用時に最初にマッチした要素のみ適用する。
(setq wl-draft-config-matchone t)

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
