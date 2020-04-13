;; set up straight.el

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; install use-package and configure it to use straight

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; set up theme

(use-package color-theme-sanityinc-tomorrow
  :config
  (load-theme 'sanityinc-tomorrow-night t))

;; set up font

(set-face-attribute 'default nil :family "Input" :height 140)

;; important stuff

(when window-system
  (blink-cursor-mode 0)                           ; Disable the cursor blinking
  (scroll-bar-mode 0)                             ; Disable the scroll bar
  (tool-bar-mode 0)                               ; Disable the tool bar
  (tooltip-mode 0))                                ; Disable the tooltips

(fringe-mode 0)                                    ; Disable fringes
(menu-bar-mode 0)                                ; Disable the menu bar

;; increase gc/related configs for lsp

(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))

;; edit this file

(defun find-config ()
  "Edit config.org"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "C-c I") 'find-config)

; set up other packages
;; org

(use-package org
  :bind
  ("C-c c" . org-capture)
  ("C-c b" . org-switchb)
  ("C-c a" . org-agenda)
  :config
  (require 'ox-md)
  :custom
  (org-directory "~/org")
  (org-default-notes-file "~/org/inbox.org")
  (org-agenda-files '("~/org/gtd"))
  (org-archive-location "~/org/gtd/archive/archive.org::* From %s")
  (org-refile-use-outline-path 'file)
  (org-refile-targets '((org-agenda-files . (:maxlevel . 1))))
  (org-capture-templates
      (quote (("t" "todo" entry (file "~/org/gtd/refile.org")
               "* TODO %?"))))
  (org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)"))))

;; rainbow-delimiters
(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

;; company

(use-package company
  :hook
  (after-init . global-company-mode)
  :custom
  company-dabbrev-downcase 0
  company-idle-delay 0)

;; projectile

(use-package projectile
  :hook
  (after-init . projectile-global-mode)
  :bind
  ("C-c p" . projectile-command-map)
  :init
  (setq-default
     projectile-cache-file (expand-file-name ".projectile-cache" user-emacs-directory)
     projectile-known-projects-file (expand-file-name ".projectile-bookmarks" user-emacs-directory))
  :custom
  (projectile-enable-caching t))

;; yaml

(use-package yaml-mode :mode "\\.yml\\'" "\\.yaml\\'")

;; magit

(use-package magit)

;; eyebrowse
(setq eyebrowse-keymap-prefix "C-c e")

(use-package eyebrowse
  :hook
  (after-init . eyebrowse-mode)
  :custom
  (eyebrowse-new-workspace t))

;; desktop

(use-package desktop
  :hook
  (after-init . desktop-read)
  (after-init . desktop-save-mode))

;; aggressive-indent

(use-package aggressive-indent
  :custom
  (aggressive-indent-comments-too t))

;; which-key

(use-package which-key
  :hook
  (after-init . which-key-mode))

;; ivy

(use-package ivy
  :hook
  (after-init . ivy-mode))

;; lsp (and it's glory suite)

(setq lsp-keymap-prefix "C-c l")

(use-package lsp-mode
  :hook
  ((js-mode . lsp-deferred)
   (python-mode . lsp-deferred)
   (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp lsp-deferred)

(use-package lsp-ui
  :commands lsp-ui-mode)

(use-package company-lsp
  :commands company-lsp)

(use-package lsp-ivy
  :commands lsp-ivy-workspace-symbol)

;; typescript/javascript (needs `npm install -g typescript-language-server`)
;; a hack too

(add-to-list 'exec-path (expand-file-name "~/.nodenv/shims"))

;; flycheck

(use-package flycheck
  :hook
  (js-mode . flycheck-mode)
  :custom
  (flycheck-check-syntax-automatically '(save mode-enabled))
  (flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  (flycheck-display-errors-delay .3))

;; manage versions better

(setq
  backup-by-copying t
  backup-directory-alist `(("." . ,(expand-file-name "backups/" user-emacs-directory)))
  auto-save-file-name-transforms `((".*" "~/.emacs.d/saves" t))
  delete-old-versions t
  version-control t
  kept-new-versions 10
  kept-old-versions 5)

;; hledger

(use-package hledger-mode
  :mode ("\\.journal\\'"))

;; windmove

(use-package windmove
  :bind
  (("C-M-<left>". windmove-left)
   ("C-M-<right>". windmove-right)
   ("C-M-<up>". windmove-up)
   ("C-M-<down>". windmove-down)))

;; org-super-agenda

(use-package org-super-agenda
  :hook
  (after-init . org-super-agenda-mode)
  :config
  (setq org-super-agenda-groups '((:name "Today"
				:time-grid t
				:scheduled today)
			   (:name "Due today"
				:deadline today)
			   (:name "Important"
				:priority "A")
			   (:name "Overdue"
				:deadline past)
			   (:name "Due soon"
				:deadline future)
			   (:name "Waiting"
			       :todo "WAIT"))))
