(prefer-coding-system 'utf-8)
;;(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;;(set-selection-coding-system 'utf-8)
(set-language-environment "UTF-8")
;;(setq default-process-coding-system '(utf-8 . utf-8))

(when (eq system-type 'windows-nt)
  (set-file-name-coding-system 'cp949-dos)
  ;;(set-file-name-coding-system 'w32-unicode-filenames)
  )

;;(set-file-name-coding-system 'utf-8)

;;(set-language-environment "Korean")
(setq default-input-method "korean-hangul390")
(setq default-korean-keyboard "390")

;; input 메서드 변경 단축키 설정
(global-set-key (kbd "<Hangul>") 'toggle-input-method)
(global-set-key (kbd "<kana>") 'toggle-input-method)
(global-set-key (kbd "<S-kana>") 'toggle-input-method)
(global-set-key (kbd "S-SPC") 'toggle-input-method)
(global-set-key (kbd "C-S-SPC") 'toggle-input-method)
;;(set-language-environment "Korean")
(setq default-input-method "korean-hangul390")
(setq default-korean-keyboard "390")

;; input 메서드 변경 단축키 설정
(global-set-key (kbd "<Hangul>") 'toggle-input-method)
(global-set-key (kbd "<kana>") 'toggle-input-method)
(global-set-key (kbd "<S-kana>") 'toggle-input-method)
(global-set-key (kbd "S-SPC") 'toggle-input-method)
(global-set-key (kbd "C-S-SPC") 'toggle-input-method)

(use-package el-get
  :ensure t
  )

(use-package disable-mouse
  :ensure t
  :config
  ;;(global-disable-mouse-mode)
  )

(use-package symon
  :ensure t
  :config
  ;; (symon-mode)
  )

(use-package system-packages
  :ensure t
  )

(use-package helm-system-packages
  :ensure t
  )
