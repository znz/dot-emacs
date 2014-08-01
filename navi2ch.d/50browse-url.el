;;; http://pc.2ch.net/test/read.cgi/unix/1031231315/89
;; w3mから2chっぽいURLへ飛ぶときnavi2chでそのURLの内容を表示
(autoload 'navi2ch-browse-url "navi2ch" nil t)
(unless
    (eq browse-url-browser-function 'navi2ch-browse-url)
  (setq navi2ch-browse-url-browser-function browse-url-browser-function)
  (setq browse-url-browser-function 'navi2ch-browse-url))
