;;(setq find-program "d:\\tools\\cygwin64\\bin\\find.exe")
;;(setq grep-program "d:\\tools\\cygwin64\\bin\\grep.exe")

(setq large-file-warning-threshold 104857600) ; 파일 사이즈 제한 (100MB)

;;(defvar backup-directory "~/.backup")

;;(if (not (file-exists-p backup-directory))
;;(make-directory backup-directory t))

;; (setq auto-save-default nil)
;; (setq make-backup-files nil)

;; (setq backup-by-copying t
;;       backup-directory-alist '((".*" . ,"~/.backup/"))
;;       auto-save-file-name-transforms '((".*" ,"~/.backup/" t))
;;       delete-old-version t
;;       kept-new-versions 6
;;       kept-old-versions 2
;;       version-control t
;;       )

;; .# 파일 생성 안함
(setq create-lockfiles nil)
;; Delete File and Buffer
(defun delete-file-and-buffer ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (if (y-or-n-p (format "Really Delete File?"))
      (let ((filename (buffer-file-name)))
        (when filename
          (if (vc-backend filename)
              (vc-delete-file filename)
            (progn
              (delete-file filename)
              (message "deleted file %s" filename)
              (kill-buffer))))))
  )

;; Rename File and Buffer
(defun rename-file-and-buffer ()
  "Rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

(defun move-file-and-buffer ()
  "Move the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (expand-file-name (file-name-nondirectory (buffer-file-name)) (read-file-name "New Directory: "))))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

;; Switch to Previous Buffer
(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(defun close-all-buffers ()
  (interactive)
  (if (y-or-n-p (format "Really close all buffer?"))
      (mapc 'kill-buffer (buffer-list))))

(global-set-key (kbd "C-c R") 'rename-file-and-buffer)
(global-set-key (kbd "C-c D") 'delete-file-and-buffer)
(global-set-key (kbd "C-c b") 'switch-to-previous-buffer)
(global-set-key (kbd "C-c M") 'move-file-and-buffer)

;; 변경된 파일 내용 자동 반영
(global-auto-revert-mode)

(defalias 'list-buffers 'ibuffer)

;; 항상 다른 윈도우에 ibuffer 표시
(setq ibuffer-use-other-window t)

(defalias 'list-buffers 'ibuffer)

;; 항상 다른 윈도우에 ibuffer 표시
(setq ibuffer-use-other-window t)

;;(setq dired-dwim-target           t      ; 다른 dired buffer가 다른 윈도우에 표시되고 있다면 rename / copy를 위한 타켓으로 그 디렉토리를 사용
;;      dired-recursive-copies      'alway ;
;;      dired-recursive-deletes     'top   ;
;;      setq dired-listing-switches "-lha" ;
;;      )


;; 변경이 있을 때 dired 버퍼를 자동 새로 고침
(add-hook 'dired-mode-hook 'auto-revert-mode)

;; 윈도우가 아니면 다음 목록으로 전환해서 사용
(when (not (eq system-type 'windows-nt))
  (setq dired-listing-switches "-lha --group-directories-first"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GROUP: Files > Recentf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(recentf-mode 1)

;; Recently Visited Files
(setq recentf-max-saved-items 200)
(setq recentf-max-menu-items 15)

;; recentf id로 찾기
(defun recentf-ido-find-file ()
  "Find a recent file using ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))

(global-set-key (kbd "C-c f") 'recentf-ido-find-file)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : snapshot-timemachine
;;
;; Snapshot-timemachine provides a polished interface to step through the snapshots
;; of a file made by a third-party snapshot or backup facility, e.g. Btrfs, ZFS, etc.
;;
;; SITE    : https://github.com/mrBliss/snapshot-timemachine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package snapshot-timemachine
  :ensure t
  :init

  ;; Default Backup directory
  (defvar backup-directory "~/.emacs.d/backups/")
  (setq backup-directory-alist `((".*" . ,backup-directory)))

  (when (not (file-exists-p backup-directory))
    (make-directory backup-directory t))

  ;; Auto-save
  (defvar auto-save-directory "~/.emacs.d/auto-save/")
  (setq auto-save-file-name-transforms `((".*" ,auto-save-directory t)))


  (when (not (file-exists-p auto-save-directory))
    (make-directory auto-save-directory t))

  ;; Tramp backup
  (defvar tramp-backup-directory "~/.emacs.d/tramp-backups/")
  (setq tramp-backup-directory-alist `((".*" . ,tramp-backup-directory)))

  (when (not (file-exists-p tramp-backup-directory))
    (make-directory tramp-backup-directory t))

  (setq make-backup-files t               ; backup of a file the first time it is saved.
        backup-by-copying t               ; don't clobber symlinks
        version-control t                 ; version numbers for backup files
        delete-old-versions t             ; delete excess backup files silently
        delete-by-moving-to-trash t
        kept-old-versions 6               ; oldest versions to keep when a new numbered backup is made (default: 2)
        kept-new-versions 9               ; newest versions to keep when a new numbered backup is made (default: 2)
        auto-save-default t               ; auto-save every buffer that visits a file
        auto-save-timeout 20              ; number of seconds idle time before auto-save (default: 30)
        auto-save-interval 200            ; number of keystrokes between auto-saves (default: 300)
        )

  :config

  (defun snapshot-timemachine-backup-finder (file)
    "Find snapshots of FILE in rsnapshot backups."
    (let* ((file (expand-file-name file))
           (file-adapted (replace-regexp-in-string "/" "!" file))
           (backup-files(directory-files backup-directory t (format "%s.*" file-adapted))))
      (seq-map-indexed (lambda (backup-file index)
                         (make-snapshot :id index
                                        :name (format "%d" index)
                                        :file backup-file
                                        :date (nth 5 (file-attributes backup-file))))
                       backup-files)))

  (setq snapshot-timemachine-snapshot-finder #'snapshot-timemachine-backup-finder))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : recentf-ext
;;
;; GROUP   : Files > Recentf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package recentf-ext
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : vlf
;;
;; GROUP   : Files > Vlf
;; SITE    : https://github.com/m00natic/vlfi#detail-usage
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package vlf
  :ensure t
  :config
  (require 'vlf-setup)
  (setq vlf-application 'dont-ask)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GROUP: Environment > Minibuffer > Savehist
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(desktop-save-mode t)
(savehist-mode t)
(add-to-list 'savehist-additional-variables 'kill-ring)

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  (with-eval-after-load 'treemacs
    (define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action))
  :config
  (progn
    (setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay      0.5
          treemacs-display-in-side-window        t
          treemacs-eldoc-display                 t
          treemacs-file-event-delay              5000
          treemacs-file-extension-regex          treemacs-last-period-regex-value
          treemacs-file-follow-delay             0.2
          treemacs-follow-after-init             t
          treemacs-git-command-pipe              ""
          treemacs-goto-tag-strategy             'refetch-index
          treemacs-indentation                   2
          treemacs-indentation-string            " "
          treemacs-is-never-other-window         nil
          treemacs-max-git-entries               5000
          treemacs-missing-project-action        'ask
          treemacs-no-png-images                 nil
          treemacs-no-delete-other-windows       t
          treemacs-project-follow-cleanup        nil
          treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                      'left
          treemacs-recenter-distance             0.1
          treemacs-recenter-after-file-follow    nil
          treemacs-recenter-after-tag-follow     nil
          treemacs-recenter-after-project-jump   'always
          treemacs-recenter-after-project-expand 'on-distance
          treemacs-show-cursor                   nil
          treemacs-show-hidden-files             t
          treemacs-silent-filewatch              nil
          treemacs-silent-refresh                nil
          treemacs-sorting                       'alphabetic-numeric-asc
          treemacs-space-between-root-nodes      t
          treemacs-tag-follow-cleanup            t
          treemacs-tag-follow-delay              1.5
          treemacs-width                         35)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE : emacs-htmlize
;;
;; HTML 변환 기능 제공
;;
;; SITE    : https://github.com/hniksic/emacs-htmlize
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package htmlize
  :ensure t
  )
