;; HTML パートを表示しない
;; mime-setup がロードされる前に記述する必要があります。
(setq mime-setup-enable-inline-html nil)

;; http://triaez.kaisei.org/~kaoru/diary/?200111c#200111252
;; SEMI でファイル挿入時にカーソル移動ができなくなったような錯覚 を防止する。
(add-hook
 'mime-edit-mode-hook
 #'(lambda ()
     (setq buffer-invisibility-spec '((t . t)))
     (set (make-local-variable 'line-move-ignore-invisible) t)))
