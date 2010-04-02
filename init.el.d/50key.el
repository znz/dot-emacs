;;; 一般的なキー設定。
;;; 指定行へ移動
(global-set-key "\M-g" 'goto-line)

;; C-hもBackSpaceも同じ挙動にする。
(keyboard-translate ?\C-h ?\C-?)  ; translate `C-h' to DEL
;;(keyboard-translate ?\C-? ?\C-h)  ; translate DEL to `C-h'.

;; 1 回の delete-backward-char で複数の whitespace を消したい
;; http://www.fan.gr.jp/~ring/Meadow/meadow.html#backward-delete-char-untabify-method
(setq backward-delete-char-untabify-method 'hungry)

(global-set-key "\M- " 'just-one-space) ; デフォルトと同じはず
(global-set-key "\M-q" 'fill-paragraph) ; 段落整形
(global-set-key "\M-h" 'help-command)   ; C-h の代わり
(global-set-key [f1] 'help-command)     ; C-h の代わり
;; [f2] は dmacro
(global-set-key [(control f2)] 'sort-lines)
;;(global-set-key [f3] 'wl)               ; Wanderlust を起動
(global-set-key [f4] 'toggle-read-only) ; 読み込み専用との切り替え
(global-set-key [(control f4)] 'kill-this-buffer) ; バッファを削除
(global-set-key [(meta f4)] 'delete-frame)   ; フレームを削除

(global-set-key (kbd "<Scroll_Lock>") '(lambda () (interactive) nil)) ; 無視する

;; input-method
(global-set-key [zenkaku-hankaku] 'toggle-input-method)
(global-set-key [kanji] 'toggle-input-method)
(global-set-key [(meta zenkaku-hankaku)] 'toggle-input-method)

(defun my-raise-next-frame ()
  "raise next frame."
  (interactive)
  (raise-frame (next-frame)))
(defun my-raise-previous-frame ()
   "raise previous frame."
   (interactive)
   (raise-frame (previous-frame)))
(global-set-key [(control tab)] 'my-raise-next-frame)
(global-set-key [(control shift tab)] 'my-raise-previous-frame)

(defun my-open-line (n)
  (interactive "p")
    (beginning-of-line)
    (open-line n))
(global-set-key "\C-o" 'my-open-line)

;;; C-xo とは逆向きへのウィンドウ移動
;(global-set-key "\C-xp" (lambda () (interactive) (other-window -1)))
(defun my-other-window-back (arg) (interactive "p") (other-window (- arg)))
(global-set-key "\C-xp" 'my-other-window-back)

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
