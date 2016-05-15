(put 'my-once-before 'lisp-indent-function 2)
(static-if (fboundp 'advice-add)
    (defmacro my-once-before (function name body)
      "functionの初回実行時だけにbodyを実行するnameという名前のaround adviceを定義する。"
      `(progn
	 (defun ,name (&rest rest-vars)
	     ,body
	   (advice-remove ',function ',name))
	 (advice-add ',function :before ',name)
	 ;; Warning: function url-hexify-string-cs used to take 0+ arguments, now takes 1-2 対策としてコンパイル時には advice-remove する。
	 (eval-when-compile (,name))
	 ))
  (defmacro my-once-before (function name body)
    "functionの初回実行時だけにbodyを実行するnameという名前のaround adviceを定義する。"
    `(defadvice ,function (before ,name activate)
       ,body
       (ad-remove-advice ',function 'before ',name)
       (ad-update ',function)))
  )
