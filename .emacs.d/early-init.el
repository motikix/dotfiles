;; メニューバー、ツールバーを非表示
(add-to-list 'default-frame-alist '(menu-bar-lines . 0))
(add-to-list 'default-frame-alist '(tool-bar-lines . 0))

;; 起動画面をスキップ
(setq-default inhibit-startup-message t)
(setq-default initial-scratch-message nil)
(setq-default initial-major-mode 'org-mode)

;; ビープ音を消す
(setq-default ring-bell-function 'ignore)

;; yes/no -> y/n
(setq-default use-short-answers t)

;; バックアップファイル類を作らない
(setq-default make-backup-files nil)
(setq-default auto-save-default nil)
(setq-default auto-save-list-file-prefix nil)
(setq-default create-lockfiles nil)

;; 履歴の重複を排除
(setq-default history-delete-duplicates t)

;; シンボリックリンクを辿る
(setq-default vc-follow-symlinks t)

;; テキストラップしない
(setq-default truncate-lines t)
(setq-default truncate-partial-width-windows t)

;; ソフトタブ
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'left)

;; C-h を変更
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\C-c\C-h" 'help-command)

;; フォント
(add-to-list 'default-frame-alist '(font . "Moralerspace Radon HWNF-16"))

;; エンコード
(prefer-coding-system 'utf-8-unix)
