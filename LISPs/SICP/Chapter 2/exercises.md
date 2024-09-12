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

### Exercise 2.4

```scheme
(car (cons x y))
(car (lambda (m) (m x y)))
((lambda (m) (m x y)) (lambda (p q) p))
((lambda (p q) p) x y)
x
```

The following defines `cdr` for this representation:

```scheme
(define (cdr z)
  (z (lambda (p q) q)))
```

### Exercise 2.5

The fundamental theorem of arithmetic garantees that, for any integers $a,b,a',b' \geq 0$, $2^{a}3^{b} = 2^{a'}3^{b'}$ if and only if $a = a'$ and $b = b'$. All we need to do is extract the exponents through repeated division.

```scheme
(define (pseudo-log base antilog)
  (define (iter a i)
    (if (= (remainder a base) 0)
        (iter (/ a base) (+ i 1))
        i))
  (iter antilog 0))

(define (cons a b)
  (* (expt 2 a) (expt 3 b)))
(define (car c)
  (pseudo-log 2 c))
(define (cdr c)
  (pseudo-log 3 c))
```

### Exercise 2.6

```scheme
(add-1 zero)
(lambda (f) (lambda (x) (f ((zero f) x))))
(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) x)) f) x))))
(lambda (f) (lambda (x) (f ((lambda (x) x) x))))
(lambda (f) (lambda (x) (f x)))  ;; one
```

```scheme
(add-1 one)
(lambda (f) (lambda (x) (f ((one f) x))))
(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) (f x))) f) x))))
(lambda (f) (lambda (x) (f ((lambda (x) (f x)) x))))
(lambda (f) (lambda (x) (f (f x))))  ;; two
```

Addition can be defined as follows:

```scheme
(define (add-church n m)
  (lambda (f) (lambda (x) ((m f) ((n f) x)))))
```
