#lang sicp

;; Exercise 1.23

(define (square x) (* x x))
(define (divides? a b) (= (remainder b a) 0))

(define (find-divisor n test-divisor)
  (define (next divisor)
    (if (= divisor 2)
        3
        (+ divisor 2)))
  
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))
(define (smallest-divisor n) (find-divisor n 2))

#|
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 2)))))
(define (smallest-divisor n)
  (if (divides? 2 n)
      2
      (find-divisor n 3)))
|#

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
  (define (search-loop counter)
    (cond ((< counter b) (timed-prime-test counter)
                         (search-loop (+ counter 2)))
          (else (newline)
                (display "Done."))))
  (if (divides? 2 a)
      (search-loop (+ a 1))
      (search-loop a)))

(define (run-searches start steps)
  (cond ((= steps 0) (newline)
                     (display "All done."))
        (else (search-for-primes start (+ start 100))
              (run-searches (* start 10) (- steps 1)))))

(run-searches 1000 10)
