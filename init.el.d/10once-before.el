(put 'my-once-before 'lisp-indent-function 2)
(defmacro my-once-before (function name body)
  "functionの初回実行時だけにbodyを実行するnameという名前のaround adviceを定義する。"
  `(defadvice ,function (around ,name activate)
     ,body
     ad-do-it
     (ad-remove-advice ',function 'around ',name)
     (ad-update ',function)))
