;; wl-folder-mark-as-read-all-current-entityが1キーでできるのは危険。
(define-key wl-folder-mode-map "c" nil)

;;; 変更した後はM-RETで更新すること。
;;; m sでソートもしておくとよい。
(setq wl-folder-hierarchy-access-folders
      '("^-[^\\.]*\\(:\\|@\\|$\\)"
        "^@$" "^'$"
        ;; "^%"
        ;; "-fj" "-fj.comp" "-fj.net" "-fj.news" "-fj.os"
        ;; "-fj.rec" "-fj.sys"
        ;; "-japan"
        ;; "+" "%inbox:zn/cram-md5@mail.test"
        ))
;;(setq wl-folder-init-no-load-access-folders '("^-alt"))
;;(setq wl-folder-access-subscribed-alist
;;      '(("^-fj$"   . (t   "^-fj\\.\\(1st\\|comp\\|editor\\|mail\\)"
;;                        "^-fj\\.\\(net\\|news\\|os\\|sys\\|rec\\)"))
;;      ))
;;; すべて講読するのならnilでいい。
(setq wl-folder-access-subscribed-alist nil)

;; 初期設定は `nil'。Non-nil ならメッセージが削除されたときにフォルダ
;; モードで未読数をチェックすると負の値が表示されます。値が `sync' な
;; らば、メッセージが削除されていたときにフォルダの内容と同期を取りま
;; す。
(setq wl-folder-notify-deleted 'sync)
