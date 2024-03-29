;;; package --- Summary
;;; Commentary:
;;; Emacs init.

;;; Code:

;; Packages.
(require 'package)

(defvar package-list '(cider
                       clang-format
                       company
                       flycheck
                       glsl-mode
                       racket-mode
                       slime
                       slime-company
                       ;; themes
                       chocolate-theme
                       dracula-theme
                       enlightened-theme
                       faff-theme
                       inkpot-theme
                       nimbus-theme))

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(standard-display-ascii ?\t "--->")

;; Frame titles.
(setq frame-title-format
      (concat "%b - emacs@" (system-name)))

;; Spellcheck in text and latex mode.
(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
(dolist (hook '(latex-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))

;; Define special keys.
(global-set-key (kbd "<f6>") 'compile)
(global-set-key (kbd "<f7>") 'delete-trailing-whitespace)
(global-set-key (kbd "<f8>") 'clang-format-region)

(global-auto-revert-mode 1)
(setq inhibit-splash-screen t)
(setq diff-switches "-u")
(setq inhibit-default-init t)
(setq indent-tabs-mode nil)
(setq column-number-mode t)
(setq make-backup-files nil)
(setq-default word-wrap t)
(global-visual-line-mode t)
(setq-default show-trailing-whitespace t)
(setq ring-bell-function 'ignore)

;; File types.
(setq auto-mode-alist (append '(("\\.cu$" . c-mode))
                              auto-mode-alist))

;; (setq auto-mode-alist (append '(("\\.glsl$" . c-mode))
;;                               auto-mode-alist))

;; Turn on font-lock mode.
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

(defvar c-default-style '((other . "stroustrup")))

;; No tabs.
(setq-default indent-tabs-mode nil)

;; Packages.
(require 'clang-format)
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'after-init-hook 'global-company-mode)

;; Themes
(require 'faff-theme)

(provide 'init)
;;; init.el ends here
