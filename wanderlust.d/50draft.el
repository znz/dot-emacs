;; Folder Carbon Copy
(setq wl-fcc "+outbox")
(setq wl-draft-folder "+draft")

;; Bccを自動的につけない
(setq mail-self-blind nil)

;; 送信前に確認する
(setq wl-interactive-send t)

;; Envelope-From を切り替え
(defun my-wl-draft-set-envelope-from ()
  (setq wl-envelope-from
        (wl-address-header-extract-address
         (or
          (std11-fetch-field "Sender")
          (std11-fetch-field "From")))))
(add-hook 'wl-draft-send-hook 'my-wl-draft-set-envelope-from)

;;; http://lists.airs.net/wl/archive/200003/msg00213.html
(defun wl-draft-subject-check ()
  (interactive)
  (if (and (< (length (std11-field-body "Subject")) 1)
           (null (y-or-n-p "No subject! Send current draft?")))
      (error "Abort.")))
(add-hook 'wl-draft-send-hook 'wl-draft-subject-check)

;; Message-IDのドメインパートにwl-fromを使う。
(setq wl-message-id-use-message-from t)

;; 返信時のウィンドウを広くする
(setq wl-draft-reply-buffer-style 'full)

;; ドラフトを新しいフレームで開くのは emacsclient -c が閉じてしまうので
;; 止めた。
(setq wl-draft-use-frame nil)

;; 返信時のヘッダに相手の名前を入れない。
(setq wl-draft-reply-use-address-with-full-name nil)

;; 自分宛てのメールに返信する場合、常に `To:', `Cc:' から
;; 自分のメールアドレスを削除
(setq wl-draft-always-delete-myself t)

;; unplugged 状態で送信すると，キュー(`wl-queue-folder')に格納する
(setq wl-draft-enable-queuing t)

;; `Fcc:' で保存したメッセージを既読にする
(setq wl-fcc-force-as-read t)

;; unplugged から plugged に変えたときに，キューにあるメッセージを送信する
(setq wl-auto-flush-queue t)

;; sendlog
(setq wl-draft-sendlog t) ;; see ~/.elmo/sendlog

;; Wanderlust 13231
;; MLへのRES投稿でSubjectからML名を取り除くには？
(setq wl-subject-re-prefix-regexp
      (concat "^[ \t]*"
              ;; [Mailing-List: 9999]
              "\\(\\s(\\(\\S(+\\)[ :]\\([0-9]+\\)\\s)\\)?[ \t]*"
              ;; Re:
              "\\([Rr][Ee][:>][ \t]*\\)*[ \t]*"))
