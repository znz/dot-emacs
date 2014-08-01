;; 状態でソートするときの順序を決めるリスト
(setq navi2ch-bm-sort-by-state-order
      (let ((n 0))
        (mapcar
         '(lambda (x) (cons x (1- (setq n (1+ n)))))
         '("% "
           "%U" "+U" " U"
           "%V" "+V" " V"
           "%C" "+C" " C"
           "=U" "=V" "=C" "= "
           "+ " "  "))))

;; http://navi2ch.sourceforge.net/cgi-bin/wiki/yapw.cgi/Tips
;; ブックマークモードでレス数を表示
(static-when t
  (defun navi2ch-bookmark-insert-subject (num item)
    (navi2ch-bm-insert-subject
     item num
     (cdr (assq 'subject (navi2ch-bookmark-get-article item)))
     (format "(%4d) [%s]"
             (my-navi2ch-bookmark-get-article-last-number item)
             (cdr (assq 'name (navi2ch-bookmark-get-board item))))))

  (defun my-navi2ch-bookmark-get-article-last-number (item)
    (let ((file (navi2ch-article-get-file-name
                 (navi2ch-bookmark-get-board item)
                 (navi2ch-bookmark-get-article item)))
          num)
      (save-excursion
        (when (file-exists-p file)
          (with-temp-buffer
            (navi2ch-insert-file-contents file)
            (setq num (count-lines (point-min) (point-max))))))
      (or num 0)))

  (defadvice navi2ch-bookmark-fetch-article
    (after navi2ch-bookmark-fetch-article-redraw-line activate)
    (let ((item (navi2ch-bookmark-get-property (point)))
          (buffer-read-only nil) num)
      (save-excursion
        (beginning-of-line)
        (looking-at " *\\([0-9]+\\)")
        (setq num (string-to-number (match-string 1)))
        (delete-region (point) (1+ (line-end-position)))
        (navi2ch-bookmark-insert-subject num item))))
  )
