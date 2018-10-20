;;; ~/.doom.d/autoload/lsp.el -*- lexical-binding: t; -*-

;;; Recommended CCLS helpers from
;;; https://github.com/MaskRay/ccls/wiki/Emacs
(defun ccls/callee ()
  (interactive)
  (lsp-ui-peek-find-custom 'callee "$ccls/call" '(:callee t)))
(defun ccls/caller ()
  (interactive)
  (lsp-ui-peek-find-custom 'caller "$ccls/call"))
(defun ccls/vars (kind)
  (lsp-ui-peek-find-custom 'vars "$ccls/vars" `(:kind ,kind)))
(defun ccls/base (levels)
  (lsp-ui-peek-find-custom 'base "$ccls/inheritance" `(:levels ,levels)))
(defun ccls/derived (levels)
  (lsp-ui-peek-find-custom 'derived "$ccls/inheritance" `(:levels ,levels :derived t)))
(defun ccls/member (kind)
  (interactive)
  (lsp-ui-peek-find-custom 'member "$ccls/member" `(:kind ,kind)))

;; ccls/vars ccls/base ccls/derived ccls/members have a parameter while others are interactive.
;; (ccls/base 1)
;; (ccls/derived 1)
;; (ccls/member 2) => 2 (Type) => nested classes / types in a namespace
;; (ccls/member 3) => 3 (Func) => member functions / functions in a namespace
;; (ccls/member 0) => member variables / variables in a namespace
;; (ccls/vars 3) => field or local variable

;;; Slightly modified hydra version of original from:
;;; https://github.com/MaskRay/Config/blob/master/home/.config/doom/config.el

;;;###autoload (autoload '+mr/lsp-traverse-hydra/body "~/.doom.d/autoload/lsp.el" nil t)
(defhydra +mr/lsp-traverse-hydra (:hint nil)
  "Traverse references"
  ("d" lsp-ui-peek-find-definitions "next" :bind nil)
  ("n" (-let [(i . n) (lsp-ui-find-next-reference)]
         (if (> n 0) (message "%d/%d" i n))) "next")
  ("p" (-let [(i . n) (lsp-ui-find-prev-reference)]
         (if (> n 0) (message "%d/%d" i n))) "prev")
  ("R" (-let [(i . n) (lsp-ui-find-prev-reference
                       (lambda (x)
                         (/= (logand (gethash "role" x 0) 8) 0)))]
         (if (> n 0) (message "read %d/%d" (+ i 1) n))) "prev read" :bind nil)
  ("r" (-let [(i . n) (lsp-ui-find-next-reference
                       (lambda (x)
                         (/= (logand (gethash "role" x 0) 8) 0)))]
         (if (> n 0) (message "read %d/%d" (+ i 1) n))) "next read" :bind nil)
  ("W" (-let [(i . n) (lsp-ui-find-prev-reference
                       (lambda (x)
                         (/= (logand (gethash "role" x 0) 16) 0)))]
         (if (> n 0) (message "write %d/%d" (+ i 1) n))) "prev write" :bind nil)
  ("w" (-let [(i . n) (lsp-ui-find-next-reference
                       (lambda (x)
                         (/= (logand (gethash "role" x 0) 16) 0)))]
         (if (> n 0) (message "write %d/%d" (+ i 1) n))) "next write" :bind nil)
  ("q" nil "stop" :color blue)
  )
