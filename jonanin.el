;; Jonanin's emacs configuration
;; One file until I find categories worth splitting this up into

;; Smart Tabs (http://www.emacswiki.org/emacs/SmartTabs)
(setq-default tab-width 4)
(setq cua-auto-tabify-rectangles nil)
(setq c-default-style "linux")
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))


(defadvice align (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))

(defadvice align-regexp (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))

(defadvice indent-relative (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))

(defadvice indent-according-to-mode (around smart-tabs activate)
  (let ((indent-tabs-mode indent-tabs-mode))
    (if (memq indent-line-function
              '(indent-relative
                indent-relative-maybe))
        (setq indent-tabs-mode nil))
    ad-do-it))

(defmacro smart-tabs-advice (function offset)
  `(progn
     (defvaralias ',offset 'tab-width)
     (defadvice ,function (around smart-tabs activate)
       (cond
        (indent-tabs-mode
         (save-excursion
           (beginning-of-line)
           (while (looking-at "\t*\\( +\\)\t+")
             (replace-match "" nil nil nil 1)))
         (setq tab-width tab-width)
         (let ((tab-width fill-column)
               (,offset fill-column)
               (wstart (window-start)))
           (unwind-protect
               (progn ad-do-it)
             (set-window-start (selected-window) wstart))))
        (t
         ad-do-it)))))

(smart-tabs-advice c-indent-line c-basic-offset)
(smart-tabs-advice c-indent-region c-basic-offset)

;; Smart Tabs Python
(smart-tabs-advice python-indent-line-1 python-indent)
(add-hook 'python-mode-hook
		  (lambda ()
			(setq indent-tabs-mode t)
			(setq tab-width (default-value 'tab-width))))

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

;; coffee-script mode
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

;; the end
(provide 'jonanin)

