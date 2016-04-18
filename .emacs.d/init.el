;;ロードパス追加関数
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'nomal-top-level-add-subdirs-to-load-path)
	    (nomal-top-level-add-sub-dirs-to-load-path))))))
(add-to-load-path "elisp" "conf" "public_repos")

;;デフォルトディレクトリの変更
;;http://qiita.com/t2psyto/items/05776f010792ba967152
(setq default-directory "~/")
(setq command-line-default-directory "~/")

;; タイトルバーにファイルのフルパスを表示
(setq frame-title-format "%f")

;;リージョンの背景色を変更
(set-face-background 'region "darkgreen")

;;空白、タブなどを表示
;;http://keisanbutsuriya.hateblo.jp/entry/2015/02/03/153149
;;http://konbu13.hatenablog.com/entry/2014/04/01/203857
(require 'whitespace)
(setq whitespace-style '(face		;faceで可視化
			 trailing	;行末
			 tabs		;タブ
			 empty		;先頭/末尾の空行
			 space-mark	;表示のマッピング
			 tab-mark
			 ))
(setq whitespace-display-mappings
      '((tab-mark ?\t [?\u00BB ?\t] [?\t])
        (space-mark ?\x3000 [?\□])
	))
(global-whitespace-mode 1)

;; 日本語設定
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;;init-loader 設定
;;http://coderepos.org/share/browser/lang/elisp/init-loader/init-loader.el
(require 'init-loader)
(init-loader-load "~/.emacs.d/conf"); 設定ファイルがあるディレクトリを指定

;;;auto-installの設定
;(when (require 'auto-install nil t)
;  ;;インストールディレクトリを設定する。初期値は=/.emacs.d/auto-install/
;  (setq auto-install-directory "~/.emacs.d/elisp/")
;  ;;EmacsWikiに登録されているelispの名前を取得する
;  (auto-install-update-emacswiki-package-name t)
;  ;;必要であればプロキシの設定を行う
;  ;;(setq url-proxy-service'(("http" . "localhost:8339")))
;  ;;install-elispの関数を利用可能にする
;  (auto-install-compatibility-setup)
;  (setq auto-install-use-wget 0))

;; auto-installのアドバイス関数定義
(defadvice auto-install-download-callback-continue (before remove-gnuwin-wget-stderr-info activate)
  "Remove GnuWin's wget stderr information (2 lines) from the tail of the buffer."
  (if (auto-install-use-wget-p)
      (with-current-buffer (get-buffer (ad-get-arg 0))
        (save-excursion
          (goto-char (point-max))
          (when (re-search-backward "^SYSTEM_WGETRC = " nil t)
            (delete-region (point) (point-max)))))))

;;redo+の設定
(when (require 'redo+)
    ;;C-'にREDOを割り当てる
  (global-set-key (kbd "C-'") 'redo)
  )

;; クリップボードを共有
(setq x-select-enable-clipboard t)

;;カラム番号を表示
(column-number-mode t)

;;行番号を表示させる
(line-number-mode t)

;; 行番号をウィンドウ左側に表示
(global-linum-mode t)

;;ファイルサイズを表示
(size-indication-mode t)

;;時計を表示
;;(setq display-time-day-and-date t) ; 曜日・月・日を表示
;;(setq display-time-24hr-format t) ; 24時表示
(display-time-mode t)

;;バッテリー残量を表示
(display-battery-mode t)

;;タブの表示幅。初期値は8
(setq-default tab-width 4)

;;インデントにタブ文字を使用しない
(setq-default indent-tabs-mode nil)

;;現在行のハイライト
(defface my-hl-line-face
  ;;背景がdarkならば背景色を紺に
  '((((class color) (background dark))
     (:background "NavyBlue" t))
    ;;背景がlightなら背景色を緑に
    (((class color) (background light))
     (:background "LightGoldenrodYellow" t))
    (t (:bold t)))
  "hl-line's my face")
(setq hl-line-face 'my-hl-line-face)
(global-hl-line-mode t)


;; emacs-lisp-modeのフックをセット
;; Elisp関数や変数の情報をエコーエリアに表示させる
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (when (require 'eldoc nil t)
               (setq eldoc-idle-delay 0.2)
               (setq eldoc-echo-area-use-multiline-p t)
               (turn-on-eldoc-mode))))

;;gtags キーバインド有効化
;(setq gtags-suggested-key-mapping t) ; 無効化する場合はコメントアウト
(require 'gtags nil t)
;; gtags キーバインド設定
(global-set-key "\M-t" 'gtags-find-tag)
(global-set-key "\M-r" 'gtags-find-rtag)
(global-set-key "\M-s" 'gtags-find-symbol)
(global-set-key "\C-t" 'gtags-pop-stack)

;;試行錯誤ファイルを開くための設定
(require 'open-junk-file)
;;C-x C-zで試行錯誤ファイルを開く
(global-set-key (kbd "C-x C-z") 'open-junk-file)

;;式に評価結果を注釈するための設定
(require 'lispxmp)
;; emacs-lisp-modeでC-c C-dを押すと注釈される
(define-key emacs-lisp-mode-map (kbd "C-c C-d") 'lispxmp)

;;括弧の対応を保持して編集する設定
(require 'paredit)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)

;;自動バイトコンパイルの設定
(require 'auto-async-byte-compile)
;;自動バイトコンパイルを無効にするファイルの正規表現
(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
(setq eldoc-idle-delay 0.2)
(setq eldoc-minor-mode-string "") ; モードラインにELdocと表示しない
;;つりあいの取れる括弧をハイライトする
(show-paren-mode t) ; 有効化
;;改行と同時にインデントも行う
(global-set-key "\C-m" 'newline-and-indent)
;;find-functionをキー割り当てする

;; paren-mode: 対応する括弧を強調して表示する
;(setq show-paren-delay 0) ; 表示までの秒数。初期値は0.125
;; parenのスタイル: expressionはカッコ内も強調表示
;(setq show-paren-style 'expression)

;;フェイスを変更する
(set-face-background 'show-paren-match nil)
(set-face-underline-p 'show-paren-match "yellow")

;; lua-mode設定
(autoload 'lua-mode "lua-mode" "Lua edit mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

