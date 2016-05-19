(setq racer-cmd "~/.cargo/bin/racer")
(setq racer-rust-src-path "~/src/rustc-1.8.0/src")
(add-hook 'rust-mode-hook #'racer-mode)
