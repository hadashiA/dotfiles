(setq racer-cmd "~/.cargo/bin/racer"
      racer-rust-src-path "~/src/rustc-1.8.0/src")

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)

