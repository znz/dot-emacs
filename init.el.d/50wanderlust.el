;; Wanderlust
;; 他の設定はdot-wl.elに。
(static-when (locate-library "wl")
  (when (require 'advice nil t)
    (setq mime-setup-enable-inline-html nil)
    (defadvice wl (before mime-setup activate)
      (require 'mime-setup)))
  (autoload 'wl "wl" "Wanderlust" t)
  (autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)
  (autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)

  (autoload 'wl-user-agent-compose "wl-draft" nil t)
  (static-if (boundp 'mail-user-agent)
      (setq mail-user-agent 'wl-user-agent))
  (static-if (fboundp 'define-mail-user-agent)
      (define-mail-user-agent
        'wl-user-agent
        'wl-user-agent-compose
        'wl-draft-send
        'wl-draft-kill
        'mail-send-hook))

  (setq wl-init-file "~/.emacs.d/dot-wl")
  (eval-after-load "wl" '(my-byte-compile-file wl-init-file))
  )

;;; X-ML-Name: Wanderlust
;;; X-Mail-Count: 11722
;;; より

;;; ファイル名が日本語の添付ファイルをデコードする [semi-gnus-ja: 4332]
(eval-after-load "mime"
  '(defadvice mime-entity-filename
     (after eword-decode-for-broken-MUA activate)
     "Decode eworded file name for *BROKEN* MUA."
     (when (stringp ad-return-value)
       (setq ad-return-value (eword-decode-string ad-return-value t)))))

;;; ファイル名が日本語の添付ファイルをエンコードする [semi-gnus-ja: 6046]
;; spamでエラーになるのでコメントアウト
;;(eval-after-load "std11"
;;  '(defadvice std11-wrap-as-quoted-string (before encode-string activate)
;;     "Encode a string."
;;     (require 'eword-encode)
;;     (ad-set-arg 0 (eword-encode-string (ad-get-arg 0)))))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
