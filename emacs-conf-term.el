(add-hook 'term-mode-hook (lambda ()
                            (yas-minor-mode nil)
                            (setq term-buffer-maximum-size 1000)
                            (toggle-truncate-lines t)
                            (define-key term-raw-map (kbd "C-t") 'my-term-switch-line-char)
                            (define-key term-mode-map (kbd "C-t") 'my-term-switch-line-char)
                            (define-key term-raw-map (kbd "M-x") 'execute-extended-command)
                            (define-key term-raw-map (kbd "C-y") 'term-paste)
                            (define-key term-raw-map (kbd "C-c l") 'org-store-link)
                            (define-key term-raw-map (kbd "C-c c") 'org-capture)
                            (define-key term-raw-map (kbd "C-c a") 'org-agenda)
                            (define-key term-raw-map (kbd "C-c C-e") 'term-send-esc)
                            (define-key term-raw-map (kbd "M-o") 'ace-window)
                            ))

(defun my-term-switch-line-char ()
  "Switch 'term-in-line-mode' and 'term-in-char-mode' in 'ansi-term'"
  (interactive)
  (cond
   ((term-in-line-mode)
    (term-char-mode)
    (hl-line-mode -1)
    (beacon-mode -1))
   ((term-in-char-mode)
    (term-line-mode)
    (hl-line-mode t)
    (beacon-mode t))))

(use-package multi-term
  :ensure t
  :config
  (global-set-key (kbd "C-c C-m t") 'multi-term)
  (global-set-key (kbd "C-c C-m o") 'multi-term-dedicated-open)
  (global-set-key (kbd "C-c C-m q") 'multi-term-dedicated-close)
  (global-set-key (kbd "C-c C-m s") 'multi-term-dedicated-select)
  (global-set-key (kbd "C-x M-RET") 'multi-term-dedicated-toggle)
  (add-hook 'term-mode-hook (lambda () (global-set-key (kbd "C-c C-m >") 'multi-term-next)))
  (add-hook 'term-mode-hook (lambda () (global-set-key (kbd "C-c C-m <") 'multi-term-prev)))
  )
