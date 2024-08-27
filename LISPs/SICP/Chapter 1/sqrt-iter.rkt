#lang sicp

;; Exercise 1.7

(define (sqrt-iter prev-guess guess x)
  (if (good-enough? prev-guess guess)
      guess
      (sqrt-iter guess (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (delta-close? x y delta)
  (< (abs (- x y)) delta))

(define (good-enough? prev-guess guess)
  (delta-close? 1.0 (/ prev-guess guess) 1e-4))

(define (sqrt x)
  (sqrt-iter 0.0 1.0 x))
