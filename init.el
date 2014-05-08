
;; Turn off interface stuff right away
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Setup config paths
(defvar dotfiles-dir (file-name-directory load-file-name))
(add-to-list 'load-path dotfiles-dir)

;; Load Cask (and all third party packages)
(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

;; Load PATH from shell environment
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(add-hook 'after-init-hook
 (lambda()
   (mapc 'load
         (directory-files (concat dotfiles-dir "modes/") 't "^[^#].*el$"))))

;; Load core stuff
(require 'jonanin)
(require 'jonanin-interface)
(require 'jonanin-input)
(require 'jonanin-binds)

;; start server for emacsclient
(server-start)

(setq-default flycheck-disabled-checkers '(scss c/c++-clang))

(provide 'init)
