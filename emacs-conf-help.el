(global-set-key (kbd "C-h c") 'list-colors-display)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : whitch-key
;;
;; GROUP   : Hellp > Whitch Key
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package which-key
  :ensure t
  :config
  (which-key-mode t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : discover-my-major
;;
;; GROUP   : Help
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package discover-my-major
  :ensure t
  :config
  ;; hello world 단축키 취소
  (global-unset-key (kbd "C-h h"))
  (define-key 'help-command (kbd "h m") 'discover-my-major))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : helm-descbinds
;;
;; GROUP   : Convenience > Helm > Helm Descbinds
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package helm-descbinds
  :ensure t
  :config
  (global-set-key (kbd "C-h b") 'helm-descbinds)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : helm-describe-modes
;;
;; helm-describe-modes provides a Helm interface to Emacs’s describe-mode.
;; It lists the major mode, active minor modes,
;; and inactive minor modes using Helm, and provides actions for each mode.
;;
;; SITE    : https://github.com/emacs-helm/helm-describe-modes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package helm-describe-modes
  :ensure t
  :config
  (global-set-key [remap describe-mode] #'helm-describe-modes)
  )
