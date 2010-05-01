;; ミニバッファのサイズを可変にする
(static-when (functionp 'resize-minibuffer-mode)
  (resize-minibuffer-mode t))

;; ミニバッファで文字が入力されたらデフォルト値を消す
(static-when (functionp 'minibuffer-electric-default-mode)
  (minibuffer-electric-default-mode t))

;; minibuffer 内で C-w で単語削除
(define-key minibuffer-local-completion-map "\C-w" 'backward-kill-word)

;; 補完ウィンドウを補完完了時に消す
(static-when (locate-library "lcomp")
  (require 'lcomp)
  (lcomp-mode 1)
  (lcomp-keys-mode 1))

;; http://d.hatena.ne.jp/rubikitch/20091216/minibuffer
;; 間違ってC-gを押してしまった場合は、再び同じコマンドを起動してM-pで前の入力を呼び戻せる
(static-when (fboundp 'add-to-history)
  (defadvice abort-recursive-edit (before minibuffer-save activate)
    (when (eq (selected-window) (active-minibuffer-window))
      (add-to-history minibuffer-history-variable (minibuffer-contents))))
  )

;; ミニバッファの深さを表示する (enable-recursive-minibuffers が nil なら不要)
(static-when (fboundp 'minibuffer-depth-indicate-mode)
  (when enable-recursive-minibuffers
    (minibuffer-depth-indicate-mode t)))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
