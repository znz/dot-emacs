(cond
 ((file-directory-p (expand-file-name "~/howm/data"))
  (setq howm-directory (expand-file-name "~/howm/data")))
 (t (setq howm-directory nil)))

(when (and howm-directory (locate-library "howm"))
  (if (and
       (<= emacs-major-version 21)
       (string-match "\\`ja_JP\\.[Uu][Tt][Ff]-?8\\'" (getenv "LANG"))
       (not (featurep 'un-define)))
      (defadvice howm-menu (around my-howm-utf-8-without-mule-ucs activate)
        (error "utf-8 without mule-ucs!")))

  (setq howm-menu-lang 'ja)

  (autoload 'howm-mode "howm" "Hitori Otegaru Wiki Modoki" t)
  (global-set-key "\C-c,," 'howm-menu)
  (autoload 'howm-menu "howm" "Hitori Otegaru Wiki Modoki" t)
  (global-set-key "\C-c,c" 'howm-create)
  (autoload 'howm-create "howm" "Hitori Otegaru Wiki Modoki" t)

  (setq howm-keyword-file (expand-file-name ".howm-keys" howm-directory))
  ;; M-x howm-history で検索履歴. 各履歴から RET で飛べる (since 1.2.1)
  (setq howm-history-file "~/.howm-history.txt")
  ;; 検索履歴(M-x howm-history)の最大記録数
  ;(setq howm-history-limit 300)

  ;; RD形式にする。
  ;(setq howm-template "= %title%cursor\n%date %file\n")
  ;(setq howm-template "= %title%cursor\n%file\n")
  (setq howm-template "# -*- coding: utf-8 -*-\n= %title%cursor\n%file\n")
  (setq howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.howm")
  (setq howm-template-date-format "[%Y-%m-%d %H:%M:%S]")
  (add-to-list 'auto-mode-alist '("\\.howm\\'" . rd-mode)) ; メモは rd-mode に

  (add-hook
   'rd-mode-hook
   (lambda ()
     (when (string-match "\\.howm\\'" (buffer-file-name))
       (howm-mode t))))

  (setq howm-view-use-grep t)

  (setq howm-menu-file "menu-l.howm")
  (setq howm-menu-expiry-hours 1) ; メニューをキャッシュ
  (setq howm-menu-refresh-after-save nil) ; save 時にメニューを自動更新せず

  ;; 予定表の表示範囲
  (setq howm-menu-schedule-days-before 2)  ; ○日前から
  (setq howm-menu-schedule-days 21) ; ○日後まで
  ;; todo の表示件数
  (setq howm-menu-todo-num 100)

  ;; 全文検索のとき, メモに加えて指定ディレクトリ以下も再帰的に探す
  (setq howm-search-path
        '("~/Mail/.schedule" ; mhc で使っている。
          "~/News"))
  (setq howm-search-other-dir t) ; 下記のトグルの初期値 (t か nil)
  ;; M-x howm-toggle-search-other-dir で, 上記ディレクトリを検索対象にするかしないかトグル

  ;; 「http://」でリターン押したら, URL を kill-ring へ
  (setq action-lock-no-browser t)
  )
