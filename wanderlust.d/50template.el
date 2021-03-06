;; wl-draft-send-and-exit、wl-draft-send の実行時に自動的に
;; wl-draft-config-alist を適用しない。
(remove-hook 'wl-draft-send-hook 'wl-draft-config-exec)
;; ドラフトバッファの作成時に自動的に wl-draft-config-alist を適用する。
(add-hook 'wl-mail-setup-hook 'wl-draft-config-exec)
;; サマリモードから 'E'(wl-summary-reedit)を押してメールを編集する時にも
;; 自動的に wl-draft-config-alist を適用する。
(add-hook 'wl-draft-reedit-hook 'wl-draft-config-exec)

;; wl-draft-config-alist の適用時に最初にマッチした要素のみ適用する。
(setq wl-draft-config-matchone t)

(defvar my-template-alist nil
  "wl-template-alistの前の方に追加する部分")
(defvar my-smtp-template-alist nil
  "wl-template-alistに追加するSMTP設定")

;; ドラフトバッファでC-c C-j もしくは M-x wl-template-select で適用
(add-to-list
 'my-template-alist
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
   (template . "smtp-nifty")
   ))

(add-to-list
 'my-smtp-template-alist
 '("smtp-nifty"
   (wl-smtp-posting-server . "smtp.nifty.com")
   (wl-smtp-posting-port . 465)
   (wl-smtp-posting-user . "zn\@mbf.nifty.com")
   (wl-smtp-authenticate-type . "cram-md5")
   (wl-smtp-authenticate-realm . nil)
   (wl-smtp-connection-type . 'ssl)
   (wl-local-domain . "mbf.nifty.com")
   ))

(add-to-list
 'my-smtp-template-alist
 '("smtp-localhost"
   (wl-smtp-posting-server . "localhost")
   (wl-smtp-posting-port . 10025)
   (wl-smtp-posting-user . nil)
   (wl-smtp-authenticate-type . nil)
   (wl-smtp-authenticate-realm . nil)
   (wl-smtp-connection-type . nil)
   ))

(load "~/.emacs.d/private/my-template")
