(provide 'init-emacs)

;;开启行号
(global-linum-mode t)

;;设置中文标点
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)

;;设置字体
;;(set-default-font "黑体-12")
;;(set-frame-font "Monaco-10")
;;(set-fontset-font "fontset-default" 'han "文泉驿等宽正黑-12")

;;取消滚动条
;;(customize-set-variable 'scroll-bar-mode nil);

;;不产生临时文件
(setq-default make-backup-file nil);

;;开启ido（输入文件提示）
;;(ido-mode t)

;;禁用启动信息
;;(setq inhibit-startup-message t)

;;括号匹配
(show-paren-mode t)

;;语法高亮
(global-font-lock-mode t)

;;高亮显示选中块
(transient-mark-mode t)

;;默认Text Mode
(setq default-major-mode 'text-mode)

;;支持外部拷贝粘贴
(setq x-select-enable-clipboard t)

;;C-k删除整行到末尾
(setq-default kill-whole-line t)

;;删除保存记录为200
;;(setq kill-ring-max 200)

;;设置Tab宽度
(setq default-tab-width 4)

;;约会提醒
;;(setq appt-issue-message t)

;;取消滚动栏
;;(set-scroll-bar-mode nil)

;;显示图片
(auto-image-file-mode)

;;设置标题
(setq frame-title-format "光耀九州 -- %f@emacs")

;;全屏模式
(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
                         (if (equal 'fullboth current-value)
                             (if (boundp 'old-fullscreen) old-fullscreen nil)
                           (progn (setq old-fullscreen current-value)
                                  'fullboth)))))
(global-set-key [f11] 'toggle-fullscreen)
;;(add-hook 'emacs-startup-hook 'toggle-fullscreen)

;;取消菜单
;;(tool-bar-mode 0)

;;底边栏-时间
;;(setq display-time-24hr-format t)
;;(setq display-time-use-mail-icon t);;邮件设置图标
;;(setq display-time-interval 10);;时间更新频率
;;(display-time-mode 1)

;;底边栏-行列号
(column-number-mode t)

;;字体
;;(set-default-font "10x5")

;;配色-背景
;;(set-cursor-color "blue")
;;(set-mouse-color "white")
;;(set-foreground-color "white")
;;(set-background-color "darkblue")

;;配色-高亮
;;(set-face-foreground 'highlight "white")
;;(set-face-background 'highlight "blue")
;;(set-face-foreground 'region "cyan")
;;(set-face-background 'region "blue")
;;(set-face-foreground 'secondary-selection "skyblue")
;;(set-face-background 'secondary-selection "darkblue")

;;配色-日历
;;(setq calendar-load-hook
;;'(lambda ()
;;(set-face-foreground 'diary-face "skyblue")
;;(set-face-background 'holiday-face "slate blue")
;;(set-face-foreground 'holiday-face "white")))

;;鼠标自动弹开指针
(mouse-avoidance-mode 'animate)

;;默认的滚动太快，这里改为3行
(defun up-slightly () (interactive) (scroll-up 3))
(defun down-slightly () (interactive) (scroll-down 3))
(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly)

;;写文件的编码方式
(set-buffer-file-coding-system 'utf-8)

;;新建文件的编码方式
(setq default-buffer-file-coding-system 'utf-8)

;;读取或写入文件名的编码方式
(setq file-name-coding-system 'utf-8) 

;; smart-compile+ 
(require 'smart-compile+)
(global-set-key [(f9)] 'smart-compile)

;; gdb
;;(setq gdb-many-windows t)
;;(setq gdb-use-separate-io-buffer t)

;; clang-completion-mode
;;(load-library "clang-completion-mode")

;; 重定义注释方法
;;   -- 没有任中任何区域时，注释、反注释作用于当前行，否则作用于
;;      选中区域
(defadvice comment-or-uncomment-region (before slickcomment activate compile)
  "When called interactively with no active region, toggle comment on current line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))
(global-set-key (kbd "C-.") 'comment-or-uncomment-region)

;; php mode
(add-to-list 'load-path (expand-file-name "~/.emacs-elisp/php-mode"))
(require 'php-mode)
(add-hook 'php-mode-hook
	'(lambda () (define-abbrev php-mode-abbrev-table "ex" "extends")))

;; html-helper-mode
;; (setq html-helper-build-new-buffer nil)

;; 自动补齐
(add-to-list 'load-path "~/.emacs-elisp/auto-complete/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs-elisp/auto-complete//ac-dict")
(ac-config-default)
(put 'upcase-region 'disabled nil)

;;-------------------- w3m --------------------
(setq w3m-default-display-inline-images t)
(setq w3m-home-page "http://www.google.com")
(setq w3m-default-display-inline-images t)
(setq w3m-use-mule-ucs t)
(setq w3m-use-cookies t)
;;设定w3m的语言设置，以便方便使用和阅读中文-用了就乱码
;;;;书签解码设置
;; (setq w3m-bookmark-file-coding-system 'chinese-iso-8bit)
;; ;;;;w3m的解码设置，后面最好都有，我也不详解了
;; (setq w3m-coding-system 'chinese-iso-8bit)
;; (setq w3m-default-coding-system 'chinese-iso-8bit)
;; (setq w3m-file-coding-system 'chinese-iso-8bit)
;; (setq w3m-file-name-coding-system 'chinese-iso-8bit)
;; (setq w3m-terminal-coding-system 'chinese-iso-8bit)
;; (setq w3m-input-coding-system 'chinese-iso-8bit)
;; (setq w3m-output-coding-system 'chinese-iso-8bit)
;;(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;;'(ansi-color-names-vector ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 ;;'(column-number-mode t)
 ;;'(custom-enabled-themes (quote (zenburn)))
 ;;'(custom-safe-themes (quote ("3580fb8e37ee9e0bcb60762b81260290329a97f3ca19249569d404fce422342f" default)))
 ;;'(delete-selection-mode nil)
 ;;'(mark-even-if-inactive t)
 ;;'(menu-bar-mode nil)
 ;;'(safe-local-variable-values (quote ((todo-categories "test" "Personal") (encoding . utf8))))
 ;;'(scroll-bar-mode nil)
 ;;'(show-paren-mode t)
 ;;'(tool-bar-mode nil)
 ;;'(transient-mark-mode 1))
;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; )

;; cscope
;;(add-hook 'c-mode-common-hook
;;	  '(lambda ()
;;	    (require 'xcscope)))

;;; Also highlight parens
(setq show-paren-delay 0
      show-paren-style 'parenthesis)
(show-paren-mode 1)

;;; scheme implementation
(setq scheme-program-name "guile")

;;------------------- angle ---------------------------
;(require `angle-mode)
;(add-to-list 'auto-mode-alist
;	     (cons (purecopy "\\.ans\\'") 'angle-mode))
;;-------------------------------------------------------


;;-------------------- Color theme --------------------
;;     配色管理。
;;-----------------------------------------------------
;;(require 'color-theme)
;;(color-theme-gray30)
(add-to-list 'custom-theme-load-path "~/.emacs-elisp/themes")
;;(load-theme 'dracula t)
;;(load-theme 'blue-sea t t)
;;(enable-theme 'blue-sea)
(load-theme 'calm-forest t t)
(enable-theme 'calm-forest)

(setq fancy-splash-image "~/.emacs-elisp/start.jpg")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs-elisp/neotree")

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
