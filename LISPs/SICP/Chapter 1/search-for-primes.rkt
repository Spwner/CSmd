#lang sicp

;; Exercise 1.22

(define (square x) (* x x))
(define (divides? a b) (= (remainder b a) 0))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (smallest-divisor n) (find-divisor n 2))
(define (prime? n) (= n (smallest-divisor n)))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (search-for-primes a b)
  (define (search-with-counter c)
    (cond ((< c b) (timed-prime-test c)
                   (search-with-counter (+ c 2)))
          (else (newline)
                (display "Done."))))
  (if (divides? 2 a)
      (search-with-counter (+ a 1))
      (search-with-counter a)))


(define one-million 1000000)
(define one-hundred-million (* 100 one-million))
(define ten-billion (* 100 one-hundred-million))
(define one-trillion (* 100 ten-billion))

(search-for-primes one-million (+ one-million 100))
(search-for-primes one-hundred-million (+ one-hundred-million 100))
(search-for-primes ten-billion (+ ten-billion 100))
(search-for-primes one-trillion (+ one-trillion 100))
