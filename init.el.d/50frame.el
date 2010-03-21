;; mule/emacs -nw で起動した時にメニューバーを消す
(static-when (functionp 'menu-bar-mode)
  (if window-system
      (menu-bar-mode 1)
    (menu-bar-mode -1)))

;;; 常に折り返し表示する
;;; (左右のスクロールは C-x< と C-x>
;; window 分割時、画面外に出る文章を折り返したい
(setq truncate-partial-width-windows nil)
;; 通常時
(setq truncate-lines nil)

;; スクロールバーを表示する
(scroll-bar-mode 1)

(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'left)