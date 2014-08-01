(eval-after-load "ruby-mode"
  '(setq ruby-font-lock-keywords
	 (append
	  '(("\\<initialize\\>" . font-lock-keyword-face))
	  ruby-font-lock-keywords)))
