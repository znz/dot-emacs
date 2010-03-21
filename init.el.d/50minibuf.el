;; ミニバッファのサイズを可変にする
(static-when (functionp 'resize-minibuffer-mode)
  (resize-minibuffer-mode t))

;; minibuffer 内で C-w で単語削除
(define-key minibuffer-local-completion-map "\C-w" 'backward-kill-word)

;; http://d.hatena.ne.jp/rubikitch/20091216/minibuffer
;; 間違ってC-gを押してしまった場合は、再び同じコマンドを起動してM-pで前の入力を呼び戻せる
(static-when (fboundp 'add-to-history)
  (defadvice abort-recursive-edit (before minibuffer-save activate)
    (when (eq (selected-window) (active-minibuffer-window))
      (add-to-history minibuffer-history-variable (minibuffer-contents))))
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
