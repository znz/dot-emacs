(defconst my-cygwin-root
  (static-cond
   ((file-exists-p "/etc/debian_version") nil)
   ((file-exists-p "/etc/resolv.conf") nil) ; Windows以外の環境だけにありそうなもの
   ((file-exists-p "c:/cygwin") "c:/cygwin")
   ((file-exists-p "d:/cygwin") "d:/cygwin")
   (t nil) ; cygwinが入っていなければnil
   )
  "cygwinのルートディレクトリ")
