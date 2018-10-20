;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-
;;
;; This config is heavily influenced by the non-evil DOOM Emacs config of
;; UndeadKernel: https://github.com/UndeadKernel/emacs_doom_private
;; -------------------------------------------------------------------------- ;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Basic behaviour and appearance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Show trailing spaces
(setq-default show-trailing-whitespace t)

;; Disable trailing whitespaces in the minibuffer
(add-hook! '(minibuffer-setup-hook doom-popup-mode-hook)
  (setq-local show-trailing-whitespace nil))

;; Set tabs to indent as white spaces and set def. tab width to 4 white spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Minimalistic Emacs at startup
(menu-bar-mode 0)
(tool-bar-mode 0)
(set-scroll-bar-mode nil)

;; Resize windows interactively.
(def-package! resize-window
  :commands (resize-window))

;; Reuse dired buffers
(put 'dired-find-alternate-file 'disabled nil)

;; Smooth mouse scrolling
(setq mouse-wheel-scroll-amount '(2 ((shift) . 1))  ; scroll two lines at a time
      mouse-wheel-progressive-speed nil             ; don't accelerate scrolling
      mouse-wheel-follow-mouse t                    ; scroll window under mouse
      scroll-step 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Overall theme & visual behaviour
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Font setup
(setq doom-font (font-spec :family "Meslo LG M DZ for Powerline" :size 30)
      doom-variable-pitch-font (font-spec :family "Meslo LG M DZ for Powerline")
      doom-unicode-font (font-spec :family "DejaVu Sans Mono")
      doom-big-font (font-spec :family "Meslo LG M DZ for Powerline" :size 40))

;; All themes are safe to load
;(setq custom-safe-themes t)

;; Doom theme
(setq doom-theme 'doom-one)
;;(setq doom-theme 'doom-vibrant)
;;(setq doom-theme 'doom-nord)
;;(setq doom-theme 'doom-nova)
;;(setq doom-theme 'doom-dracula)
;;(setq doom-theme 'doom-solarized-light)
;;(setq doom-theme 'doom-sourcerer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq +org-dir "~/src/org/")

;; ORG config
(after! org
  (setq org-startup-folded nil ; do not start folded
        org-tags-column -100 ; the column to the right to align tags
        org-log-done 'time ; record the time when an element was marked done/checked
        org-fontify-done-headline nil ; do not change the font of DONE items
        org-ellipsis " ↴ "
        org-bullets-mode 1)

  ;; Custom org-capture templates
  ;; (add-to-list 'org-capture-templates
  ;;              '("s" "Snippets"
  ;;                (file "work/snippets.org") ; target
  ;;                ))

  (add-to-list 'org-capture-templates
               '("s" "Snippet"
                 entry  ; type
                 (file+headline "work/snippets.org" "SNIPPETs") ; target
                 "* %u %?\n%i" ; template
                 :prepend t :kill-buffer t)))

;; Org theme customization
(add-hook! org-mode
  ;; Document title font
  (set-face-attribute 'org-document-title nil :height 2.0)
  ;; Face of keyword DONE (Green like strings)
  (set-face-attribute 'org-done nil :foreground "#98be65")
  ;; Face of keyword TODO or [ ] (Purple like keywords)
  (set-face-attribute 'org-todo nil :foreground "#c678dd")
  ;; Face of ellipsis symbol (Purple like keywords)
  (set-face-attribute 'org-ellipsis nil :foreground "#c678dd")
  ;; Face of the entire headline of a DONE line
  (set-face-attribute 'org-headline-done nil :foreground nil)
  (cond
   ;; If doom-one theme is enabled
   ((custom-theme-enabled-p 'doom-one)
      ;; Change the style of the BEGIN_SRC and RESULT blocks
      (set-face-attribute 'org-block-begin-line nil
                          :background "#5c3d5c"
                          ;:foreground "#744d74"
                          :foreground "#5c3d5c"
                          :weight 'bold
                          :height 0.9
                          :box '(:line-width 2 :color "#5c3d5c")))
   ;; For other themes, disable the changes
   (t
      (set-face-attribute 'org-block-begin-line nil
                          :background unspecified
                          :foreground unspecified
                          :weight unspecified
                          :height unspecified
                          :box unspecified
                          :inherit org-meta-line))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Personalized bindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load! "+bindings")

;; TODO(dfrib): consider adding a +private.el file which will not be under
;; public version control.
;; (load! "+private" nil t) ; do not complain if file does not exist

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Popups
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Select popup buffers by default
(setq +popup-defaults
  (list :side   'bottom
        :height 0.16
        :width  40
        :quit   t
        :select t
        :ttl    5))

;; TODO(dfrib): See if I really feel that I need this customization?
;; Select the IList buffer when it is shown
(after! imenu-list
  (set-popup-rule! "^\\*Ilist"
    :side 'right :size 35 :quit nil :select t :ttl 0))

;; Larger undo tree window
(after! undo-tree
  (set-popup-rule! " \\*undo-tree\\*" :slot 2 :side 'right :size 40 :modeline nil :select t :quit t))

;; Larger org src edit
(after! org
  (set-popup-rule! "^\\*Org Src" :side 'bottom :slot -2 :height 0.6 :width 0.5 :select t :autosave t :ttl nil :quit nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load! "+functions")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; File templates
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom file templates
(setq +file-templates-dir "~/.doom.d/templates")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Backups and caching
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq make-backup-files t
      backup-by-copying t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Magit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(after! magit
  ;; Show differences at the word level when a hunk is selected.
  (setq magit-diff-refine-hunk t))
(add-hook! magit-mode (visual-line-mode +1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; IBuffer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(after! ibuffer
  ;; nearly all of this is the default layout
  (setq ibuffer-formats
        '((mark modified read-only " "
                (name 50 50 :left :elide) ; change: 30s were originally 18s
                " "
                (size 9 -1 :right)
                " "
                (mode 16 16 :left :elide)
                " " filename-and-process)
          (mark " "
                (name 16 -1)
                " " filename))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ag - The Silver Searcher
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(def-package! ag
  :defer t
  :init
  (setq ag-highlight-search t
        ag-reuse-buffers t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ivy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(after! ivy
  ;; Add a kill action to Ivy's buffer switching
  (ivy-set-actions 'ivy-switch-buffer '(("k" kill-buffer "kill")))
  ;; Add a kill action to DOOM's buffer switching
  (ivy-set-actions '+ivy/switch-workspace-buffer '(("k" kill-buffer "kill"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Spell checking
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Flyspell
;; this should be set to nil for performance
;; https://www.emacswiki.org/emacs/FlySpell
(setq flyspell-issue-message-flag nil)

;; Choose hunspell as our spell checker
(setq ispell-program-name "hunspell")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Flycheck
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Let flycheck search for required files in the `load-path' and the current folder.
(setq flycheck-emacs-lisp-load-path '("./"))

;; disable using hooks
(add-hook 'text-mode-hook (lambda ()
                            (flycheck-mode -1)))
(add-hook 'org-mode-hook (lambda ()
(flycheck-mode -1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LSP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LSP-Mode
(def-package! lsp-mode
  :commands (lsp-mode))

;; LSP-Company
(def-package! company-lsp
  :after lsp-mode)
(set-company-backend! '(c-mode c++-mode) '(company-lsp company-files company-yasnippet))
(after! lsp-mode
  (setq company-lsp-enable-snippet t)
  (setq company-lsp-cache-candidates nil)
  (setq company-lsp-async t))

;; LSP-Flycheck
(require 'lsp-ui-flycheck)
(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-after-open-hook (lambda () (lsp-ui-flycheck-enable 1))))
(add-hook 'c-mode-common-hook 'flycheck-mode) ;; Turn on flycheck for C++ buffers

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CCLS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TODO(dfrib): move the ccls path to private.
(def-package! ccls
  :commands (lsp-ccls-enable)
  :init
  :config
  (setq ccls-executable (expand-file-name "~/opensource/ccls/Release/ccls")
        ccls-cache-dir (concat doom-cache-dir ".ccls_cached_index")
        ccls-sem-highlight-method 'font-lock)
  (setq ccls-extra-args '("--log-file=/tmp/cc.log"))
  (setq ccls-extra-init-params
        '(:completion (:detailedLabel t) :xref (:container t)
                      :diagnostics (:frequencyMs 5000)))
  (set-company-backend! '(c-mode c++-mode) '(company-lsp))
  )
;; run ccls by default in C++ files
(defun ccls//enable ()
  (condition-case nil
      (lsp-ccls-enable)
    (user-error nil)))
  (use-package ccls
    :commands lsp-ccls-enable
:init (add-hook 'c-mode-common-hook #'ccls//enable))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CCLS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Open debugging window style
(setq gdb-many-windows t)
