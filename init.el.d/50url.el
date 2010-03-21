(define-key my-prefix-map "m" 'browse-url-at-point)

(setq browse-url-browser-function
      (static-cond
       ((locate-library "w3m")
	(setq browse-url-browser-function 'w3m-browse-url))
       (t 'browse-url-generic)))
(setq browse-url-generic-program
      (static-cond
       ((featurep 'meadow) "fiber.exe")
       ((exec-installed-p "browser.sh") "browser.sh") ; my wrapper script
       ((exec-installed-p "xdg-open") "xdg-open")
       ((exec-installed-p "x-www-browser") "x-www-browser") ; debian
       ))

;;; URL をShift+マウス中クリックでブラウザ起動する様にする
(static-when (locate-library "browse-url")
  (when window-system
    (autoload 'browse-url-at-mouse "browse-url"
      "Ask a WWW browser to load a URL clicked with the mouse." t)
    (global-set-key [S-mouse-2] 'browse-url-at-mouse)))

;;; 後ろに続く文章がURLに含まれないようにする。
(setq thing-at-point-url-path-regexp
      (concat
       "[-\\*+.,;!#$%&/:=?@_|0-9A-Za-z~]*"
       "[-\\*+!#$%&/:=?@_|0-9A-Za-z~]+"))

;;; see http://www.nijino.com/ari/diary/?20020122&to=200201221#200201221

(defun my-convert-regexp-allow-ttp (regexp)
  "httpを含む正規表現をttpにもマッチする正規表現に変換する。"
  (if (string-match "http" regexp)
      (replace-match "h?ttp" nil nil regexp)
    regexp))

;; for browse-url-at-mouse
(eval-after-load "thingatpt"
  '(setq
    thing-at-point-url-regexp
    (my-convert-regexp-allow-ttp thing-at-point-url-regexp)))
(defadvice thing-at-point-url-at-point (after support-omitted-h activate)
  (when (and ad-return-value (string-match "\\`ttps?://" ad-return-value))
    (setq ad-return-value (concat "h" ad-return-value))))

;; for emacs-w3m
(eval-after-load "ffap"
  '(setq
    ffap-url-regexp
    (my-convert-regexp-allow-ttp ffap-url-regexp)))
(defadvice ffap-url-at-point (after support-omitted-h activate)
  (when (and ad-return-value (string-match "\\`ttps?://" ad-return-value))
    (setq ad-return-value (concat "h" ad-return-value))))

;; for SEMI
(eval-after-load "semi-def"
  '(setq
    mime-browse-url-regexp
    (my-convert-regexp-allow-ttp mime-browse-url-regexp)))

(defadvice browse-url (before support-omitted-h (url &rest args) activate)
  (or url
      (error "no url"))
  (when (string-match "\\`ttps?://" url)
    (setq url (concat "h" url))))

(eval-when-compile (require 'url))
(my-once-before url-hexify-string-cs require-url
  (require 'url))
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=url-hexify-string
;; (url-hexify-string-cs "検索") => "%8C%9F%8D%F5"
;; (url-hexify-string-cs " 検索" 'euc-jp) => "%B8%A1%BA%F7"
(defun url-hexify-string-cs (str &optional cs)
  "Escape characters in a string"
  (mapconcat
   (function
    (lambda (char)
      (if (not (memq char url-unreserved-chars))
          (if (< char 16)
              (upcase (format "%%0%x" char))
            (upcase (format "%%%x" char)))
        (char-to-string char))))
   (encode-coding-string str (or cs 'sjis)) ""))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
