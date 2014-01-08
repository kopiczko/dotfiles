;; emacs-kicker
;; https://github.com/dimitri/emacs-kicker/blob/master/init.el
;; emacs-prelude
;; https://github.com/bbatsov/prelude

(package-initialize)
(require 'cl)                                ; common lisp goodies, loop

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

;; now either el-get is `require'd already, or have been `load'ed by the
;; el-get installer.

;; set local recipes
(setq
 el-get-sources
 '((:name ctable                                 ; jedi dep
          :description "Table Component for elisp"
          :type github
          :pkgname "kiwanami/emacs-ctable")
   (:name epc                                    ; jedi dep
          :description "An RPC stack for Emacs Lisp"
          :type github
          :pkgname "kiwanami/emacs-epc"
          :depends (deferred ctable)) ; concurrent is in deferred package
   (:name jedi                                   ; jedi
          :description "An awesome Python auto-completion for Emacs"
          :type github
          :pkgname "tkf/emacs-jedi"
          :build (("make" "requirements"))
          :depends (epc auto-complete)
          :after (progn
                   (add-hook 'python-mode-hook 'jedi:setup)
                   (setq jedi:setup-keys t)         ; optional
                   (setq jedi:complete-on-dot t)))  ; optional
   (:name flycheck
          :after (progn
                   ;;(add-hook 'after-init-hook #'global-flycheck-mode) ;; enable Flycheck mode in all buffers, in which it can be used
                   (add-hook 'python-mode-hook 'flycheck-mode)
                   (setq flycheck-flake8-maximum-line-length 120)))
   (:name buffer-move                        ; have to add your own keys
          :after (lambda ()
                   (global-set-key (kbd "<C-S-up>") 'buf-move-up)
                   (global-set-key (kbd "<C-S-down>") 'buf-move-down)
                   (global-set-key (kbd "<C-S-left>") 'buf-move-left)
                   (global-set-key (kbd "<C-S-right>") 'buf-move-right)))
   (:name smex                                ; a better (ido like) M-x
          :after (lambda ()
                   (setq smex-save-file "~/.emacs.d/.smex-items")
                   (global-set-key (kbd "M-x") 'smex)
                   (global-set-key (kbd "M-X") 'smex-major-mode-commands)))
   (:name magit                                ; git meet emacs, and a binding
          :after (lambda ()
                   (global-set-key (kbd "C-x C-z") 'magit-status)))
   (:name goto-last-change                ; move pointer back to last change
          :after (lambda ()
                   ;; when using AZERTY keyboard, consider C-x C-_
                   (global-set-key (kbd "C-x C-/") 'goto-last-change)))))


;; now set our own packages
(setq
 my:el-get-packages
 '(el-get                            ; el-get is self-hosting
   ;; escreen                         ; screen for emacs, C-\ C-h
   rbenv
   switch-window                     ; takes over C-x
   ace-jump-mode
   multiple-cursors
   highlight-current-line
   highlight-indentation
   highlight-parentheses
   rainbow-mode
   rainbow-delimiters
   magit
   grizzl
   projectile
   auto-complete                     ; complete as you type with overlays
   ag
   scala-mode2
   ensime
   enh-ruby-mode
   robe-mode
   smartparens
   flycheck
   jedi
   ;; zencoding-mode                  ; http://www.emacswiki.org/emacs/ZenCoding
   bash-completion
   color-theme                       ; nice looking emacs
   color-theme-tangotango))          ; check out color-theme-solarized

;; install new packages and init already installed packages
(el-get 'sync my:el-get-packages)

;; -----------------------------------------------------------------------------
;; Look & Feel
;; -----------------------------------------------------------------------------

;; Remove bars
(unless (string-match "apple-darwin" system-configuration)
  ;; on mac, there's always a menu bar drown, don't have it empty
  (menu-bar-mode -1))
(tool-bar-mode -1)     ; no tool bar with icons
(scroll-bar-mode -1)   ; no scroll bars
;; Theme (check if theme is installed by el-get.el)
(add-to-list 'custom-theme-load-path "~/.emacs.d/el-get/color-theme-tangotango")
(load-theme 'tangotango t)
;; Font
(if window-system
    (if (string-match "apple-darwin" system-configuration)
        (set-face-font 'default "Monaco-13")
      (set-face-font 'default "Monospace-11")))

;; cursor colors
(set-cursor-color "#ff0000")
;; Display continuous lines
(setq-default truncate-lines nil)
;; Do not use tabs for indentation
(setq-default indent-tabs-mode nil)

;; -----------------------------------------------------------------------------
;; Remove whitespaces at the end of file
;; -----------------------------------------------------------------------------
(add-hook 'before-save-hook 'whitespace-cleanup)

;; -----------------------------------------------------------------------------
;; Unique buffer names
;; -----------------------------------------------------------------------------
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)

;; -----------------------------------------------------------------------------
;; Clipboard
;; -----------------------------------------------------------------------------
(defun copy-from-x11 ()
  (call-process "/usr/bin/xsel" nil t nil "-b"))

(defun paste-to-x11 (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "xsel" "*Messages*" "/usr/bin/xsel" "-ib")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-x11)
(setq interprogram-paste-function 'copy-from-x11)


;; ----------------------------------------------------------------------------
;; Terminal & File Manager
;; ----------------------------------------------------------------------------

(setq terminal-program "/usr/bin/rxvt-unicode")
(setq terminal-fm-program "/usr/bin/ranger")

(defun buffer-dir-name ()
  (file-name-directory buffer-file-name))

(defun terminal-option-buffer-dir ()
  (let ((dir (buffer-dir-name)))
    `("-cd" ,dir)))

(setq terminal-option-ranger '("-e" terminal-fm-program))

(defun run-terminal ()
  (interactive)
  (start-process "terminal" "*Messages*" terminal-program) (terminal-option-buffer-dir))

(defun run-file-manager ()
  (interactive)
  (let ((args (append (terminal-option-buffer-dir) terminal-option-ranger)))
    (message (second args))
    (apply 'start-process "filemanager" "*Messages*" terminal-program args)))

;; ACE jump
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; Smartparens
(require 'smartparens-config)
(require 'smartparens-ruby)
(smartparens-global-mode 1)

;; Rainbow Mode
(require 'rainbow-mode)
(rainbow-mode 1)

;; Rainbow delimiters
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode 1)

;; Projectile
(require 'grizzl)
(require 'projectile)
(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-completion-system 'grizzl)
;; Press Command-p for fuzzy find in project
(global-set-key (kbd "M-p") 'projectile-find-file)
;; Press Command-b for fuzzy switch buffer
(global-set-key (kbd "C-x C-b") 'projectile-switch-to-buffer)

;; AC mode
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(setq ac-ignore-case t)
(append ac-modes '('enh-ruby-mode
                   'python-mode
                   'web-mode))

;; Magit
;;(magit-file-header ((t (:foreground "violet"))))
;;(magit-hunk-header ((t (:foreground "blue"))))
;;(magit-header ((t (:foreground "cyan"))))
;;(magit-tag-label ((t (:background "blue" :foreground "orange"))))
;;(magit-diff-add ((t (:foreground "MediumSlateBlue"))))
;;(magit-diff-del ((t (:foreground "maroon"))))
;;(magit-item-highlight ((t (:background "#000012"))))

;; Exchange point and mark hack
(defun exchange-point-and-mark-no-activate ()
  "Identical to \\[exchange-point-and-mark] but will not activate the region."
  (interactive)
  (exchange-point-and-mark)
  (deactivate-mark nil))
;;(define-key global-map [remap exchange-point-and-mark] 'exchange-point-and-mark-no-activate)
;;(global-unset-key (kbd "C-x C-x"))
(global-set-key (kbd "C-x C-x") 'exchange-point-and-mark-no-activate)

;; magit
(require 'magit)
(global-set-key (kbd "C-x v g") 'magit-status)

;; ensime
(require 'ensime)

;; rbenv
(require 'rbenv)
(global-rbenv-mode)

(require 'ido)
(ido-mode t)
(put 'upcase-region 'disabled nil)

;; dired
(require 'dired)
(add-hook 'dired-mode-hook 'ensure-buffer-name-starts-with-dired)
(defun ensure-buffer-name-starts-with-dired ()
  "change buffer name to start with 'dired|'"
  (let ((name (buffer-name)))
    (if (not (string-match "/$" name))
        (rename-buffer (concat "dired|" name)))))
