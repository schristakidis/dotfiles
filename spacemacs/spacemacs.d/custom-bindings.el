;; This are defined in the tmux layer
;; (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
;; (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
;; (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
;; (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

(define-key evil-normal-state-map (kbd "C-i") 'evil-jump-forward)
(define-key evil-normal-state-map (kbd ", SPC") 'spacemacs/evil-search-clear-highlight)

;; counsel find files bindings
(define-key counsel-find-file-map (kbd "C-v") (kbd "M-o w"))
(define-key counsel-find-file-map (kbd "C-s") (kbd "M-o s"))

;; ivy find buffer bindings
(define-key ivy-switch-buffer-map (kbd "C-v") (kbd "M-o j"))

(with-eval-after-load 'counsel-projectile
  (define-key counsel-projectile-map (kbd "C-v") (kbd "M-o j")))

(spacemacs/set-leader-keys "G" 'engine/search-google)
(spacemacs/set-leader-keys "s j" 'helm-semantic)

(define-key evil-normal-state-map (kbd ", m") 'spacemacs/toggle-maximize-buffer)
(define-key evil-normal-state-map (kbd ", M") 'ace-swap-window)

(define-key evil-normal-state-map (kbd ", b") 'ivy-switch-buffer)
(define-key evil-normal-state-map (kbd ", f") 'counsel-find-file)
(define-key evil-normal-state-map (kbd ", p") 'counsel-projectile-find-file)

(evil-ex-define-cmd "diff" 'magit-ediff-compare)
(evil-ex-define-cmd "diffu" 'magit-ediff-show-unstaged)
(evil-ex-define-cmd "diffw" 'magit-ediff-show-working-tree)

(provide 'custom-bindings)
