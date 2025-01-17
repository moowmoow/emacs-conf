;; 탭사이즈 설정
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(init-function "edit")

(global-set-key (kbd "C-M-<up>") 'move-line-up)
(global-set-key (kbd "C-M-<down>") 'move-line-down)
(global-set-key (kbd "M-g M-c") 'go-to-column)
(global-set-key (kbd "C-c $") 'toggle-truncate-lines)
(global-set-key (kbd "C-\\") 'delete-horizontal-space-forward)
(global-set-key (kbd "M-\\") 'delete-horizontal-space)
(global-set-key (kbd "M-RET") 'file-name-on-clipboard)


(show-paren-mode t)
;;(setq evil-undo-system 'nil)

;; electric-pair-mode
(electric-pair-mode t)

(delete-selection-mode t)

;; diff-mode에서 중요한 화이트스페이스 보이게 하기
(add-hook 'diff-mode-hook (lambda ()
                            (setq-local whitespace-style
                                        '(face
                                          tabs
                                          tab-mark
                                          spaces
                                          space-mark
                                          trailing
                                          indentation::space
                                          indentation::tab
                                          newline
                                          newline-mark))
                            (whitespace-mode 1)))

(use-package iedit
  :ensure t
  :config
  (global-set-key (kbd "C-;") 'iedit-mode)
  )

(use-package yasnippet
  :ensure t
  :config
  ;; (setq yas-snippet-dirs
  ;;       '(
  ;;         '(concat emacs-home "/init/snippets")
  ;; ))
  (yas-global-mode 1)
  (add-to-list 'yas-snippet-dirs (concat emacs-conf "/snippets"))
  (yas-reload-all)
  (define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-ido-expand))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : ivy-yasnippet
;;
;; GROUP   : Convenience > Ivy-yasnippet
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package ivy-yasnippet
  :ensure t
  :config
  (global-set-key (kbd "C-h C-y") 'ivy-yasnippet)
  (setq ivy-yasnippet-expand-keys "always")
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : company
;;
;; GROUP   :
;; SITE    : https://github.com/iquiw/company-restclient
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package company
  :ensure t
  :hook (scala-mode . company-mode)
  :config
  (setq lsp-completion-provider :capf)
  ;;(add-hook 'after-init-hook 'global-company-mode)
  ;;(global-set-key "\t" 'company-complete-common)
  ;; (global-set-key (kbd "C-<tab>") 'company-complete-common)

  (define-key company-mode-map (kbd "C-c \\") 'company-complete)
  (define-key company-mode-map (kbd "C-c |") 'company-complete-common)

  ;; (add-hook 'ielm-mode-hook 'company-mode)
  (add-hook 'ielm-mode-hook 'company-mode)
  (add-hook 'ielm-mode-hook (lambda () (push 'company-elisp company-backends)))
  (add-hook 'lisp-interaction-mode-hook 'company-mode)
  (add-hook 'lisp-interaction-mode-hook (lambda () (push 'company-elisp company-backends)))
  (add-hook 'emacs-lisp-mode-hook 'company-mode)
  (add-hook 'emacs-lisp-mode-hook (lambda () (push 'company-elisp company-backends))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : company-quickhelp
;;
;; One of the things I missed the most when moving from auto-complete to company
;; was the documentation popups that would appear when idling on a completion candidate.
;; This package remedies that situation.
;;
;; SITE    : https://github.com/expez/company-quickhelp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package company-quickhelp
  :ensure t
  :after company
  :config
  (company-quickhelp-mode 1)
  )

(use-package auto-complete
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GROUP: Convenience > Whitespace
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package whitespace
  :ensure t
  :config
  ;; 불필요한 whitespace가 생성되면 whitespace 하이라이트
  (add-hook 'prog-mode-hook (lambda () (interactive) (setq show-trailing-whitespace t)))
  ;; whitepsace 모드 토클
  (global-set-key (kbd "C-c w") 'whitespace-mode)
  (global-set-key (kbd "C-c M-w c") 'whitespace-cleanup)
  (global-set-key (kbd "C-c M-w r") 'whitespace-cleanup-region)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : clean-aindent-mode
;;
;; GROUP   : Editing > Indent > Clean Aindent
;; SITE    : https://github.com/pmarinov/clean-aindent-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package clean-aindent-mode
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : undo-tree
;;
;; GROUP   : Editing > Undo > Undo Tree
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package undo-tree
  :ensure t
  :config
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
  (global-undo-tree-mode)
  ;;  (add-hook 'text-mode-hook #'undo-tree-mode)
  ;;  (add-hook 'prog-mode-hook #'undo-tree-mode)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : expand-region
;;
;; GROUP   : Convenience > Abbreviation > Expand
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package expand-region
  :ensure t
  :config
  ;; 영역을 확장
  (global-set-key (kbd "C-&") 'er/expand-region)
  ;; 영역을 축소
  (global-set-key (kbd "C-M-&") 'er/contract-region)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GROUP: Convenience > Hippe Expand
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; hippie-expand는 dabbrev-expand의 더 나은 버전입니다.
;; dabbrev-expand는 현재 버퍼들 그리고 다른 버퍼들에, 이미 입력한 단어들에 대해 검색하는데
;; hippie-expand는 파일이름, kill ring과 같은 더 많은 소스를 포함합니다.

(use-package hippie-exp
  :ensure
  :config
  (global-set-key (kbd "M-/") 'hippie-expand) ;;dabbrev-expand를 바꿈.

  (setq hippie-expand-try-functions-list
        '(
          try-expand-dabbrev                 ; 현재 버퍼를 검색하는데, “동적으로” 단어 확장.
          try-expand-dabbrev-all-buffers     ; 모든 다른 버퍼를 검색하는데 “동적으로” 단어를 확장.
          try-expand-dabbrev-from-kill       ; kill ring을 검색하는데, “동적으로” 단어를 확장.
          try-complete-file-name-partially   ; 고유한 문자 수 만큼, 파일이름으로 텍스트를 완성.
          try-complete-file-name             ; 파일이름으로 텍스트를 완성.
          try-expand-all-abbrevs             ; 모든 abbrev 테이블에 따라 point 전에 단어를 확장함.
          try-expand-list                    ; 현재 리스트를 버퍼에 전체 행으로 완성함.
          try-expand-line                    ; 현재 행을 버퍼에 전체 행으로 완성함.
          try-complete-lisp-symbol-partially ; 고유한 문자 수 만큼, Emacs Lisp symbol로써 완성.
          try-complete-lisp-symbol           ; Emacs Lisp symbol로써 단어를 완성함.
          )
        )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : session
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package session
  :ensure t
  :config
  (setq session-jump-undo-threshold 80)
  (global-set-key (kbd "C-c q") 'session-jump-to-last-change)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : smartparens
;;
;; GROUP   : Editing > Smartparens
;; SITE    : https://github.com/Fuco1/smartparens
;;           https://github.com/Fuco1/smartparens/wiki
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package smartparens
  :ensure t
  :config
  (require 'smartparens-config)
  (setq sp-base-key-bindings 'paredit)
  (setq sp-autoskip-closing-pair 'always)
  (setq sp-hybrid-kill-entrie-symbol nil)
  (sp-use-paredit-bindings)
  )

(use-package multiple-cursors
  :ensure t
  :config
  (global-set-key (kbd "C-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
  )

(use-package visual-regexp
  :ensure t
  :config
  (define-key global-map (kbd "C-c r") 'vr/replace)
  (define-key global-map (kbd "C-c q") 'vr/query-replace)
  (define-key global-map (kbd "C-c m") 'vr/mc-mark)
  )

(use-package aggressive-indent
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
  )

(use-package indent-guide
  :ensure t
  :config
  )

(use-package format-all
  :ensure t)

(use-package wgrep
  :ensure t
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : darkroom
;;
;; Remove visual distractions and focus on writing.
;;
;; SITE    : https://github.com/joaotavora/darkroom
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package darkroom
  :ensure t
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : goto-last-change
;;
;; allows you to move point through buffer-undo-list positions.
;;
;; SITE    : https://www.emacswiki.org/emacs/GotoLastChange
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package goto-last-change
  :ensure t
  :config
  (global-set-key (kbd "C-x C-\\") 'goto-last-change)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : goto-chg
;;
;;
;;
;; SITE    : https://github.com/emacs-evil/goto-chg
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package goto-chg
  :ensure t
  :config
  (global-set-key (kbd "C-x C-\\") 'goto-last-change)
  (global-set-key (kbd "C-x C-|") 'goto-last-change-reverse)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : edit-indirect
;;
;;
;;
;; SITE    : https://github.com/Fanael/edit-indirect
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package edit-indirect
  :ensure t
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : evil
;;
;; Evil is an extensible vi layer for Emacs. It emulates the main features of Vim,
;; and provides facilities for writing custom extensions.
;;
;; SITE    : https://github.com/emacs-evil/evil
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package evil
  :ensure t
  :init
                                        ;(setq evil-want-C-u-scroll t)
  :config
  (with-eval-after-load 'evil-maps (define-key evil-motion-state-map (kbd "TAB") nil)) 
  (evil-define-key 'normal org-mode-map (kbd "<tab>") #'org-cycle)
  (evil-define-key 'insert 'org-mode-map
    "C-t" 'org-metaleft
    "C-d" 'org-metaright
    "C" nil)
  (setq evil-want-C-i-jump nil)
  (global-set-key (kbd "C-M-<return>") 'evil-mode)
  (evil-set-undo-system 'undo-tree)
  (evil-mode t)
  )
