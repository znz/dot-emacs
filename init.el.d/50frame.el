;; 端末の中ではメニューバーを消す
(static-when (functionp 'menu-bar-mode)
  (if window-system
      (menu-bar-mode 1)
    (menu-bar-mode -1)))

;; emacsclient -c の時は表示しようとしたら、
;; (terminal-local じゃないので)
;; 端末の中の方にも影響してしまうが、
;; そこは妥協することにした。
(defun my-menu-bar-mode (&optional frame)
  "setup menu-bar-mode."
  (unless frame
    (setq frame (selected-frame)))
  (select-frame frame)
  (if (window-system frame)
      (menu-bar-mode 1)
    (menu-bar-mode -1)))
(my-menu-bar-mode)
(add-hook 'after-make-frame-functions
          'my-menu-bar-mode)

;; ツールバーを表示しない
(static-when (fboundp 'tool-bar-mode)
  (tool-bar-mode 0))

;;; 常に折り返し表示する
;;; (左右のスクロールは C-x< と C-x>
;; window 分割時、画面外に出る文章を折り返したい
(setq truncate-partial-width-windows nil)
;; 通常時
(setq truncate-lines nil)

;; スクロールバーを表示する
(scroll-bar-mode 1)

(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'right)

(set-frame-parameter nil 'alpha '(90 80))
(add-to-list 'default-frame-alist '(alpha 90 80))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
