;; 바 삭제
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; 시간 설정
(setq display-time-format "[%Y-%m-%d %H:%M:%S]")
(setq display-time-interval 1)
(display-time-mode 1)

;; 커서 깜박임 삭제
(blink-cursor-mode -1)

(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(column-number-mode t)

(add-to-list 'default-frame-alist '(height . 60))
(add-to-list 'default-frame-alist '(width . 200))
(set-frame-position (selected-frame) 80 20)

;; 프레임 타이틀을 경로로 표시
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

;; font setting
;; (set-face-font 'default "Bitstream Vera Sans Mono")
;; (set-face-attribute 'default nil :height 115)
;; (set-fontset-font t 'hangul (font-spec :name "NanumGothicCoding" :size 20))

;;(set-face-attribute 'default nil :family "DejaVu Sans Mono" :height 130)
(set-face-attribute 'default nil :family "Bitstream Vera Sans Mono" :height 115)
(set-fontset-font nil 'hangul (font-spec :family "D2Coding" :pixelsize 14))
(setq face-font-rescale-alist '(("D2Coding" . 1.2)))
;;(setq-default line-spacing 6)


(add-hook 'prog-mode-hook 'goto-address-mode)
(add-hook 'text-mode-hook 'goto-address-mode)

;; (defun x-led-mask ()
;;   "Get the current status of the LED mask from X."
;;   (with-temp-buffer
;;     (call-process "xset" nil t nil "q")
;;     (let ((led-mask-string
;;            (->> (buffer-string)
;;                 s-lines
;;                 (--first (s-contains? "LED mask" it))
;;                 s-split-words
;;                 -last-item)))
;;       (string-to-number led-mask-string 16))))

;; (defun caps-lock-on (led-mask)
;;   "Return non-nil if caps lock is on."
;;   (eq (logand led-mask 1) 1))

;; (define-minor-mode caps-lock-show-mode
;;   "Display whether caps lock is on."
;;   :global t
;;   :lighter (:eval (if (caps-lock-on (x-led-mask)) " CAPS-LOCK" "")))

;; 투명창
(when window-system
  (set-frame-parameter (selected-frame) 'alpha '(90 . 90))
  ;;(add-to-list 'default-frame-alist '(alpha . 90))
  )

;;(when (display-graphic-p)
;;  (require 'all-the-icons))
;; or
(use-package all-the-icons
  :ensure t
  )
;;:if (display-graphic-p))

(use-package paganini-theme
  :ensure t
  :config
  (load-theme 'paganini t)

                                        ;(setq frame-background-mode 'dark)

  (eval-after-load 'ansi-color
    '(progn
       (setq ansi-color-names-vector
             ["black" "tomato" "chartreuse1" "gold1"
              "DodgerBlue3" "MediumOrchid1" "cyan" "white"])
       (setq ansi-color-map (ansi-color-make-color-map))))

  ;; To make colors in term mode derive emacs' ansi color map
  (eval-after-load 'term
    '(let ((term-face-vector [term-color-black
                              term-color-red
                              term-color-green
                              term-color-yellow
                              term-color-blue
                              term-color-magenta
                              term-color-cyan
                              term-color-white]))
       (require 'ansi-color)
       (dotimes (index (length term-face-vector))
         (let ((fg (cdr (aref ansi-color-map (+ index 30))))
               (bg (cdr (aref ansi-color-map (+ index 40)))))
           (set-face-attribute (aref term-face-vector index) nil
                               :foreground fg
                               :background bg)))))

  ;;(setq ansi-term-color-vector [term term-color-black term-color-red term-color-green term-color-yellow term-color-blue term-color-magenta term-color-cyan term-color-white])

  (custom-theme-set-faces
   'paganini

   ;; org-table setting
   `(org-table ((t (:foreground "#eee" :background "#222"))))

   ;; org-block setting
   `(org-block ((t (:foreground "#eee" :background "#222"))))
   `(org-block-background ((t (:foreground "#000000" :background "#000000"))))
   `(org-block-begin-line ((t (:foreground "#000000" :background "#444" :bold t))))
   ;; `(org-block-begin-line ((t (:foreground "#000000" :background "#daa520" :bold t))))
   `(org-block-end-line ((t (:foreground "#000000" :background "#333" :bold t))))

   ;; Flycheck
   `(flycheck-error ((t (:background "#dd0000" :foreground "#eeeeee" :bold t :underline t))))
   `(flycheck-warnline ((t (:background "#ff8700" :foreground "#eeeeee" :bold t :underline t))))
   )

  (eval-after-load 'org
    '(progn
       (set-face-attribute 'org-level-1 nil :foreground "#ffd700" :background nil :bold t :height 1.0)
       (set-face-attribute 'org-level-2 nil :foreground "#ff8c00" :background nil :bold t :height 1.0)
       (set-face-attribute 'org-level-3 nil :foreground "#adff2f" :background nil :bold t :height 1.0)
       (set-face-attribute 'org-level-4 nil :foreground "#00ff00" :background nil :bold t :height 1.0)
       (set-face-attribute 'org-level-5 nil :foreground "#228b22" :background nil :bold t :height 1.0)
       (set-face-attribute 'org-level-6 nil :foreground "#7fffd4" :background nil :bold t :height 1.0)
       (set-face-attribute 'org-level-7 nil :foreground "#00ffff" :background nil :bold t :height 1.0)
       (set-face-attribute 'org-level-8 nil :foreground "#00ced1" :background nil :bold t :height 1.0))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : highlight-numbers
;;
;; GROUP   : Faces > Highlight Numbers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package highlight-numbers
  :ensure t
  :config
  (add-hook 'prog-mode-hook (lambda () (highlight-numbers-mode)))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : highlight-symbol
;;
;; GROUP   : Faces > Highlight Symbol
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package highlight-symbol
  :ensure t
  :config
  (highlight-symbol-nav-mode)

  ;; (add-hook 'prog-mode-hook (lambda () (highlight-symbol-mode)))
  (add-hook 'org-mode-hook (lambda () (highlight-symbol-mode)))

  (setq highlight-symbol-idle-delay 0.2
        highlight-symbol-on-navigation-p t)

  (global-set-key [(control shift mouse-1)]
                  (lambda (event)
                    (interactive "e")
                    (goto-char (posn-point (event-start event)))
                    (highlight-symbol-at-point)))

  (global-set-key (kbd "M-n") 'highlight-symbol-next)
  (global-set-key (kbd "M-p") 'highlight-symbol-prev)
  )

(use-package rainbow-mode
  :ensure t
  :config
  (add-hook 'html-mode-hook 'rainbow-mode)
  (add-hook 'css-mode-hook 'rainbow-mode)
  (add-hook 'web-mode-hook 'rainbow-mode))

(use-package rainbow-blocks
  :ensure t)

(use-package rainbow-identifiers
  :ensure t)

(use-package rainbow-delimiters
  :ensure t)

(use-package nyan-mode
  :ensure t
  :config
  (nyan-mode t))

(use-package volatile-highlights
  :ensure t
  :config
  (volatile-highlights-mode t)
  )

(use-package dimmer
  :ensure t
  :config
  (dimmer-mode)
  (setq dimmer-percent 0.2)
  )

(use-package focus
  :ensure t)

(use-package linum-relative
  :ensure t
  :config
  ;;(setq linum-relative-backend 'linum-mode)
  ;;(linum-on)
  (linum-relative-global-mode)
  )

(use-package yascroll
  :ensure t
  :config
  (global-yascroll-bar-mode 1)
  )

(use-package doom-modeline
  :ensure t
  :hook
  (after-init . doom-modeline-mode)
  :config
  ;; How tall the mode-line should be. It's only respected in GUI.
  ;; If the actual char height is larger, it respects the actual height.
  (setq doom-modeline-height 10)

  ;; How wide the mode-line bar should be. It's only respected in GUI.
  (setq doom-modeline-bar-width 3)

  ;; How to detect the project root.
  ;; The default priority of detection is `ffip' > `projectile' > `project'.
  ;; nil means to use `default-directory'.
  ;; The project management packages have some issues on detecting project root.
  ;; e.g. `projectile' doesn't handle symlink folders well, while `project' is unable
  ;; to hanle sub-projects.
  ;; You can specify one if you encounter the issue.
  (setq doom-modeline-project-detection 'project)

  ;; Determines the style used by `doom-modeline-buffer-file-name'.
  ;;
  ;; Given ~/Projects/FOSS/emacs/lisp/comint.el
  ;;   truncate-upto-project => ~/P/F/emacs/lisp/comint.el
  ;;   truncate-from-project => ~/Projects/FOSS/emacs/l/comint.el
  ;;   truncate-with-project => emacs/l/comint.el
  ;;   truncate-except-project => ~/P/F/emacs/l/comint.el
  ;;   truncate-upto-root => ~/P/F/e/lisp/comint.el
  ;;   truncate-all => ~/P/F/e/l/comint.el
  ;;   relative-from-project => emacs/lisp/comint.el
  ;;   relative-to-project => lisp/comint.el
  ;;   file-name => comint.el
  ;;   buffer-name => comint.el<2> (uniquify buffer name)
  ;;
  ;; If you are experiencing the laggy issue, especially while editing remote files
  ;; with tramp, please try `file-name' style.
  ;; Please refer to https://github.com/bbatsov/projectile/issues/657.
  (setq doom-modeline-buffer-file-name-style 'truncate-upto-project)

  ;; Whether display icons in mode-line. Respects `all-the-icons-color-icons'.
  ;; While using the server mode in GUI, should set the value explicitly.
  (setq doom-modeline-icon (display-graphic-p))

  ;; Whether display the icon for `major-mode'. Respects `doom-modeline-icon'.
  (setq doom-modeline-major-mode-icon t)

  ;; Whether display the colorful icon for `major-mode'.
  ;; Respects `doom-modeline-major-mode-icon'.
  (setq doom-modeline-major-mode-color-icon t)

  ;; Whether display the icon for the buffer state. It respects `doom-modeline-icon'.
  (setq doom-modeline-buffer-state-icon t)

  ;; Whether display the modification icon for the buffer.
  ;; Respects `doom-modeline-icon' and `doom-modeline-buffer-state-icon'.
  (setq doom-modeline-buffer-modification-icon t)

  ;; Whether to use unicode as a fallback (instead of ASCII) when not using icons.
  (setq doom-modeline-unicode-fallback nil)

  ;; Whether display the minor modes in mode-line.
  (setq doom-modeline-minor-modes (featurep 'minions))

  ;; If non-nil, a word count will be added to the selection-info modeline segment.
  (setq doom-modeline-enable-word-count nil)

  ;; Major modes in which to display word count continuously.
  ;; Also applies to any derived modes. Respects `doom-modeline-enable-word-count'.
  ;; If it brings the sluggish issue, disable `doom-modeline-enable-word-count' or
  ;; remove the modes from `doom-modeline-continuous-word-count-modes'.
  (setq doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode))

  ;; Whether display the buffer encoding.
  (setq doom-modeline-buffer-encoding t)

  ;; Whether display the indentation information.
  (setq doom-modeline-indent-info nil)

  ;; If non-nil, only display one number for checker information if applicable.
  (setq doom-modeline-checker-simple-format t)

  ;; The maximum number displayed for notifications.
  (setq doom-modeline-number-limit 99)

  ;; The maximum displayed length of the branch name of version control.
  (setq doom-modeline-vcs-max-length 12)

  ;; Whether display the perspective name. Non-nil to display in mode-line.
  (setq doom-modeline-persp-name t)

  ;; If non nil the default perspective name is displayed in the mode-line.
  (setq doom-modeline-display-default-persp-name nil)

  ;; Whether display the `lsp' state. Non-nil to display in mode-line.
  (setq doom-modeline-lsp t)

  ;; Whether display the GitHub notifications. It requires `ghub' package.
  (setq doom-modeline-github nil)

  ;; The interval of checking GitHub.
  (setq doom-modeline-github-interval (* 30 60))

  ;; Whether display the modal state icon.
  ;; Including `evil', `overwrite', `god', `ryo' and `xah-fly-keys', etc.
  (setq doom-modeline-modal-icon t)

  ;; Whether display the mu4e notifications. It requires `mu4e-alert' package.
  (setq doom-modeline-mu4e t)

  ;; Whether display the IRC notifications. It requires `circe' or `erc' package.
  (setq doom-modeline-irc t)

  ;; Function to stylize the irc buffer names.
  (setq doom-modeline-irc-stylize 'identity)

  ;; Whether display the environment version.
  (setq doom-modeline-env-version t)
  ;; Or for individual languages
  (setq doom-modeline-env-enable-python t)
  (setq doom-modeline-env-enable-ruby t)
  (setq doom-modeline-env-enable-perl t)
  (setq doom-modeline-env-enable-go t)
  (setq doom-modeline-env-enable-elixir t)
  (setq doom-modeline-env-enable-rust t)

  ;; Change the executables to use for the language version string
  (setq doom-modeline-env-python-executable "python") ; or `python-shell-interpreter'
  (setq doom-modeline-env-ruby-executable "ruby")
  (setq doom-modeline-env-perl-executable "perl")
  (setq doom-modeline-env-go-executable "go")
  (setq doom-modeline-env-elixir-executable "iex")
  (setq doom-modeline-env-rust-executable "rustc")

  ;; What to dispaly as the version while a new one is being loaded
  (setq doom-modeline-env-load-string "...")

  ;; Hooks that run before/after the modeline version string is updated
  (setq doom-modeline-before-update-env-hook nil)
  (setq doom-modeline-after-update-env-hook nil)
  )
