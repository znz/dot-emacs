;; 隠したいヘッダの設定
(setq mime-view-ignored-field-list
      '(".*Received:" ".*Path:" ".*Id:" "^References:"
        "^Replied:" "^Errors-To:"
        "^Lines:" "^Sender:" ".*Host:" "^Xref:"
        "^Content-Type:" "^Precedence:"
        "^Status:" "^X-VM-[^:]*:"
        "^X-UIDL:" "^X-Dispatcher:"
        "^Delivered-To:" "^Mailing-List:"
        "^X-ML-Info:"
        "^X-Loop:" "^X-List-Help:"
        "^X-Trace:" "^X-Complaints-To:"
        "^X-Comments[23]?:" "X-Report:" "X-Abuse-Info:"
        "^X-Mailing-List:"
        "^List-\\(Subscribe\\|Unsubscribe\\|Id\\|Post\\|Help\\|Archive\\|Software\\|Owner\\):"
        "^MIME-Version:"
        "^Content-Transfer-Encoding:"
        "^Content-Disposition:"
        "\\(DKIM\\|DomainKey\\)-Signature:"
        "^X-Priority:"
        "^Importance:"
        "^X-Original-To:"
        "^X-ML-Address:"
        "^X-MLServer:"
        "^X-QuickML:"
        "^X-ML-Name:"
        "^X-Mail-Count:"
        "^X-Ml-Count:"
        "^X-AntiAbuse:"
        "^X-Source\\(\\|-Args\\|-Dir\\):"
        "^X-Spam-\\(Status\\|Level\\|Score\\|Report\\):"
        "^X-SVN-SHA256-Info:"
        "^X-Virus-Scanned:"
        "^X-Quarantine:"
        "^X-BeenThere:"
        "^X-Mailman-Version:"
        "^In-Reply-To:"
        "^X-MSMail-Priority:"
        "^X-MimeOLE:"
        "^X-Spam-Checker-Version:"
        ))

;; 表示するヘッダの設定
;; `nil' なら、`mime-view-visible-field-list' の値を使用
(setq wl-message-ignored-field-list nil)
;; 'wl-message-ignored-field-list' より優先される
;(setq wl-message-visible-field-list '("^Message-Id:"))

; X-ML-Name: Wanderlust English
; X-Mail-Count: 00653
(when (locate-library "flow-fill")
  (autoload 'fill-flowed "flow-fill")
  (add-hook 'mime-display-text/plain-hook
            (lambda ()
              (when (string= "flowed"
                             (cdr (assoc "format"
                                         (mime-content-type-parameters
                                          (mime-entity-content-type entity)))))
                (fill-flowed))))
  ; For writing, (mime-edit-insert-tag "text" "plain" "; format=flowed")
  ; to insert mime tag.
  )

;(setq wl-message-mode-line-format "Wanderlust: << %f / %n %F>> [%m]")
(setq wl-message-mode-line-format "WL: << %f / %n %F>> [%m]")

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
