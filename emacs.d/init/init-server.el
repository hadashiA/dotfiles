(use-package server
  :init
  (unless (server-running-p) ;; 複数サーバ起動を防ぐ
  (server-start)))

