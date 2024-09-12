# Chapter 2

## Section 2.1

### Exercise 2.1

```scheme
(define (make-rat n d)
  (let ((g (gcd n d))  ;; always positive
        (neg (if (negative? d)
                 -
                 identity)))
    (cons (neg (/ n g))
          (abs (/ d g)))))
```

### Exercise 2.2

```scheme
(define (make-point x y)
  (cons x y))
(define (x-point p)
  (car p))
(define (y-point p)
  (cdr p))

(define (make-segment p1 p2)
  (cons p1 p2))
(define (start-segment seg)
  (car seg))
(define (end-segment seg)
  (cdr seg))

(define (midpoint-segment seg)
  (let ((start (start-segment seg))
        (end (end-segment seg)))
    (make-point (average (x-point start) (x-point end))
                (average (y-point start) (y-point end)))))
```

### Exercise 2.3

We can define the area and perimeter procedures in terms of the height and width selectors as follows:

```scheme
(define (perimeter-rect r)
  (* 2 (+ (height-rect r) (width-rect r))))
(define (area-rect r)
  (* (height-rect r) (width-rect r)))
```

Then, we can represent rectangles however we like. The following examples use the 'point' abstraction from [Exercise 2.2](#exercise-22).

```scheme
(define (make-rect top bottom right left)
  (list top bottom right left))
(define (top-rect r)
  (car r))
(define (bottom-rect r)
  (cadr r))
(define (right-rect r)
  (caddr r))
(define (left-rect r)
  (cadddr r))
(define (center-rect r)
  (make-point (average (right-rect r) (left-rect r))
              (average (top-rect r) (bottom-rect r))))
(define (height-rect r)
  (- (top-rect r) (bottom-rect r)))
(define (width-rect r)
  (- (right-rect r) (left-rect r)))
```

```scheme
(define (make-rect center height width)
  (list center height width))
(define (center-rect r)
  (car r))
(define (height-rect r)
  (cadr r))
(define (width-rect r)
  (caddr r))
(define (top-rect r)
  (+ (y-point (center-rect r)) (/ (height-rect r) 2)))
(define (bottom-rect r)
  (- (y-point (center-rect r)) (/ (height-rect r) 2)))
(define (right-rect r)
  (+ (x-point (center-rect r)) (/ (width-rect r) 2)))
(define (left-rect r)
  (- (x-point (center-rect r)) (/ (width-rect r) 2)))
```
