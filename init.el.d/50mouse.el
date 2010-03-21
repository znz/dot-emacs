;; マウスカーソルの位置ではなくpointの位置にyankする
(setq mouse-yank-at-point t)

(static-when (featurep 'meadow)
  ;;; マウスカーソルを消す設定
  ;; マウスカーソルはキー入力で消えます
  (setq w32-hide-mouse-on-key t)
  ;;(setq w32-hide-mouse-timeout 5000)
  )

;; puttyの中などでもマウスを使えるようにする。
(static-when (fboundp 'xterm-mouse-mode)
  (xterm-mouse-mode 1))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
