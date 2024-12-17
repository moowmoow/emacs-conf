;; (if (string-equal system-type "windows-nt")
;;     (progn
;;       (add-to-list 'exec-path "C:/tools/apache-maven-3.6.0/bin")
;;       ))

;; perl
;; (if (string-equal system-type "windows-nt")
;;     (progn
;;       (add-to-list 'exec-path (concat emacs-home "/misc/lang/perl/strawberry-perl-5.28.0.1-64bit-portable/perl/bin"))
;;       ))

;;(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'prog-mode-hook 'hl-line-mode)
(add-hook 'prog-mode-hook 'clean-aindent-mode)

(setq css-indent-offset 2)

;; Garbage Collection  (100MB)
(setq gc-cons-threshold 104857600)

(defun eval-region-or-buffer ()
  (interactive)
  (let ((debug-on-error t))
    (cond
     (mark-active
      (call-interactively 'eval-region)
      (message "Region evaluated!")
      (setq deactivate-mark t))
     (t
      (eval-buffer)
      (message "Buffer evaluated!")))))

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (local-set-key (kbd "C-x C-E") 'eval-region-or-buffer)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : dumb jump
;;
;; Dumb Jump is an Emacs "jump to definition" package with support
;; for 40+ programming languages that favors "just working". 
;;
;; SITE    : https://github.com/jacktasia/dumb-jump
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package dumb-jump
  :ensure t
  :bind
  (("M-g o" . dumb-jump-go-other-window)
   ("M-g j" . dumb-jump-go)
   ("M-g b" . dumb-jump-back)
   ("M-g i" . dumb-jump-go-prompt)
   ("M-g x" . dumb-jump-go-prefer-external)
   ("M-g z" . dumb-jump-go-prefer-external-other-window)
   )
  :config
  (setq dumb-jump-selector 'ivy)
  )

(use-package flycheck
  :ensure t
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : origami
;;
;; A text folding minor mode for Emacs.
;;
;; To some degree, yes. Currently out of the box support is provided for:
;; - C
;; - C++
;; - Clojure
;; - Go
;; - Java
;; - Javascript
;; - PHP
;; - Perl
;; - Python
;; - elisp
;;
;; SITE    : https://github.com/gregsexton/origami.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package origami
  :ensure t
  :custom
  (origami-show-fold-header t)
  :custom-face
  (origami-fold-replacement-face ((t (:inherit magit-diff-context-highlight))))
  (origami-fold-fringe-face ((t (:inherit magit-diff-context-highlight))))
  :init
  (defhydra origami-hydra (:color blue :hint none)
    "
      _:_: recursively toggle node       _a_: toggle all nodes    _t_: toggle node
      _o_: show only current node        _u_: undo                _r_: redo
      _R_: reset
      "
    (":" origami-recursively-toggle-node)
    ("a" origami-toggle-all-nodes)
    ("t" origami-toggle-node)
    ("o" origami-show-only-node)
    ("u" origami-undo)
    ("r" origami-redo)
    ("R" origami-reset)
    )
  :bind
  (:map origami-mode-map ("C-M-:" . origami-hydra/body))
  :config
  (face-spec-reset-face 'origami-fold-header-face)
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

(use-package lsp-mode
  :ensure t
  :hook
  (lsp-mode . lsp-enable-which-key-integration)
  (java-mode . #'lsp-deferred)
  :init
  (setq
   lsp-keymap-prefix "C-c l"
   lsp-enable-file-watchers nil
   read-process-output-max (* 1024 1024)
   lsp-completion-provider :capf
   lsp-idle-delay 0.500
   ;;lsp-eldoc-render-all nil
   ;;lsp-highlight-symbol-at-point nil
   )
  :config
  (setq lsp-intelephense-multi-root nil)
  (with-eval-after-load 'lsp-intelephense
    (setf (lsp--client-multi-root (gethash 'iph lsp-clients)) nil))
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
  )

(use-package lsp-ui
  :ensure t
  :after (lsp-mode)
  :bind
  (:map lsp-ui-mode-map
        ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
        ([remap xref-find-references] . lsp-ui-peek-find-references)
        )
  :init
  (setq
   lsp-ui-doc-delay 1.5
   lsp-ui-doc-position 'bottom
   lsp-ui-doc-max-width 100
   )
  ;;  :config
  ;;(define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  ;;(define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  ;; (lsp-ui-peek-find-workspace-symbol "pattern 0")
  ;; If the server supports custom cross references
  ;; (lsp-ui-peek-find-custom 'base "$cquery/base")
  ;;  (setq lsp-ui-doc-enable nil)
  ;;  (setq lsp-ui-sideline-enable nil)
  ;;  (setq lsp-ui-flycheck-enable t)
  )

(use-package yaml-mode
  :ensure t
  :mode (".yaml$")
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : flycheck-gradle
;;
;; Flycheck extension for gradle projects.
;;
;; SITE    : https://github.com/jojojames/flycheck-gradle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package flycheck-gradle
  :ensure t
  :commands (flycheck-gradle-setup)
  :init
  (mapc
   (lambda (x)
     (add-hook x #'flycheck-gradle-setup))
   '(java-mode-hook kotlin-mode-hook)))

;; (use-package flycheck-gradle
;;   :ensure t
;;   :commands (flycheck-gradle-setup)
;;   :init
;;   (mapc
;;    (lambda (x)
;;      (add-hook x #'flycheck-gradle-setup ))
;;    ;; '(java-mode-hook kotlin-mode-hook)
;;    )
;;   )


;; (if (string-equal system-type "windows-nt")
;;     (progn
;;       (add-to-list 'exec-path "C:/tools/apache-maven-3.6.0/bin")
;;       ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : cmake-ide
;;
;; cmake-ide is a package to enable IDE-like features on Emacs for CMake projects
;;
;; SITE    : https://github.com/atilaneves/cmake-ide
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package cmake-ide
  :ensure t
  :config
  (cmake-ide-setup)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : web-mode
;;
;; GROUP   : Programming
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package web-mode
  :ensure t
  :config
  ;; (setq web-mode-tag-auto-close-style 0)
  (setq web-mode-markup-indent-offset 2)    ; 태그 들여쓰기
  (setq web-mode-css-indent-offset 2)       ; css 들여쓰기
  (setq web-mode-code-indent-offset 2)      ; 스타일, 스크립트 들여쓰기
  (setq web-mode-style-padding 1)           ; 스타일 패딩
  (setq web-mode-script-padding 1)          ; 스크립트 패딩
  (setq web-mode-block-padding 0)           ; 블록 패딩
  (setq web-mode-comment-style 2)           ; 주석 스타일
  (setq web-mode-enable-auto-pairing t)     ; 자동 짝 만들기
  (setq web-mode-enable-css-colorization t) ; css 컬러링
  (setq web-mode-enable-auto-indentation nil) ; 자동 인덴트 취소

  ;;(add-to-list 'web-mode-indentation-params '"lineup-args" . nil))
  ;;(add-to-list 'web-mode-indentation-params '"lineup-calls" . nil))
  ;;(add-to-list 'web-mode-indentation-params '"lineup-concats" . nil))
  ;;(add-to-list 'web-mode-indentation-params '"lineup-ternary" . nil))

  (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))

  ;;(setq auto-mode-alist
  ;;      (append '(
  ;;                ("\\.\\(html\\|xhtml\\|shtml\\|tpl\\)\\'" . web-mode)
  ;;                ("\\.\\(php\\|phtml\\)\\'" . php-mode)
  ;;                )
  ;;              auto-mode-alist))
  ;; 라인 wrapping 설정
  (add-hook 'web-mode-hook 'toggle-truncate-lines nil)
  (add-hook 'web-mode-hook 'visual-line-mode nil)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : emmet-mode
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package emmet-mode
  :ensure t
  :config
  (add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
  (add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
  (add-hook 'web-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.

  (add-hook 'emmet-mode-hook
            (lambda()
              (define-key emmet-mode-keymap (kbd "C-j") nil)
              (define-key emmet-mode-keymap (kbd "C-M-j") 'emmet-expand-line)
              (define-key emmet-mode-keymap (kbd "C-M-;") 'emmet-expand-line)
              (define-key emmet-mode-keymap (kbd "<M-left>") 'emmet-prev-edit-point)
              (define-key emmet-mode-keymap (kbd "<M-right>") 'emmet-next-edit-point)
              ))

                                        ;(setq emmet-preview-default nil)
                                        ;(setq emmet-move-cursor-between-quotes t)
  )

;; perl
;; (if (string-equal system-type "windows-nt")
;;     (progn
;;       (add-to-list 'exec-path (concat emacs-home "/misc/lang/perl/strawberry-perl-5.28.0.1-64bit-portable/perl/bin"))
;;       ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : js2
;;
;; GROUP   : Programming
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package js2-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-hook 'js2-mode-hook 'toggle-truncate-lines nil)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : rjsx-mode
;;
;; This mode derives from js2-jsx-mode, extending tis parser to support JXS syntax according
;; to the official spec.
;;
;; SITE    : https://github.com/felipeochoa/rjsx-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package rjsx-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("components\\/.*\\.js\\'" . rjsx-mode))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : tern
;;
;; GROUP   : Programming
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package tern
  :ensure t
  :config
  (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
  (add-hook 'web-mode-hook (lambda () (tern-mode t)))
  )

(use-package tern-auto-complete
  :ensure t
  :config
  (add-hook 'js2-mode-hook (lambda () (auto-complete-mode)))
  (add-hook 'web-mode-hook (lambda () (auto-complete-mode)))
  (eval-after-load 'tern
    '(progn
       (require 'tern-auto-complete)
       (setq tern-ac-on-dot t)
       (tern-ac-setup)))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : vue-mode
;;
;; SITE : https://github.com/AdamNiederer/vue-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package vue-mode
  :ensure t
  :config
  (setq indent-tabs-mode nil
        js-indent-level 2)
  (add-hook 'vue-mode-hook #'lsp)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : pug-mode
;;
;; SITE : https://github.com/hlissner/emacs-pug-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package pug-mode
  :ensure t
  :config
  (setq pug-tab-width 2)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : jade-mode
;;
;; SITE : https://github.com/brianc/jade-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package jade-mode
  :ensure t
  )

(use-package typescript-mode
  :ensure t
  :config
  (setq typescript-indent-level 2)
  (add-hook 'typescript-mode-hook #'lsp)
  ;;(add-to-list 'auto-mode-alist '("\\.vue\\'" . typescript-mode))
  ;;(setq auto-mode-alist (delete '("\\.vue\\'" . typescript-mode) auto-mode-alist))
  )

(use-package ob-typescript
  :ensure t
  :config
  (setq org-babel-command:typescript "npx -p typescript -- tsc")
  )

(use-package ac-php-core
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : sql-indent
;;
;; sql-indent.el is a GNU Emacs minor mode which adds support for syntax-based indentation
;; when editing SQL code: TAB indents the current line based on the syntax of the SQL code on previous lines.
;; This works like the indentation for C and C++ code.
;;
;; SITE    : https://github.com/alex-hhh/emacs-sql-indent
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package sql-indent
  :ensure t
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : groovy-mode
;;
;;
;;
;; SITE    :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package groovy-mode
  :ensure t
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : slime
;;
;; SLIME is the Superior Lisp Interaction Mode for Emacs.
;;
;; SITE    : https://github.com/slime/slime
;;           https://common-lisp.net/project/slime/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package slime
  :ensure t
  :commands slime
  :init
  (setq inferior-lisp-program (or (executable-find "sbcl")
                                  (executable-find "/usr/bin/sbcl")
                                  (executable-find "/usr/local/bin/sbcl")
                                  "sbcl"
                                  ))
  :config
  (require 'slime-autoloads)
  (slime-setup '(slime-fancy))
  (add-hook 'slime-repl-mode-hook (lambda() (paredit-mode t)))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : blacken
;;
;; Use the python black package to reformat your python buffers.
;;
;; SITE    : https://github.com/pythonic-emacs/blacken
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package blacken
  :ensure t
  )

(setq css-indent-offset 2)
