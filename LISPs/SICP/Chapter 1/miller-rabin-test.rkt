#lang sicp

;; Exercise 1.24

(define (square x) (* x x))

(define (expmod-signal base expo m)
  (define (zero-if-one x)
    (if (= x 1) 0 x))
  (define (zero-if-nontrivial x)
    (cond ((or (= x 1) (= x (- m 1))) 1)
          (else (zero-if-one (remainder (square x) m)))))
  (cond ((or (= expo 0) (= base 1)) 1)
        ((= base 0) 0)
        ((even? expo) (zero-if-nontrivial (expmod-signal base (/ expo 2) m)))
        (else (remainder (* base (expmod-signal base (- expo 1) m)) m))))

(define (miller-rabin-test n)
  (define (try-it a)
    (= (expmod-signal a (- n 1) n) 1))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((miller-rabin-test n) (fast-prime? n (- times 1)))
        (else false)))

(fast-prime? 21 10)
(fast-prime? 22 10)
(fast-prime? 23 10)
(fast-prime? 25 10)
(fast-prime? 27 10)
(fast-prime? 29 10)
(fast-prime? 31 10)
(newline)
(fast-prime? 561 10)
(fast-prime? 1105 10)
(fast-prime? 1729 10)
(fast-prime? 2465 10)
(fast-prime? 2821 10)
(fast-prime? 6601 10)
