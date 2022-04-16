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
        "^Received-SPF:"
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
        "^X-Enigmail-Version:"
        "^X-Mailman-Version:"
        "^In-Reply-To:"
        "^X-MSMail-Priority:"
        "^X-MimeOLE:"
        "^X-Spam-Checker-Version:"
        "^X-GitHub-Recipient:"
        "^X-GitHub-Recipient-Address:"
	"^X-Microsoft-Exchange-Diagnostics:"
	"^X-Microsoft-Antispam\\(-PRVS\\)?:"
	"^X-Exchange-Antispam-Report-\\(CFA-\\)?Test:"
	"^X-Forefront-\\(PRVS\\|Antispam-Report\\):"
	"^X-YMail-\\(JAS\\|OSG\\):"
	"^Autocrypt:"
	"^X-UI-\\(Sender-Class\\|Out-Filterresults\\):"
        ;; news.gmane.org
        "^Approved:"
        "^Original-Received:"
        "^Original-X-From:"
        "^X-Amavis-Spam-Status:"
        "^X-policyd-weight:"
        "^X-Rc-\\(Virus\\|Spam\\):"
	"^X-Wide-Eyed-Share:"
	"^X-MC-\\(Relay\\|Loop-Signature\\|Ingress-Time\\):"
        ))

;; 表示するヘッダの設定
;; `nil' なら、`mime-view-visible-field-list' の値を使用
(setq wl-message-ignored-field-list nil)
;; 'wl-message-ignored-field-list' より優先される
;(setq wl-message-visible-field-list '("^Message-Id:"))

;(setq wl-message-mode-line-format "Wanderlust: << %f / %n %F>> [%m]")
(setq wl-message-mode-line-format "WL: << %f / %n %F>> [%m]")

(add-hook
 'mime-view-mode-hook
 (lambda ()
   (local-set-key "j" (lambda () (interactive) (scroll-up 1)))
   (local-set-key "k" (lambda () (interactive) (scroll-down 1)))
   ))
