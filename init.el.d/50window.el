;; helpなどのwindowを自動的にリサイズ
(static-when (functionp 'temp-buffer-resize-mode)
  (temp-buffer-resize-mode t))
