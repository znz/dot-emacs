;;; 一般的なキー設定。
;; 指定行へ移動
(global-set-key "\M-g" 'goto-line)

(defun my-setup-keyboard-translate (&optional frame)
  "setup keyboard-translate."
  (when frame
    (select-frame frame))
  ;; C-hもBackSpaceも同じ挙動にする。
  (keyboard-translate ?\C-h ?\C-?)  ; translate `C-h' to DEL
  ;;(keyboard-translate ?\C-? ?\C-h)  ; translate DEL to `C-h'.
  )
(my-setup-keyboard-translate)
;; emacsclient -c でも設定
(add-hook 'after-make-frame-functions
          'my-setup-keyboard-translate)

;; 1 回の delete-backward-char で複数の whitespace を消す。
(setq backward-delete-char-untabify-method 'hungry)

(global-set-key "\M- " 'just-one-space) ; デフォルトと同じはず
(global-set-key "\M-q" 'fill-paragraph) ; 段落整形
(global-set-key "\M-h" 'help-command)   ; C-h の代わり
(global-set-key [f1] 'help-command)     ; C-h の代わり
(global-set-key [(control f2)] 'sort-lines)
(global-set-key [f4] 'toggle-read-only) ; 読み込み専用との切り替え
(global-set-key [(control f4)] 'kill-this-buffer) ; バッファを削除
(global-set-key [(meta f4)] 'delete-frame)   ; フレームを削除

(global-set-key (kbd "<Scroll_Lock>") 'ignore) ; 無視する

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

;; C-xo とは逆向きへのウィンドウ移動
;;(global-set-key "\C-xp" (lambda () (interactive) (other-window -1)))
(defun my-other-window-back (arg) (interactive "p") (other-window (- arg)))
(global-set-key "\C-xp" 'my-other-window-back)

;; Shift+矢印キーで分割している window 間を移動
(static-when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings)
  ;; GNU screen の中でも使えるようにする。
  (global-set-key "\M-[1;2A" 'windmove-up)
  (global-set-key "\M-[1;2B" 'windmove-down)
  (global-set-key "\M-[1;2C" 'windmove-right)
  (global-set-key "\M-[1;2D" 'windmove-left)
  ;; nil だとループしない。
  (setq windmove-wrap-around nil))


;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
