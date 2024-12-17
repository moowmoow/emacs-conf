(use-package projectile
  :ensure t
  :config

  ;; projectile mode setting
  (projectile-mode +1)
  ;;(projectile-global-mode)

  ;; 키 바인딩
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

  ;; 프로젝트 타일 completion 세팅
  (setq projectile-completion-system 'ivy)

  ;; 캐싱 활성화
  (setq projectile-enable-caching t)

  ;; 인덱싱 방식 설정
  ;;(setq projectile-indexing-method 'alien)
  (setq projectile-indexing-method 'hybrid)
  (setq projectile-generic-command "fdfind -H --ignore-file .projectile -t f -0")
  (setq projectile-git-use-fd nil)
  )

(use-package counsel-projectile
  :ensure t
  :config
  (counsel-projectile-mode t)
  )

(use-package prodigy
  :ensure t)
