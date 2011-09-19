;; Jonanin's emacs configuration
;; One file until I find categories worth splitting this up into

;; spacing settings
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq cua-auto-tabify-rectangles nil)
(setq c-default-style "linux")
;; auto indent
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Automtically decide tab size and spacing etc
(require 'guess-style)
(add-hook 'c-mode-common-hook 'guess-style-guess-all)
(global-guess-style-info-mode 1)

;; Interface stuff (from starter-kit)
(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (mouse-wheel-mode t)
  (blink-cursor-mode -1))

(add-hook 'before-make-frame-hook 'turn-off-tool-bar)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(ansi-color-for-comint-mode-on)

;; Enable computer clipboard
(setq x-select-enable-clipboard t)

;; Don't put backup files in every directory
(setq backup-directory-alist `(("." . ,(expand-file-name
                                        (concat dotfiles-dir "backups")))))

;; Paren matching
(show-paren-mode 1)
(setq show-paren-style 'expression)
(setq show-paren-delay 0)

;; Ido-mode
(ido-mode t)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-max-prospects 10)

;; Column numbers
(column-number-mode 1)

;; Smooth scrolling (from http://www.emacswiki.org/emacs/SmoothScrolling)
(require 'smooth-scrolling)

;; unique names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; color theme
(require 'color-theme)
(require 'color-theme-zenburn)
(setq color-theme-is-global t)
(color-theme-zenburn)

(defun coffee-custom ()
  "coffee-mode-hook"
  (make-local-variable 'tab-width)
  (set 'tab-width 2))

(add-hook 'coffee-mode-hook
  '(lambda() (coffee-custom)))


;; coffee-script mode
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

;; Javascript mode
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js2-mode-hook
  '(lambda() (
    (set js2-pretty-multiline-decl-indentation-p t)
    (set js2-consistent-level-indent-inner-bracket-p t))))

;; load magit
(require 'magit)

;; the end
(provide 'jonanin)

