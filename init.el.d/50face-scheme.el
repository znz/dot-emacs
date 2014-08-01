(static-when (locate-library "cmuscheme")
  (eval-when-compile (require 'cmuscheme))
  ;; scheme-mode の色設定に追加
  (defun my-scheme-mode-hook-font-lock ()
    (setq scheme-font-lock-keywords-2
	  (append '(("[()]" . paren-face))
		  scheme-font-lock-keywords-2))

    ;; Emacs で文字関連のリテラルに色をつける - masa.edw the ハバネロブリーダー
    ;; http://d.hatena.ne.jp/masa_edw/20080531/1212236247
    (add-to-list 'scheme-font-lock-keywords-2 '("#\\\\\\(\\w+\\|.\\)" . font-lock-string-face)) ; 文字 #\x
    (add-to-list 'scheme-font-lock-keywords-2 '("#\\[.*?\\]" . font-lock-string-face)) ; 文字集合 #[...]
    (add-to-list 'scheme-font-lock-keywords-2 '("#/\\(.\\|\\\\/\\)*/" . font-lock-string-face)) ; 正規表現 #/.../
    )
  (add-hook 'scheme-mode-hook 'my-scheme-mode-hook-font-lock))
