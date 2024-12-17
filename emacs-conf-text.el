;;(add-hook 'text-mode-hook 'linum-mode)
(add-hook 'text-mode-hook 'hl-line-mode)

(use-package org
  :ensure t
  :config
  (setq org-highlight-latex-and-related '(latex))
  ;;(setq org-src-fontify-natively nil)

  (define-key outline-minor-mode-map (kbd "<tab>") 'outline-cycle)

  ;; org-mode setting
  (setq org-src-fontify-natively t)
  ;;(org-block-begin-line ((t (:underline "#A7A6AA" :foreground "#008ED1" :background "#EAEAFF"))))
  ;;(org-block-background ((t (:background "#FFFFEA"))))
  ;;(org-block-end-line ((t (:overline "#A7A6AA" :foreground "#008ED1" :background "#EAEAFF"))))
  (defface org-block-begin-line
    '((t (:underline "#444" :foreground "#000000" :background "#444" :bold t :extend t)))
    "Face used for the line delimiting the begin of source blocks.")

  (defface org-block
    '((t (:foreground "#eee" :background "#222" :extend t)))
    "Face used for the source block background.")

  (defface org-block-background
    '((t (:foreground "#000" :background "#000")))
    "Face used for the source block background.")

  (defface org-block-end-line
    '((t (:overline "#333" :foreground "#000000" :background "#333" :bold t :extend t)))
    "Face used for the line delimiting the end of source blocks.")

  (setq org-todo-keywords
        '((sequencep "TODO(t)" "PROGRESS(p)" "COMPLETE(c)" "|" "DONE(d)")
          (sequencep "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")))

  (global-set-key (kbd "C-c a") 'org-agenda)

  ;;; 인라인에서 이미지를 출력할지 설정
  (setq org-startup-with-inline-images t)

  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (plantuml . t)
     (restclient . t)
     (mermaid . t)
     (typescript . t)
     ))

  (setq org-confirm-babel-evaluate nil)

  (add-hook 'org-babel-after-execute-hook
            (lambda ()
              (when org-inline-image-overlays
                (org-redisplay-inline-images))))

  ;; org-goto-auto-isearch disable
  (setq org-goto-auto-isearch nil)

  ;; imenu setting
  (global-set-key (kbd "C-c C-h") 'counsel-imenu)

  ;; 목록형 레벨에 따라 분류
  (setq org-list-demote-modify-bullet '(("+" . "-") ("-" . "+")))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : org-bullets
;;
;; GROUP   : Text > Org > Org Appearence > Org Bullets
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package org-bullets
  :ensure t
  :config
  ;; (require 'org-bullets)
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (add-hook 'org-mode-hook (lambda () (org-indent-mode 1))))

(use-package org-roam
  :ensure t
  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n c" . org-roam-capture)
         ("C-c n s" . org-roam-db-sync)
         (:map org-mode-map
               (("C-c n i" . org-roam-node-insert)
                ("C-c n o" . org-id-get-create)
                ("C-c n t" . org-roam-tag-add)
                ("C-c n a" . org-roam-alias-add)
                ("C-c n d c t" . org-roam-dailies-capture-today)
                ("C-c n d c d" . org-roam-dailies-capture-date)
                ("C-c n d g" . org-roam-dailies-goto-date)
                ("C-c n d t" . org-roam-dailies-goto-today)
                ("C-c n d w" . org-roam-dailies-goto-tomorrow)
                ("C-c n d y" . org-roam-dailies-goto-yesterday)
                ("C-c n l" . org-roam-buffer-toggle)
                ("C-c n L" . org-toggle-link-display)))))
:custom
(setq org-roam-directory "d:/gdrive/brain")
:config
(org-roam-db-autosync-enable)
(org-roam-db-autosync-mode)
(setq org-roam-completion-everywhere nil)
(setq org-roam-complete-link-at-point t)
;;(setq org-roam-completion-everywhere nil)
                                        ;org-roam-graph-exclude-matcher '("private" "repeaters" "dailies")
                                        ;org-roam-node-display-template "${doom-hierarchy:*} ${tags:45}")

(setq org-roam-capture-templates '(
                                   ("y" "Empty" plain "%?"
                                    :target (file+head "1_project/inbox/${slug}.org"
                                                       "#+title: ${title}\n")
                                    :unnarrowed t)

                                   ;;("d" "Default" plain "%?"
                                   ;;:target (file+head "1_project/inbox/%<%Y%m%d%H%M%S>_${slug}.org"
                                   ;;"#+title: ${title}\n")
                                   ;;:unnarrowed t)

                                   ("d" "Dashboard" plain "%?"
                                    :target (file+head "1_project/inbox/dashboard_${slug}.org"
                                                       "#+title: <DASHBOARD> ${title}\n")
                                    :unnarrowed t)

                                   ("l" "Backlog" plain "%?"
                                    :target (file+head "1_project/inbox/backlog_${slug}.org"
                                                       "#+title: <BACKLOG> ${title}\n")
                                    :unnarrowed t)

                                   ("m" "Agile - Theme" plain "%?"
                                    :target (file+head "1_project/inbox/theme_%<%y%m%d%H%M%S>_${slug}.org"
                                                       "#+title: <THEME-%<%y%m%d%H%M%S>> ${title}")
                                    :unnarrowed t)

                                   ("i" "Agile - Initiative" plain "%?"
                                    :target (file+head "1_project/inbox/initiative_%<%y%m%d%H%M%S>_${slug}.org"
                                                       "#+title: <INITIATIVE-%<%y%m%d%H%M%S>> ${title}")
                                    :unnarrowed t)

                                   ("e" "Agile - Epic" plain "%?"
                                    :target (file+head "1_project/inbox/epic_%<%y%m%d%H%M%S>_${slug}.org"
                                                       "#+title: <EPIC-%<%y%m%d%H%M%S>> ${title}")
                                    :unnarrowed t)

                                   ("s" "Agile - Story" plain "%?"
                                    :target (file+head "1_project/inbox/story_%<%y%m%d%H%M%S>_${slug}.org"
                                                       "#+title: <STORY-%<%y%m%d%H%M%S>> ${title}")
                                    :unnarrowed t)

                                   ("t" "Agile - Task" plain "%?"
                                    :target (file+head "1_project/inbox/task_%<%y%m%d%H%M%S>_${slug}.org"
                                                       "#+title: <TASK-%<%y%m%d%H%M%S>> ${title}")
                                    :unnarrowed t)

                                   ("a" "Article" plain "%?"
                                    :target (file+head "1_project/inbox/article_%<%y%m%d%H%M%S>_${slug}.org"
                                                       "#+title: <ARTICLE-%<%y%m%d%H%M%S>> ${title}")
                                    :unnarrowed t)

                                   ("f" "Feature" plain "%?"
                                    :target (file+head "1_project/inbox/feature_%<%y%m%d%H%M%S>_${slug}.org"
                                                       "#+title: <FEATURE-%<%y%m%d%H%M%S>> ${title}")
                                    :unnarrowed t)

                                   ("h" "Research" plain "%?"
                                    :target (file+head "1_project/inbox/research_%<%y%m%d%H%M%S>_${slug}.org"
                                                       "#+title: <RESEARCH-%<%y%m%d%H%M%S>> ${title}")
                                    :unnarrowed t)

                                   ("v" "Improvement" plain "%?"
                                    :target (file+head "1_project/inbox/improvement_%<%y%m%d%H%M%S>_${slug}.org"
                                                       "#+title: <IMPROVEMENT-%<%y%m%d%H%M%S>> ${title}")
                                    :unnarrowed t)

                                   ("b" "Bug" plain "%?"
                                    :target (file+head "1_project/inbox/bug_%<%y%m%d%H%M%S>_${slug}.org"
                                                       "#+title: <BUG-%<%y%m%d%H%M%S>> ${title}")
                                    :unnarrowed t)

                                   ("p" "Support" plain "%?"
                                    :target (file+head "1_project/inbox/support_%<%y%m%d%H%M%S>_${slug}.org"
                                                       "#+title: <SUPPORT-%<%y%m%d%H%M%S>> ${title}")
                                    :unnarrowed t)

                                   ("c" "concept" plain "%?"
                                    :target (file+head "1_project/inbox/concept_%<%Y%m%d%H%M%S>_${slug}.org"
                                                       "#+title: <CONCEPT> ${title}\n")
                                    :unnarrowed t)

                                   ("w" "wiki" plain "%?"
                                    :target (file+head "4_archive/wiki/wiki_${slug}.org"
                                                       "#+title: <WIKI> ${title}\n")
                                    :unnarrowed t)))

(setq org-roam-dailies-directory "/mnt/d/document/org-roam/1_project/daily/")

(setq org-roam-dailies-capture-templates
      '(
        ("d" "default" entry
         "* %?"
         :target (file+head "%<%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d>\n"))))

(org-roam-setup)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : markdown-mode
;;
;; 마크다운 모드
;;
;; SITE    : https://github.com/defunkt/markdown-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "/usr/bin/pandoc")
  :config
  (define-key markdown-mode-map (kbd "<M-S-right>") 'markdown-table-insert-column)
  (define-key markdown-mode-map (kbd "<M-S-left>") 'markdown-table-delete-column)
  (define-key markdown-mode-map (kbd "<M-S-up>") 'markdown-table-delete-row)
  (define-key markdown-mode-map (kbd "<M-S-down>") 'markdown-table-insert-row)
  (define-key markdown-mode-map (kbd "<M-right>") 'markdown-table-move-column-right)
  (define-key markdown-mode-map (kbd "<M-left>") 'markdown-table-move-column-left)
  (define-key markdown-mode-map (kbd "<M-up>") 'markdown-table-move-row-up)
  (define-key markdown-mode-map (kbd "<M-down>") 'markdown-table-move-row-down)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : easy-jekyll
;;
;;
;;
;; SITE    : https://github.com/masasam/emacs-easy-jekyll
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package easy-jekyll
  :ensure t
  :init
  (setq easy-jekyll-basedir "/mnt/d/document/blog/")
  (setq easy-jekyll-url "https://moowmoow.github.io/blog")
  :bind
  ("C-c C-e" . easy-jekyll)
  ;; (global-set-key (kbd "C-c C-e") 'easy-jekyll)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : markdown preview mode
;;
;; Minor mode to preview markdown output as you save
;;
;; SITE    : https://github.com/ancane/markdown-preview-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package markdown-preview-mode
  :ensure t
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : dockerfile-mode
;;
;; An emacs mode for handling Dockerfiles
;;
;; SITE    : https://github.com/spotify/dockerfile-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package dockerfile-mode
  :ensure t
  )

(setq nxml-child-indent 4)
(setq nxml-attribute-indent 4)
