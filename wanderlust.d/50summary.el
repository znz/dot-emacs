;; スレッドは常に開く
;;(setq wl-thread-insert-opened t)

;; サマリバッファの左にフォルダバッファを表示する (3ペイン表示)
;;(setq wl-stay-folder-window t)

(setq wl-summary-weekday-name-lang "ja")

;;(setq wl-summary-mode-line-format "Wanderlust: %f {%t}(%n/%u/%a)"
(setq wl-summary-mode-line-format "WL:%n/%u/%a{%t}%f")

;; ML のメッセージであれば，サマリの Subject 表示に
;; ML名 や MLにおけるメッセージ番号も表示する
;; (%n削除, %@追加)
;;(setq wl-summary-line-format "%T%P%M/%D(%W)%h:%m %t%[%17(%c %f%) %] %#%~%s")
(setq wl-summary-line-format
      "%T%P%M/%D(%W)%h:%m %-4S %t%[%17(%c %f%) %]%1i%1@%#%~%s ")
;; フォルダ毎にサマリの表示形式を変える設定
;;(setq wl-folder-summary-line-format-alist
;;      '(("^%inbox\\.emacs\\.wl$" .
;;        "%-5l%T%P%M/%D %h:%m %-4S %[ %17f %] %t%C%s")
;;       ("^%" . "%T%P%M/%D %h:%m %-4S %[ %17f %] %t%C%s")
;;       ("^+" . "%n%T%P%M/%D %h:%m %-4S %[ %17f %] %t%C%s")))
(setq wl-folder-summary-line-format-alist
      '(
        ("^+" . "%n%T%P%M/%D(%W)%h:%m %-4S %t%[%17(%c %f%) %]%1i%1@%#%~%s ")
        ;; X-ML-Name: Wanderlust, X-Mail-Count: 12725
	;;("^file:" . "%T%P %17f %-5S %Y/%M/%D (%W) %h:%m %s")
        ("^file:" . "%T%P %17f %-5S %Y/%M/%D(%W) %h:%m %s ")
        ))

(defun my-wl-summary-line-attached ()
  "encryptedとsigned対応に再定義した%@用関数"
  (let ((content-type (or
                       (elmo-message-entity-field
                        wl-message-entity 'content-type)
                       ""))
        (case-fold-search t))
    (cond
     ((string-match "multipart/mixed" content-type) "@")
     ((string-match "multipart/encrypted" content-type) "?")
     ((string-match "multipart/signed" content-type) "#")
     ((string-match "multipart/" content-type) "%")
     (t ""))))
(add-to-list 'wl-summary-line-format-spec-alist
             '(?@ (my-wl-summary-line-attached)))

(defun wl-summary-line-where-is-my-address ()
  "Ccなどをsummary-lineでわかるようにする。"
  (cond
   ((catch 'found
        (dolist (cc (elmo-message-entity-field wl-message-entity 'cc))
          (when (wl-address-user-mail-address-p cc)
            (throw 'found t))))
    "C")
   ((catch 'found
        (dolist (to (elmo-message-entity-field wl-message-entity 'to))
          (when (wl-address-user-mail-address-p to)
            (throw 'found t))))
    "T")
   ((wl-address-user-mail-address-p
     (elmo-message-entity-field wl-message-entity 'from))
    "F")
    (t "")))

(setq wl-summary-line-format-spec-alist
      (cons '(?i (wl-summary-line-where-is-my-address))
            wl-summary-line-format-spec-alist))

;; サマリ移動後に先頭メッセージを表示する
;;(setq wl-auto-select-first t)

;; サマリ内の移動で未読メッセージがないと次のフォルダに移動する
;;(setq wl-auto-select-next t)
;; 未読がないフォルダは飛ばす(SPCキーだけで読み進める場合は便利)
(setq wl-auto-select-next 'skip-no-unread)

;; 未読メッセージを優先的に読む
;;(setq wl-summary-move-order 'unread)
;; 新規メッセージを優先
(setq wl-summary-move-order 'new)

;; サマリを終了するときに次のフォルダに移動しない
(setq wl-summary-exit-next-move nil)
;; サマリで他のフォルダに移動するとフォルダモードでのカーソル位置も合わせて移動
(setq wl-folder-move-cur-folder t)

;; Non-nil なら、`^L' で改ページしてメッセージを表示
(setq wl-break-pages nil)

;; スレッド表示のインデントを無制限にする。
(setq wl-summary-indent-length-limit nil)
(setq wl-summary-width nil)
;; X-ML-Name: Wanderlust, X-Mail-Count: 08649 を参照
(setq wl-summary-subject-length-limit nil)

;; サブジェクトが変わったらスレッドを切って表示
;;(setq wl-summary-divide-thread-when-subject-changed t)

;; スレッドの見た目を変える
;;(setq wl-thread-indent-level 2)
;;(setq wl-thread-have-younger-brother-str "+"
;;      wl-thread-youngest-child-str      "+"
;;      wl-thread-vertical-str            "|"
;;      wl-thread-horizontal-str          "-"
;;      wl-thread-space-str               " ")


;;; http://pc.2ch.net/test/read.cgi/unix/1030209004/674
;; ちょっとだけ navi2ch っぽくしてみる。
(defun my-wl-folder-one-pane ()
    (interactive)
    (delete-other-windows)
    (wl-folder))
;;(define-key wl-summary-mode-map "q" 'my-wl-folder-one-pane)
(define-key wl-summary-mode-map "1" 'my-wl-folder-one-pane)
(define-key wl-folder-mode-map "1" 'wl-folder-jump-to-previous-summary)

;; wl-summary-mark-as-read-allが1キーでできるのは危険なのではずす。
(define-key wl-summary-mode-map "c" nil)

;; Wanderlust 13915, 13916
(define-key wl-summary-mode-map "," 'wl-summary-pop-to-last-message)


;(setq elmo-folder-update-threshold 500)
(setq elmo-folder-update-threshold 1000)
;(setq elmo-folder-update-confirm nil)

;(setq elmo-message-fetch-threshold 30000)
(setq elmo-message-fetch-threshold 200000)
(setq elmo-message-fetch-confirm nil)

;;; バッファキャッシュと先読み機能
;;(setq wl-message-buffer-prefetch-debug t)
;; 先読みするメッセージのサイズ(nilはチェックなし)
;;(setq wl-prefetch-threshold nil)
(setq wl-prefetch-threshold elmo-message-fetch-threshold)
(setq wl-prefetch-confirm nil)

;; 重複したメッセージが同じフォルダにある場合の動作
;; (マルチフォルダで重複メッセージを隠す)
(setq wl-folder-process-duplicates-alist
      '(("^\\+draft$" . nil) ("^\\+trash$" . nil)
        ("^\\*.*" . hide) (".*" . read)))

;; http://lists.airs.net/wl/archive/200412/msg00175.html
;; http://lists.airs.net/wl/archive/200412/msg00176.html
;; 'flagフォルダからオリジナルのフォルダに移動
(defun wl-summary-jump-to-referer-message ()
  (interactive)
  (let* ((referer (elmo-flag-folder-referrer
                   wl-summary-buffer-elmo-folder
                   (wl-summary-message-number)))
         (folder (if (> (length referer) 1)
                     (completing-read
                      (format "Jump to (%s): " (car (car referer)))
                      referer
                      nil t nil nil (car (car referer)))
                   (car (car referer)))))
    (wl-summary-goto-folder-subr folder
                                 ;; "no-sync" の方が良いかも?
                                 (wl-summary-get-sync-range
                                  (wl-folder-get-elmo-folder folder))
                                 nil nil t)
    (wl-summary-jump-to-msg (cdr (assoc folder referer)))))
(define-key wl-summary-mode-map "=" 'wl-summary-jump-to-referer-message)

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
