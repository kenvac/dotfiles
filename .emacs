(setq c-basic-offset 4)
(setq indent-tabs-mode nil)


(defun terminal-init-screen ()
  "Terminal initialization function for screen."
  ;; Use the xterm color initialization code.
  (load "term/xterm")
  (xterm-register-default-colors)
  (tty-set-up-initial-frame-faces))

;; Org-mode settings
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-to-list 'auto-mode-alist '("ledger/.*\\.dat$" . ledger-mode))

(setq org-todo-keywords
      '((sequence "TODO" "ACTIVE" "|" "DONE")))
(setq org-todo-keyword-faces
      '(("ACTIVE" . "brightyellow")))
(setq org-log-done 'time)
(setq org-startup-indented t)


(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-font-lock-mode 1)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/notes.org"))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; With Screen between Emacs and the "real" terminal, it doesn't occur
;; to Emacs to translate some keybindings.  Teach it about a handful
;; that are important to me (because paredit uses them).  Don't bother
;; looking at $COLORTERM, since after screen -xRR or screen -dRR, it
;; will be inaccurate.
(when (or (featurep 'multi-tty)
          (and (null window-system)
               (getenv "TERM")
               (string-match "\\`screen" (getenv "TERM"))))
  (mapc (lambda (x)
          (define-key function-key-map (car x) (cdr x)))
        (nconc
         ;; rxvt-unicode
         '(("\e[1~" . [home])
           ("\e[4~" . [end])
           ("\e[5~" . [prior])
           ("\e[6~" . [next])
           ("\e[a" . [S-up])
           ("\e[b" . [S-down])
           ("\e[c" . [S-right])
           ("\e[d" . [S-left])
           ("\eOa" . [C-up])
           ("\eOb" . [C-down])
           ("\eOc" . [C-right])
           ("\eOd" . [C-left])
           ("\eOm" . [kp-subtract])
           ("\eOj" . [kp-multiply])
           ("\eOo" . [kp-divide])
           ("\eOM" . [kp-enter]))
         ;; xterm
         '(("\e[1;3A" . [M-up])
           ("\e[1;3B" . [M-down])
           ("\e[1;3C" . [M-right])
           ("\e[1;3D" . [M-left])
           ("\e[1;3H" . [M-home])
           ("\e[1;3F" . [M-end])
           ("\e[5;3~" . [M-prior])
           ("\e[6;3~" . [M-next])
           ("\e[2;3~" . [M-insert])
           ("\e[3;3~" . [M-delete])

           ("\e[1;5A" . [C-up])
           ("\e[1;5B" . [C-down])
           ("\e[1;5C" . [C-right])
           ("\e[1;5D" . [C-left])
           ("\e[1;5H" . [C-home])
           ("\e[1;5F" . [C-end])
           ("\e[5;5~" . [C-prior])
           ("\e[6;5~" . [C-next])
           ("\e[2;5~" . [C-insert])
           ("\e[3;5~" . [C-delete])
           ("\e[27;5;9~" . [C-tab])

           ("\e[1;2A" . [S-up])
           ("\e[1;2B" . [S-down])
           ("\e[1;2C" . [S-right])
           ("\e[1;2D" . [S-left])
           ("\e[1;2H" . [S-home])
           ("\e[1;2F" . [S-end])
           ;;("\e[5;2~" . [S-prior])
           ;;("\e[6;2~" . [S-next])
           ;;("\e[2;2~" . [S-insert])
           ("\e[3;2~" . [S-delete])
           ("\e[Z" . [S-tab])

           ("\e[1;8A" . [C-M-S-up])
           ("\e[1;8B" . [C-M-S-down])
           ("\e[1;8C" . [C-M-S-right])
           ("\e[1;8D" . [C-M-S-left])
           ("\e[1;8H" . [C-M-S-home])
           ("\e[1;8F" . [C-M-S-end])
           ;;("\e[5;8~" . [C-M-S-prior])
           ;;("\e[6;8~" . [C-M-S-next])
           ;;("\e[2;8~" . [C-M-S-insert])
           ;;("\e[3;8~" . [C-M-S-delete])

           ("\e[1;6A" . [C-S-up])
           ("\e[1;6B" . [C-S-down])
           ("\e[1;6C" . [C-S-right])
           ("\e[1;6D" . [C-S-left])
           ("\e[1;6H" . [C-S-home])
           ("\e[1;6F" . [C-S-end])
           ;;("\e[5;6~" . [C-S-prior])
           ;;("\e[6;6~" . [C-S-next])
           ;;("\e[2;6~" . [C-S-insert])
           ("\e[3;6~" . [C-S-delete])

           ("\e[1;7A" . [C-M-up])
           ("\e[1;7B" . [C-M-down])
           ("\e[1;7C" . [C-M-right])
           ("\e[1;7D" . [C-M-left])
           ("\e[1;7H" . [C-M-home])
           ("\e[1;7F" . [C-M-end])
           ("\e[5;7~" . [C-M-prior])
           ("\e[6;7~" . [C-M-next])
           ;;("\e[3;7~" . [C-M-delete])
           ("\e[2;7~" . [C-M-insert]))
         ;; libvte (gnome-terminal, xfce4-terminal)
         '(("\eO3A" . [M-up])
           ("\eO3B" . [M-down])
           ("\eO3C" . [M-right])
           ("\eO3D" . [M-left])
           ("\eO5A" . [C-up])
           ("\eO5B" . [C-down])
           ("\eO5C" . [C-right])
           ("\eO5D" . [C-left])
           ("\eO7A" . [C-M-up])
           ("\eO7B" . [C-M-down])
           ("\eO7C" . [C-M-right])
           ("\eO7D" . [C-M-left])
           ("\e[Z" . [S-iso-lefttab])))))

