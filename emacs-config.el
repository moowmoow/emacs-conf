(require 'package)

(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

(package-initialize)
(setq package-check-signature nil)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(setq emacs-home (getenv "EMACS_HOME"))
;;(setq emacs-home "~/emacs")
(setq emacs-base (getenv "EMACS_BASE"))
(setq emacs-conf (getenv "EMACS_CONF"))
;;(setq emacs-conf "~/emacs/init")
;;(setq emacs-docs (getenv "EMACS_DOCS"))
(setq emacs-work (concat emacs-home "/work"))

;;(mapc 'load (directory-files-recursively (getenv "EMACS_PROP") ".\.el$"))

(defun init-config (path)
  (load (concat emacs-conf "/config/emacs-conf-" path ".el")))

(defun init-package (path)
  (load (concat emacs-conf "/packages/emacs-pkg-" path ".el")))

(defun init-function (path)
  (load (concat emacs-conf "/functions/emacs-func-" path ".el")))

(defun init-theme (path)
  (load (concat emacs-conf "/themes/emacs-theme-" path ".el")))

(message "load emacs-conf-global.org")
(org-babel-load-file "D:/gdrive/tools/emacs/emacs-29.1_2/emacs-conf/emacs-conf-global.org")

(message "load emacs-conf-system.org")
(org-babel-load-file "D:/gdrive/tools/emacs/emacs-29.1_2/emacs-conf/emacs-conf-system.org")

(message "load emacs-conf-edit.org")
(org-babel-load-file "D:/gdrive/tools/emacs/emacs-29.1_2/emacs-conf/emacs-conf-edit.org")

(message "load emacs-conf-help.org")
(org-babel-load-file "D:/gdrive/tools/emacs/emacs-29.1_2/emacs-conf/emacs-conf-help.org")

(message "load emacs-conf-interface.org")
(org-babel-load-file "D:/gdrive/tools/emacs/emacs-29.1_2/emacs-conf/emacs-conf-interface.org")

(message "load emacs-conf-navigation.org")
(org-babel-load-file "D:/gdrive/tools/emacs/emacs-29.1_2/emacs-conf/emacs-conf-navigation.org")

(message "load emacs-conf-file.org")
(org-babel-load-file "D:/gdrive/tools/emacs/emacs-29.1_2/emacs-conf/emacs-conf-file.org")

(message "load emacs-conf-tool.org")
(org-babel-load-file "D:/gdrive/tools/emacs/emacs-29.1_2/emacs-conf/emacs-conf-tool.org")

(message "load emacs-conf-face.org")
(org-babel-load-file "D:/gdrive/tools/emacs/emacs-29.1_2/emacs-conf/emacs-conf-face.org")

(message "load emacs-conf-project.org")
(org-babel-load-file "D:/gdrive/tools/emacs/emacs-29.1_2/emacs-conf/emacs-conf-project.org")

(message "load emacs-conf-term.org")
(org-babel-load-file "D:/gdrive/tools/emacs/emacs-29.1_2/emacs-conf/emacs-conf-term.org")

(message "load emacs-conf-programming.org")
(org-babel-load-file "D:/gdrive/tools/emacs/emacs-29.1_2/emacs-conf/emacs-conf-programming.org")

(message "load emacs-conf-text.org")
(org-babel-load-file "D:/gdrive/tools/emacs/emacs-29.1_2/emacs-conf/emacs-conf-text.org")

(message "load emacs-conf-vc.org")
(org-babel-load-file "D:/gdrive/tools/emacs/emacs-29.1_2/emacs-conf/emacs-conf-vc.org")
