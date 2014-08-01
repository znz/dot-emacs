;; cvs関連の設定
(static-if
    (and (featurep 'meadow)
	 (executable-find "plink.exe"))
    (setenv "CVS_RSH" "plink")
  (setenv "CVS_RSH" "ssh"))

(setq diff-switches "-upN")
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

(static-when (executable-find "svn")
  ;; SubversionのVC backend
  (static-when (and
                (boundp 'vc-handled-backends)
                (locate-library "vc-svn"))
    (add-to-list 'vc-handled-backends 'SVN))

  (static-cond
   ((locate-library "dsvn")
    (setq svn-program "~/howm/bin/env-svn")
    (autoload 'svn-status "dsvn" "Run `svn status'." t)
    (autoload 'svn-update "dsvn" "Run `svn update'." t)
    )
   ((locate-library "psvn")
    (setq svn-status-svn-environment-var-list '("LC_MESSAGES=C" "LC_ALL="))
    (autoload 'svn-status "psvn"
      "Examine the status of Subversion working copy in directory DIR." t))
   )
  )
