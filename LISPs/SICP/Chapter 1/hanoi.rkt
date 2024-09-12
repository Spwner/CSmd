#lang sicp


(define (print-move from to)
  (display "From ")
  (display from)
  (display " to ")
  (display to)
  (display ".\n"))


(define (move disks from to spare)
  (cond ((= disks 0) nil)  ;; no move
        (else (move (- disks 1) from spare to)
              (print-move from to)
              (move (- disks 1) spare to from))))

(move 10 1 2 3)
