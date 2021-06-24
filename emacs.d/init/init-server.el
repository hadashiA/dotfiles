(use-package server
  :config
  (unless (server-running-p) ;; 複数サーバ起動を防ぐ
  (server-start)))

