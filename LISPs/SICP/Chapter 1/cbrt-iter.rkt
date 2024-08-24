#lang sicp

(define (square x) (* x x))
(define (cube x) (* x x x))

(define (cbrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (cbrt-iter (improve guess x) x)))

(define (improve guess x)
  (/ (+ (/ x (square guess)) (* 2.0 guess)) 3.0))

(define (good-enough? guess x)
  (< (abs (- (cube guess) x)) 0.001))

(define (cbrt x)
  (cbrt-iter 1.0 x))
