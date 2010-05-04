(add-hook
 'navi2ch-article-mode-hook
 (lambda () (setq mode-name "N2-A")))
(add-hook
 'navi2ch-articles-mode-hook
 (lambda () (setq mode-name "N2-As")))
(add-hook
 'navi2ch-board-mode-hook
 (lambda () (setq mode-name "N2-Bd")))
(add-hook
 'navi2ch-bookmark-mode-hook
 (lambda () (setq mode-name "N2-Bm")))
(add-hook
 'navi2ch-directory-mode-hook
 (lambda () (setq mode-name "N2-Dir")))
(add-hook
 'navi2ch-head-mode-hook
 (lambda () (setq mode-name "N2-Head")))
(add-hook
 'navi2ch-history-mode-hook
 (lambda () (setq mode-name "N2-Hist")))
(add-hook
 'navi2ch-list-mode-hook
 (lambda () (setq mode-name "N2-ls")))
(add-hook
 'navi2ch-message-mode-hook
 (lambda () (setq mode-name "N2-Msg")))
(add-hook
 'navi2ch-popup-article-mode-hook
 (lambda () (setq mode-name "N2-PU-A")))
(add-hook
 'navi2ch-search-mode-hook
 (lambda () (setq mode-name "N2-S")))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
