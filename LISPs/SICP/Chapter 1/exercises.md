## Round 1
### Exercise 1.1
```scheme
> 10
10
> (+ 5 3 4)
12
> (- 9 1)
8
> (/ 6 2)
3
> (+ (* 2 4) (- 4 6))
6
> (define a 3)
> (define b (+ a 1))
> (+ a b (* a b))
19
> (= a b)
#f
> (if (and (> b a) (< b (* a b)))
      b
      a)
4
> (cond ((= a 4) 6)
        ((= b 4) (+ 6 7 a))
        (else 25))
16
> (+ 2 (if (> b a) b a))
6
> (* (cond ((> a b) a)
           ((< a b) b)
           (else -1))
     (+ a 1))
16
```
### Exercise 1.2
```scheme
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
   (* 3 (- 6 2) (- 2 7)))
```
### Exercise 1.3
```scheme
(define (square x) (* x x))
(define (least-of-two a b)
  (if (< a b) a b))
(define (least-of-three a b c)
  (least-of-two (least-of-two a b) c))
(define (sum-of-three-squares a b c)
  (+ (square a) (square b) (square c)))
(define (exercise a b c)
  (- (sum-of-three-squares a b c) (square (least-of-three a b c))))
```
### Exercise 1.4
This procedure takes the result of an expression using the `if` operator (in this case, either `+` or `-`) and uses *it* as an operator on `a` and `b`. It is equivalent, in evaluation, to the sum of the first argument with the absolute value of the second.
### Exercise 1.5
In the former case, Ben will observe that the REPL seemingly freezes, as the interpreter enters an infinite loop while trying to evaluate the operand `(p)` in the expression provided.\
In the latter case, Ben will simply observe the REPL reply with `0`.

## Round 2
### Exercise 1.6
When Alyssa attempts to use `sqrt`, she will notice that the REPL freezes, as it did in Ben's experiment. This happens because, unlike in the case of `if`, an expression using `new-if` as an operator will have all of it's operands evaluated regardless, including the recursive call to `sqrt-iter`.
### Exercise 1.7
