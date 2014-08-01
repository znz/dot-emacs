(defun delete-file-if-no-contents ()
  "内容が 0 ならファイルごと削除する."
  (when (and
         (buffer-file-name (current-buffer))
         (= (point-min) (point-max)))
    (when (y-or-n-p "Delete file and kill buffer?")
      (let (delete-by-moving-to-trash)
        (delete-file
         (buffer-file-name (current-buffer))))
      (kill-buffer (current-buffer)))))
(add-hook 'after-save-hook 'delete-file-if-no-contents)

;;; http://www-nagao.kuee.kyoto-u.ac.jp/member/tsuchiya/elisp/
;;; スクリプトを save する時、自動的に chmod +x を行なう
;;;  Katsumi Yamaoka <yamaoka@ga.sony.co.jp> さん作
;;;  ファイル名が . で始まる場合は chmod +x を行わないように改造 (Sep 9, 1997)
(static-if (fboundp 'executable-make-buffer-file-executable-if-script-p)
    (add-hook
     'after-save-hook
     'executable-make-buffer-file-executable-if-script-p)
  (add-hook
   'after-save-hook
   #'(lambda ()
       (save-restriction
         (widen)
         (if (or
              (string= "#!" (buffer-substring 1 (min 3 (point-max))))
              (string-match ".cgi$" (buffer-file-name)))
             (let ((name (buffer-file-name)))
               (or (char-equal ?. (string-to-char (file-name-nondirectory name))
                               )
                   (let ((mode (file-modes name)))
                     (set-file-modes name (logior mode (logand (/ mode 4) 73)))
                     (message (concat "Wrote " name " (+x)"))))
               ))))))
