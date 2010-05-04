;; http://navi2ch.sourceforge.net/cgi-bin/wiki/yapw.cgi/Tips
;; article モードで Q したときそのスレの行に移動
(defadvice navi2ch-article-goto-current-board
  (after navi2ch-board-goto-current-article-line activate)
  (let ((x (save-excursion
             (set-buffer (navi2ch-article-current-buffer))
             (cdr (assq 'artid navi2ch-article-current-article)))))
    (goto-char (point-max))
    (while (not (or (eq (point) (point-min))
                    (equal x
                           (cdr (assq 'artid (navi2ch-bm-get-article-internal
                                              (navi2ch-bm-get-property-internal (point))))))))
      (previous-line 1))))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
