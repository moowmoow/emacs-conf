;; (setq browse-url-browser-function 'eww-browse-url)
;; (setq browse-url-browser-function (lambda (url session)
;;                                     ;; (other-windows 1)
;;                                     (xwidget-webkit-browse-url)
;;                                     ))
;;(setq browse-url-browser-function 'xwidget-webkit-browse-url)

;;(setq browse-url-chrome-program "C:/Program Files/Google/Chrome/Application/chrome.exe")
;;(setq browse-url-browser-handlers 'browse-url-crhome)
;;(setq browse-url-browser-function 'browse-url-crhome)
;;(setq browse-url-browser-function 'browse-url-firefox
;;browse-url-new-window-flag t
;;browse-url-firefox-new-window-is-tab t)

;;(setq browse-url-browser-function 'browse-url-generic
;;      browse-url-generic-program "web-browser")
(setq browse-url-browser-function 'my-browse)

(defun my-browse (url &rest ignore)
  "Browse URL using Chrome."
  (interactive "sURL: ")
  ;;(shell-command (concat "w3m " url))
  (shell-command (concat "chrome.exe " (concat "\"" (concat url "\""))))
  ;;(pop-to-buffer "*Shell Command Output*")
  (setq truncate-lines t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : restclient
;;
;; GROUP   : Programming > Tools > Magit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package restclient
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.http\\'" . restclient-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : company-restclient
;;
;; GROUP   :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package company-restclient
  :ensure t
  :config
  (require 'company-restclient)
  (add-to-list 'company-backends 'company-restclient))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : ob-restclient
;;
;; GROUP   :
;; SITE    : https://github.com/alf/ob-restclient.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package ob-restclient
  :ensure t
  :config)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : google-this
;;
;; google-this.el is a package that provides a set of functions and keybindings
;; for launching google searches from within emacs.
;;
;; SITE    : https://github.com/Malabarba/emacs-google-this
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package google-this
  :ensure t
  :config
  (google-this-mode 1)
  )

(use-package google-translate
  :ensure t
  :config
  (global-set-key (kbd "C-c t") 'google-translate-at-point)
  (global-set-key (kbd "C-c T") 'google-translate-at-point-reverse)
  (global-set-key (kbd "C-c M-t") 'google-translate-query-translate)
  (global-set-key (kbd "C-c M-T") 'google-translate-query-translate-reverse)

  (setq google-translate-output-destination nil)
  (setq google-translate-show-phonetic t)
  (setq google-translate-pop-up-buffer-set-focus t)
  ;; (setq google-translate-enable-ido-completion nil)

  ;; (setq google-translate-translation-directions-alist
  ;;       '(("en" . "ko") ("en" . "ja"))

  (setq google-translate-default-target-language "ko")

  ;; (set-face-attribute 'google-translate-text-face nil :height 1.0)
  ;; (set-face-attribute 'google-translate-translation-face nil :height 1.0)
  ;; (set-face-attribute 'google-translate-suggestion-face "underline")
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : plantuml-mode
;;
;; PlantUML is a component that allow to quickly write
;;
;; SITE    : https://github.com/skuro/plantuml-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package plantuml-mode
  :ensure t
  :after org
  ;; :mode ("\\.plantuml\\")
  :config
  (setq plantuml-jar-path "~/.emacs.d/plantuml/plantuml.jar"
        org-plantuml-jar-path "~/.emacs.d/plantuml/plantuml.jar")

  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
  (add-to-list 'auto-mode-alist '("\\.uml\\'" . plantuml-mode))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : mermaid-mode
;;
;; SITE    : https://github.com/abrochard/mermaid-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package mermaid-mode
  :ensure t
  :mode (("\\.mmd\\'" . mermaid-mode)
         ("\\.mermaid\\'" . mermaid-mode)))

(use-package ob-mermaid
  :ensure t
                                        ;:init
                                        ;(setq ob-mermaid-cli-path "~/bin.local/mermaid-cli/node_modules/.bin/mmdc.cmd")
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : elfeed
;;
;; Elfeed is an extensible web feed reader for Emacs, supporting both Atom and RSS.
;; It requires Emacs 24.3 and is available for download from MELPA or el-get.
;; Elfeed was inspired by notmuch.
;;
;; SITE    : https://github.com/skeeto/elfeed
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package elfeed
  :ensure t
  :config
  (global-set-key (kbd "C-x w") 'elfeed)
  (setq elfeed-feeds
        '("https://news.google.com/rss?hl=ko&gl=KR&ceid=KR:ko"))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : elfeed-web
;;
;; 
;;
;; SITE    : 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package elfeed-web
  :ensure t
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : elnode
;;
;; An evented IO webserver in Emacs Lisp.
;;
;; SITE    : https://github.com/nicferrier/elnode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package elnode
  :ensure t
  )
