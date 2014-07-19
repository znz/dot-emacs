(add-to-list 'my/favorite-packages 'go-mode)
(when (require 'go-mode nil t)
  (let* ((gopath (or (getenv "GOPATH")
		     (expand-file-name "~/g")))
	 (go/bin (concat gopath "/bin")))
    (when (file-directory-p gopath)
      (setenv "GOPATH" gopath)
      (add-to-list 'exec-path go/bin)))
  )
