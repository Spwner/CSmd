#lang sicp

;; Exercise 1.27

(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp) (remainder (square (expmod base (/ exp 2) m)) m))
        (else (remainder (* base (expmod base (- exp 1) m)) m))))

(define (carmichael-test n)
  (define (carmichael-loop m)
    (if (= m n)
        true
        (and (= (expmod m n n) m)
             (carmichael-loop (+ m 1)))))
  (if (carmichael-loop 2)
      (display "Carmichael confirmed.\n")
      (display "Not carmichael.\n")))

(carmichael-test 61)
(carmichael-test 1105)
(carmichael-test 1729)
(carmichael-test 2465)
(carmichael-test 2821)
(carmichael-test 6601)
