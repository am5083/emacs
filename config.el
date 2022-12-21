;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
(require 'backup-walker)
(require 'cppref)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Ahmed Mohamed"
      user-mail-address "amohamed5083@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox-light)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb

(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'control)

(setq make-backup-files t
      vc-make-backup-files t
      version-control t
      kept-new-versions 256
      kept-old-versions 256
      delete-old-versions t
      backup-by-copying t)

(setq backup-dir (concat user-emacs-directory "backup/"))

(if (not (file-exists-p backup-dir))
    (make-directory backup-dir))

(add-to-list 'backup-directory-alist
             `(".*" . ,backup-dir))

(defun force-backup-of-buffer ()
  (setq buffer-backed-up nil))

(add-hook 'before-save-hook 'force-backup-of-buffer)

;; this is what tramp uses
(setq tramp-backup-directory-alist backup-directory-alist)

(setq autosave-dir (concat user-emacs-directory "autosaves/"))

(if (not (file-exists-p autosave-dir))
    (make-directory autosave-dir t))
(add-to-list 'auto-save-file-name-transforms
             `("\\`/?\\([^/]*/\\)*\\([^/]*\\)\\'" ,(concat autosave-dir "\\2") t))
;; tramp autosaves
(setq tramp-auto-save-directory (concat user-emacs-directory "tramp-autosaves/"))
(if (not (file-exists-p tramp-auto-save-directory))
    (make-directory tramp-auto-save-directory))

 (add-to-list 'load-path "/usr/local/share/emacs/site-lisp/maxima/")
 (autoload 'maxima-mode "maxima" "Maxima mode" t)
 (autoload 'imaxima "imaxima" "Frontend for maxima with Image support" t)
 (autoload 'maxima "maxima" "Maxima interaction" t)
 (autoload 'imath-mode "imath" "Imath mode for math formula input" t)
 (setq imaxima-use-maxima-mode-flag t)
 (add-to-list 'auto-mode-alist '("\\.ma[cx]" . maxima-mode))

(use-package! counsel
  :defer t
  :init
  (define-key!
    [remap projectile-compile-project] #'projectile-compile-project))

(setq-default c-basic-offset 4)
(c-set-offset 'innamespace 0)
(c-set-offset 'access-label 0)
(defun my-c-mode-common-hook ()
  (setq c-basic-offset 4)                  ;; Default is 2
  (setq c-indent-level 4)                  ;; Default is 2
  (setq cc-basic-offset 4)                  ;; Default is 2
  (setq cc-indent-level 4)                  ;; Default is 2

  (setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
  (setq tab-width 4))  ; use spaces only if nil




(c-set-offset 'innamespace 0)
(c-set-offset 'inclass 4)

;; Goto start of next function
(define-key evil-normal-state-map (kbd "]f") (lambda ()
                                               (interactive)
                                               (evil-textobj-tree-sitter-goto-textobj "function.outer")))
;; Goto start of previous function
(define-key evil-normal-state-map (kbd "[f") (lambda ()
                                               (interactive)
                                               (evil-textobj-tree-sitter-goto-textobj "function.outer" t)))
;; Goto end of next function
(define-key evil-normal-state-map (kbd "]F") (lambda ()
                                               (interactive)
                                               (evil-textobj-tree-sitter-goto-textobj "function.outer" nil t)))
;; Goto end of previous function
(define-key evil-normal-state-map (kbd "[F") (lambda ()
                                               (interactive)
                                               (evil-textobj-tree-sitter-goto-textobj "function.outer" t t)))

(setq ahmed/doc-open 'nil)

;(setq lsp-auto-configure t)
;(after! lsp (setq lsp-auto-configure t))
(after! lsp (setq +format-with-lsp nil))

(setq undo-fu-allow-undo-in-region t)

(after! lsp-clangd (set-lsp-priority! 'clangd 2))

(after! lsp-clangd (setq lsp-clients-clangd-args '("-j=16"
                                                   "--background-index"
                                                   "--enable-config"
                                                   "--clang-tidy"
                                                   "--fallback-style=\"{BasedOnStyle: LLVM, IndentWidth: 4}\""
                                                   "--completion-style=detailed"
                                                   "--header-insertion=never"
                                                   "--log=verbose"
                                                   "--header-insertion-decorators=0")))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(add-hook 'cpp-mode-common-hook 'my-c-mode-common-hook)

(set-lookup-handlers! 'c-mode
  :definition #'lsp-ui-peek-find-definitions
  :references #'lsp-ui-peek-find-references
  :documentation #'lsp-ui-doc-glance)

(set-lookup-handlers! 'cpp-mode
  :definition #'lsp-ui-peek-find-definitions
  :references #'lsp-ui-peek-find-references
  :documentation #'lsp-ui-doc-glance)


(setq +format-with-lsp nil)

(defun toggle-imenu ()
  (lsp-ui-imenu-buffer-mode 'toggle))

(map! :map lsp-ui-mode-map
      :nv "SPC c p" 'lsp-ui-doc-focus-frame)

(map! :map lsp-mode-map
      :nv "SPC c b" 'lsp-ui-imenu)

(map! :map lsp-mode-map
      :nv "SPC c l i k" 'lsp-ui-imenu--kill)

(map! :map lsp-mode-map
      :nv "SPC c l g o" 'lsp-clangd-find-other-file)

(defun ahmed/toggle-lsp-ui-doc ()
  (interactive)
  (if (equalp ahmed/doc-open 't)
        (progn
          (setq ahmed/doc-open 'nil)
          (lsp-ui-doc-hide))
        (progn
          (setq ahmed/doc-open 't)
          (lsp-ui-doc-show))))

(map! :nv "<mouse-2>" '+vterm/toggle)

(map! :map c++-mode-map
      :nv "<f1>" 'man)

(map! :map c++-mode-map
      :nv "<f2>" 'man-follow)

(map! :map c-mode-map
      :nv "<f5>" 'projectile-configure-project)

(map! :map c-mode-map
      :nv "<f5>" 'projectile-configure-project)

;; (setq lsp-ui-doc-enable nil)
;; (setq lsp-ui-peek-enable t)
;; (setq lsp-ui-sideline-enable t)
;; (setq lsp-ui-doc-enhanced-markdown t)
;; (setq lsp-ui-doc-show-with-mouse t)
;; (setq lsp-headerline-breadcrumb-enable t)
;; (setq lsp-ui-sideline-show-code-actions t)
;; (setq lsp-modeline-code-actions-enable t)
;; (setq lsp-ui-imenu-auto-refresh t)
;; (setq lsp-signature-auto-activate t)
;; (setq lsp-signature-render-documentation t)
;; (setq lsp-ui-doc-use-webkit t)

(after! lsp-ui
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-peek-enable t)
  (setq lsp-ui-sideline-enable t)
  (setq lsp-ui-doc-enhanced-markdown t)
  (setq lsp-ui-doc-show-with-mouse t)
  (setq lsp-ui-doc-show-with-cursor t)
  (setq lsp-headerline-breadcrumb-enable t)
  (setq lsp-ui-sideline-show-code-actions t)
  (setq lsp-modeline-code-actions-enable t)
  (setq lsp-ui-imenu-auto-refresh t)
  (setq lsp-signature-auto-activate t)
  (setq lsp-signature-render-documentation t)
  (setq lsp-ui-doc-header t)
  (setq lsp-ui-doc-include-signature t)
  (setq lsp-ui-doc-max-height 50))

(after! centaur-tabs (centaur-tabs-enable-buffer-reordering))
(setq centaur-tabs-adjust-buffer-order t)

(defun centaur-tabs-buffer-groups ()
  "`centaur-tabs-buffer-groups' control buffers' group rules.

    Group centaur-tabs with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
    All buffer name start with * will group to \"Emacs\".
    Other buffer group by `centaur-tabs-get-group-name' with project name."
  (list
   (cond
    ((or (string-equal "*" (substring (buffer-name) 0 1))
	 (memq major-mode '(magit-process-mode
			    magit-status-mode
			    magit-diff-mode
			    magit-log-mode
			    magit-file-mode
			    magit-blob-mode
			    magit-blame-mode
			    )))
     "Emacs")
    ((derived-mode-p 'prog-mode)
     "Editing")
    ((derived-mode-p 'dired-mode)
     "Dired")
    ((memq major-mode '(helpful-mode
			help-mode))
     "Help")
    ((memq major-mode '(org-mode
			org-agenda-clockreport-mode
			org-src-mode
			org-agenda-mode
			org-beamer-mode
			org-indent-mode
			org-bullets-mode
			org-cdlatex-mode
			org-agenda-log-mode
			diary-mode))
     "OrgMode")
    (t
     (centaur-tabs-get-group-name (current-buffer))))))

