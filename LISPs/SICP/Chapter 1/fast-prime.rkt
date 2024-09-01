#lang sicp

;; Exercise 1.24

(define (square x) (* x x))
(define (divides? a b) (= (remainder b a) 0))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp) (remainder (square (expmod base (/ exp 2) m)) m))
        (else (remainder (* base (expmod base (- exp 1) m)) m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (start-prime-test n start-time)
  (if (fast-prime? n 20)
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

(run-searches 1000 7)
