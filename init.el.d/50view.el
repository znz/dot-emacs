;; read-only なファイルは view-mode で見る
(setq view-read-only t)

;; ヘルプから関数を辿るとき移動先を read only に (書き換え防止)
(defadvice help-follow
  (after help-follow-read-only activate)
  (setq buffer-read-only t))

(eval-when-compile (require 'view))
(defun my-view-mode-hook ()
  (define-key view-mode-map "b" 'scroll-down)
  (define-key view-mode-map " " 'scroll-up)
  (define-key view-mode-map "H" 'backward-word)
  (define-key view-mode-map "h" 'backward-char)
  (define-key view-mode-map "L" 'forward-word)
  (define-key view-mode-map "l" 'forward-char)
  (define-key view-mode-map "j" 'next-line)
  (define-key view-mode-map "J"
    (lambda () (interactive) (scroll-up 1)))
  (define-key view-mode-map "k" 'previous-line)
  (define-key view-mode-map "K"
    (lambda () (interactive) (scroll-down 1)))
  (define-key view-mode-map "/" 'isearch-forward-regexp)
  (define-key view-mode-map "n" 'isearch-repeat-forward)
  (define-key view-mode-map "N" 'isearch-repeat-backward)
  (define-key view-mode-map "p" 'isearch-repeat-backward)
  (define-key view-mode-map "\M-u" 'isearch-exit)
  (define-key view-mode-map "P" 'beginning-of-buffer)
  (define-key view-mode-map "y" 'lookup-pattern)
  )

(static-unless (featurep 'xemacs)
  (add-hook 'view-mode-hook 'my-view-mode-hook))

(static-when (functionp 'hl-line-mode)
  (add-hook 'view-mode-hook '(lambda () (hl-line-mode 1)))
  (defadvice view-mode-disable (after disable-hl-line-mode activate)
    (hl-line-mode -1))
  )
