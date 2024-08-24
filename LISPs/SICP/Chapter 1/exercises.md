# Chapter 1

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
(define (least-of-two a b)
  (if (< a b) a b))
(define (least-of-three a b c)
  (least-of-two (least-of-two a b) c))

(define (square x) (* x x))
(define (sum-of-three-squares a b c)
  (+ (square a) (square b) (square c)))

(define (exercise a b c)
  (- (sum-of-three-squares a b c) (square (least-of-three a b c))))
```

### Exercise 1.4

This procedure takes the value of an `if` expression (in this case, either `+` or `-`) and uses *it* as an operator in a combination with `a` and `b` as operands. The value computed as a result is equal to $\text{a}+|\text{b}|$.

### Exercise 1.5

In the former case, Ben will observe that the REPL seemingly freezes, as the interpreter enters an infinite loop while trying to evaluate the operand `(p)` in the expression provided.\
In the latter case, Ben will observe that the REPL responds with `0`, since the evaluation of `(p)` is postponed to the `if` expression, where it ends up being skipped all together.

## Round 2

### Exercise 1.6

When Alyssa attempts to use `sqrt`, she will notice that the REPL freezes, as it did in Ben's experiment. This happens because, unlike in the case of `if`, an expression using `new-if` as an operator will have all of it's operands evaluated eagerly, which entails calling `sqrt-iter` recursively.

### Exercise 1.7

When we wish to find the square root of a very small number, `good-enough?` will be satisfied as soon as the guess nears $\sqrt{0.001}$, which might leave us way off the actual value.

```scheme
> (sqrt 1e-18)  ;; actual value: 1e-9
0.03125000000000001
> (good-enough? 0.03125 1e-18)  ;; should not be good
#t
```

In the case of very large numbers, `good-enough?` will often never be satisfied once our machine cannot represent numbers up to 3 decimal places near the search value.

```scheme
> (sqrt 1e13)  ;; interpreter hangs
> (good-enough? 3162277.66017 1e13)  ;; should be good
#f
```

The altered version of the procedure does work better for numbers big and small. See [sqrt-iter](sqrt-iter.rkt).

 ```scheme
 > (sqrt 1e-18)
 1.0000000000000023e-9
 > (sqrt 1e13)
 3162277.6640104805
 ```

### Exercise 1.8

See [cbrt-iter](cbrt-iter.rkt).
