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

(static-when (eq window-system 'x)
  (static-cond
   ((locate-library "mwheel")
    ;;(autoload 'mwheel-install "mwheel" "Enable mouse wheel support.")
    (require 'mwheel)
    (when (fboundp 'mwheel-install)
      (mwheel-install)))
   (t
    (global-set-key [mouse-4] 'scroll-down)
    (global-set-key [mouse-5] 'scroll-up))))

(static-when (fboundp 'text-scale-adjust)
  ;; Control+ホイールで文字の大きさを変更
  (global-set-key (kbd "<C-mouse-4>") 'text-scale-increase)
  (global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
