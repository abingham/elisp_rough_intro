;;; wpt.el --- waypoints for emacs
;;
;; Author: Austin Bingham <austin.bingham@gmail.com>
;; Version: 1
;; URL: https://github.com/abingham/elisp_rough_intro
;;
;; This file is not part of GNU Emacs.
;;
;; Copyright (c) 2013 Austin Bingham
;;
;;; Commentary:
;;
;; Description:
;;
;;; License:
;;
;; Permission is hereby granted, free of charge, to any person
;; obtaining a copy of this software and associated documentation
;; files (the "Software"), to deal in the Software without
;; restriction, including without limitation the rights to use, copy,
;; modify, merge, publish, distribute, sublicense, and/or sell copies
;; of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:
;;
;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
;; BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
;; ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
;; CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PUBLIC API                                                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar wpt:positions '()
  "The stack of waypoints managed by wpt")

(defun wpt:push ()
  "Push the current position to the front of the queue."
  (interactive)
  (set-variable 'wpt:positions
                (cons (list (buffer-name) (point))
                      wpt:positions)))

(defun wpt:pop ()
  "Pop a position from the queue and jump to it."
  (interactive)
  (unless wpt:positions
    (error "No waypoints to pop!"))
  (let* ((address (car wpt:positions))
         (buff (car address))
         (pt (cadr address))
         (rest (cdr wpt:positions)))
    (set-variable 'wpt:positions rest)
    (pop-to-buffer buff)
    (goto-char pt)))
