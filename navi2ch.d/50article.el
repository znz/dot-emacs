;; スレを全部表示(100件に制限しない)
(setq navi2ch-article-auto-range nil)

;; 古いバッファを自動的に消す。
(setq navi2ch-article-auto-expunge t)
;(setq navi2ch-article-max-buffers 5)


;; スレのエンコードされたテキストを自動展開してバッファに挿入する。
(setq navi2ch-article-auto-decode-p t
      navi2ch-article-auto-decode-insert-text t)

;; レスとレスを区切るテキストの横幅。
(when (and window-system (<= emacs-major-version 21))
  (setq navi2ch-article-message-separator-width '(- (window-width) 1)))

;; article を開くときに 1ペインにする。
(setq navi2ch-bm-stay-board-window nil)

;; *スレ内リンク (>>3 とか) をたどるときの表示方法。
;; 'popup ならつねに別ウィンドウを popup する。
(setq navi2ch-article-select-current-link-number-style 'popup)

;; ">> あ" のような行も引用と見なす。
(let ((regexp "^[>＞]+\\($\\|[^$>＞0-9０-９].*\\)"))
  (if (or
       (string= navi2ch-article-citation-regexp
                "^[>＞]\\($\\|[^$>＞0-9０-９].*\\)")
       (string= navi2ch-article-citation-regexp regexp))
      (setq navi2ch-article-citation-regexp regexp)
    (error "navi2ch-article-citation-regexp changed!")))

;; http://pc7.2ch.net/test/read.cgi/software/1129480572/70
;; (cf. http://www.meadowy.org/meadow/ticket/131)
(unless (= scroll-margin 0)
  (add-hook 'navi2ch-article-mode-hook
            (lambda ()
              (make-local-variable 'scroll-margin)
              (setq scroll-margin 0))))

;; 連続改行を消す
(defun navi2ch-article-shrink-newlines ()
  (save-excursion
    (while (re-search-forward "^[ 　]*\n[ 　]*\n[ 　]*\n\\([ 　]*\n\\)+" nil t)
      (let ((len (count-lines (match-beginning 0) (match-end 0))))
        (when (>= len 8)
          (replace-match (format "\n[[ %d newlines ]]\n\n" len)))))))
(add-hook 'navi2ch-article-arrange-message-hook
          'navi2ch-article-shrink-newlines)

;;(when (require 'smiley nil t)
;;  (setq smiley-data-directory "/usr/share/pixmaps/smilies")
;;  (add-hook 'navi2ch-article-arrange-message-hook 'smiley-buffer))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
