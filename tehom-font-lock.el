;;; tehom-font-lock.el --- A little help for writing fontlock support

;; Copyright (C) 2000 by Tom Breton

;; Author: Tom Breton <tob@world.std.com>
;; Keywords: extensions, maint, tools

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; This is a little thing I wrote because building expressions for
;; fontlock mode was a PITA.  Now for the common case you can build a
;; font-lock expression as simply as:

;;   (tehom-build-font-lock-expression '("this-word" "that-word"))

;; Or to use a specific face:

;;   (tehom-build-font-lock-expression '("this-word" "that-word") some-face)

;; So what you'd write, all told, would look something like:

;; (require 'tehom-font-lock)
;; 
;; (font-lock-add-keywords 'some-mode
;;   (list 
;;     (tehom-build-font-lock-expression 
;;       '("this-word" "that-word") some-face)))

;;; Non-features:

;; tehom-build-font-lock-expression assumes that every string is only
;; meaningful at the head of a list.  It doesn't try to handle
;; anything complex like anchored font-lock.  It just lets you write
;; the basic stuff without puzzling over what sort of expression
;; font-lock wants.

;; It would be nice to use `cl's `defstruct' or `defun*' to really
;; control the font-lock interface with &key arguments, but I didn't
;; go that far.  And defun* would require `cl' at runtime.

;;; Code:

(require 'font-lock)

(defun tehom-build-font-lock-expression (strings &optional face)
  ""

  (let* 
    ((regexp
       (concat
	 "(" 
	 (regexp-opt strings t)
	 "\\>")))
    
    (if
      face
      (list regexp 1 face)
      (cons regexp 1))))

(defun tehom-add-font-lock-to-all-lisp (exp &optional append)
  ""
  
  (font-lock-add-keywords 'emacs-lisp-mode       exp append)
  (font-lock-add-keywords 'lisp-interaction-mode exp append)
  (font-lock-add-keywords 'lisp-mode             exp append))

(provide 'tehom-font-lock)

;;; tehom-font-lock.el ends here