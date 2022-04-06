;; [Wanderlust:14139]
;; Subject: Re: base64 (Re: 英語のUTF-8メールを読めない)
;; Date: Sat, 16 Dec 2006 03:07:28 +0900
(static-when nil (locate-library "mel")
  (require 'mime-def)
  (mel-define-method mime-decode-string (string (nil "base64"))
    (condition-case error
        (base64-decode-string string)
      (error
       (catch 'done
         (when (string-match "\\([A-Za-z0-9+/ \t\r\n]+\\)=*" string)
           (with-temp-buffer
             (insert (match-string 1 string))
             (dotimes (i 3)
               (condition-case nil
                   (progn
                     (base64-decode-region (point-min) (point-max))
                     (throw 'done (buffer-string)))
                 (error))
               (insert "="))))
         (signal (car error) (cdr error))))))
  )
