#lang sicp

;; Exercise 1.29

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (simp-integral f a b n)
  (define h (/ (- b a) n))
  (define (y k)
    (f (+ a (* k h))))
  (define (simp-term k)
    (if (even? k)
        (* 2 (y k))
        (* 4 (y k))))
  (/ (* h (+ (y 0) (sum simp-term 1 inc (- n 1)) (y n))) 3))

(define (cube x) (* x x x))


(simp-integral cube 0.0 1.0 100)
(simp-integral cube 0.0 1.0 1000)
(simp-integral cube 0.0 1.0 10000)
(simp-integral cube 0.0 1.0 100000)
