;;; ~/.doom.d/+functions.el -*- lexical-binding: t; -*-

;; Custom functions here ...

;; -------------------------------------------------------------------------- ;;
;; Functions below are from UndeadKernels config.
;; https://github.com/UndeadKernel/emacs_doom_private

;; Delete a word forward without pasting in the kill-region
(defun +boy/delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times.
This command does not push text to `kill-ring'."
  (interactive "p")
  (delete-region
   (point)
   (progn
     (forward-word arg)
     (point))))

;; Delete a word backwards without modifying the kill-region
(defun +boy/backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument, do this that many times.
This command does not push text to `kill-ring'."
  (interactive "p")
  (+boy/delete-word (- arg)))
