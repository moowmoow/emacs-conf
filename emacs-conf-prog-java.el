(use-package cc-mode
  :ensure t
  )

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

(use-package company-lsp
  :ensure t
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : lsp-java
;;
;; LSP JAVA
;;
;; SITE    : https://github.com/emacs-lsp/lsp-java
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package lsp-java
  :ensure t
  :after lsp
  :config
  (add-hook 'java-mode-hook 'lsp)
  (setq lsp-java-vmargs
        (list
         "-noverify"
         "-Xmx4G"
         "-XX:+UseG1GC"
         "-XX:+UseStringDeduplication"
         "-javaagent:/path/to/lombok-1.18.6.jar"))
  ;; (use-package lsp-java-treemacs
  ;;   :after
  ;; (setq treemacs-icon-java nil)
  ;; (treemacs)
  ;; )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : helm-lsp
;;
;; This package provides alternative of the build-in lsp-mode
;; xref-appropos which provides as you type completion.
;;
;; SITE    : https://github.com/emacs-lsp/helm-lsp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package helm-lsp
  :ensure t
  :after lsp-java
  )

(use-package dap-mode
  :ensure t
  :after
  (lsp-mode)
  :functions dap-hydra/nil
  :config
  (require 'dap-java)
  :bind
  (:map lsp-mode-map
        ("<f5>" . dap-debug)
        ("M-<f5>" . dap-hydra)
        )
  :hook
  (dap-session-created . (lambda (&_rest) (dap-hydra)))
  (dap-terminated . (lambda (&_rest) (dap-hydra/nil)))
  ;;  (dap-ui-mode t)
  ;;  (use-package dap-java
  ;;    :after lsp-java
  ;;    :config
  ;;    (local-set-key (kbd "C-x M-x d") 'dap-java-debug)
  ;;    )
  )

;;(use-package dap-java :ensure t)
