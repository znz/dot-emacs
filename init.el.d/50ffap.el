(static-when
    (and (locate-library "ffap")
	 (fboundp 'ffap-bindings))
  ;;(ffap-bindings)
  (require 'ffap)
  (global-set-key [S-mouse-3] 'ffap-at-mouse)
  (global-set-key [C-S-mouse-3] 'ffap-menu)
  (global-set-key [C-S-mouse-1] 'ffap-at-mouse)
  (global-set-key [C-S-mouse-2] 'ffap-menu)
  (define-key my-prefix-map "\C-f" 'find-file-at-point)
  (define-key my-prefix-map "\C-r" 'ffap-read-only)
  (define-key my-prefix-map "\C-v" 'ffap-alternate-file)
  (define-key my-prefix-map "d" 'dired-at-point)
  ;; 新規ファイルの場合には確認する
  (setq ffap-newfile-prompt t)
  (setq ffap-rfc-path "http://mla.n-z.jp/?rfc:%s")
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End: