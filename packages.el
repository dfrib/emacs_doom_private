;;; ~/.doom.d/packages.el -*- no-byte-compile: t; -*-
(disable-packages! cmake-mode
                   company-irony
                   company-irony-c-headers
                   flycheck-irony
                   irony
                   irony-eldoc
                   ivy-rtags
                   rtags)

(package! ag)


(package! lsp-mode)
(package! lsp-ui)
;(package! lsp-ui-peek)
(package! company-lsp)
(package! ccls)

(package! lsp-python)

(package! resize-window)

;(package! ob-ipython :recipe (:fetcher github :repo "fuxialexander/ob-ipython" :files ("*.el" "*.py")))
