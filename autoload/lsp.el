;;; ~/.doom.d/autoload/lsp.el -*- lexical-binding: t; -*-

;;; Slightly modified version of original from:
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
