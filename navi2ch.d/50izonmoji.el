(static-when (locate-library "izonmoji-mode")
  (require 'izonmoji-mode)
  (add-hook 'navi2ch-bm-mode-hook      'izonmoji-mode-on)
  (add-hook 'navi2ch-article-mode-hook 'izonmoji-mode-on)
  (add-hook 'navi2ch-popup-article-mode-hook 'izonmoji-mode-on)
  ;; IBM拡張文字を表示 (XEmacs-21.1 は非対応)
  (when (memq 'izonmoji-shift-jis (coding-system-list))
    (setq navi2ch-coding-system 'izonmoji-shift-jis))
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
