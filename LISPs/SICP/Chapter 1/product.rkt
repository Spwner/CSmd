#lang sicp

;; Exercise 1.31

(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (iter-product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))

(define (factorial n)
  (product identity 1 inc n))

(define (pi-approx n)
  (define (term x)
    (define 4x^2 (* 4.0 (* x x)))
    (/ 4x^2 (- 4x^2 1)))
  (* 2 (iter-product term 1 inc n)))

(factorial 0)
(factorial 1)
(factorial 2)
(factorial 3)
(factorial 4)
(factorial 5)

(pi-approx 100)
(pi-approx 1000)
(pi-approx 10000)
(pi-approx 100000)
(pi-approx 1000000)
