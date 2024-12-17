;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : ivy
;;
;; GROUP   : Convenience > Ivy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package ivy
  :ensure t
  :init
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  :config
  ;; ivy mode setting
  (ivy-mode t)
  ;; ivy-based interface to standard commands
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)

  ;; Ivy-based interface to shell and system tools
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)

  ;; Ivy-resume and other commands
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (add-hook 'ivy-occur-mode-hook 'toggle-truncate-lines nil)
  (add-hook 'ivy-occur-grep-mode-hook 'toggle-truncate-lines nil)
  )

(use-package counsel
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : emacs-counsel-tramp
;;
;; Tramp ivy interface for ssh server and docker and vagrant
;;
;;
;; SITE    : https://github.com/masasam/emacs-counsel-tramp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package counsel-tramp
  :ensure t
  :config
  (setq tramp-default-method "ssh")
  (define-key global-map (kbd "C-c s") 'counsel-tramp)

  ;; 시작 HOOK
  (add-hook 'counsel-tramp-pre-command-hook
            '(lambda ()
               ;; (global-aggressive-indent-mode 0)
               ;; (projectile-mode 0)
               ))

  ;; 종료 HOOK
  (add-hook 'counsel-tramp-quit-hook
            '(lambda ()
               ;; (global-aggressive-indent-mode 1)
               ;; (projectile-mode 1)
               ))

  ;; (setq make-backup-files nil)
  ;; (setq create-lockfiles nil)

  ;; connect with bash
  (eval-after-load 'tramp '(setenv "SELL" "/bin/bash"))

  ;; master path
  ;; (setq counsel-tramp-control-master-path (concat emacs-work "/.ssh"))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : helm
;;
;; GROUP   : Convenience > Helm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package helm
  :ensure t
  :config
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)
  (add-hook 'org-mode (lambda ()(define-key org-mode-map (kbd "C-S-h") 'helm-org-in-buffer-headings)))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : swiper
;;
;; GROUP   : Editing > Matching > Swiper
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package swiper
  :ensure t
  :config
  (global-set-key (kbd "C-s") 'swiper)
  (global-set-key (kbd "C-r") 'swiper-all))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : eyebrowse
;;
;; GROUP   : Convenience > Eyebrowse
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package eyebrowse
  :ensure t
  :config
  (eyebrowse-mode t)
  )

(use-package hydra
  :ensure t)

(use-package zoom
  :ensure t
  :config
  (zoom-mode t)
  (setq zoom-size '(0.618 . 0.618))
  )

(use-package sr-speedbar
  :ensure t)

(use-package sublimity
  :ensure t
  :config
  (require 'sublimity)
  ;;(require 'sublimity-scroll)
  ;;(require 'sublimity-map)
  (sublimity-mode 1)
  (setq sublimity-scroll-weight 10
        sublimity-scroll-drift-length 5)
  ;;(setq sublimity-map-size 10)
  ;;(setq sublimity-map-fraction 0.3)
  ;;(setq sublimity-map-text-scale -7)
  )
