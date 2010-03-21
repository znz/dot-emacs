;; cvs関連の設定
(static-if
    (and (featurep 'meadow)
	 (exec-installed-p "plink.exe"))
    (setenv "CVS_RSH" "plink")
  (setenv "CVS_RSH" "ssh"))

(setq diff-switches "-u")
(setq vc-command-messages t)

;;; http://www4.kcn.ne.jp/~boochang/emacs/pcl-cvs-vc.html
;;
;; cvs が ediff を利用する際に buf1 の coding-system を buf2 に合わせる
;;
(defadvice cvs-ediff-diff (before cvs-ediff-diff-change-coding activate)
  "convert coding system before cvs-ediff-diff"
  (save-excursion
    (let ((buf2 (ad-get-arg 1)))
      (set-buffer buf2)
      (let ((buf1 (ad-get-arg 0))
            (coding-system buffer-file-coding-system))
        (set-buffer buf1)
        (set-buffer-file-coding-system coding-system)))))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
