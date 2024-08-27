# Chapter 1

## Section 1.1

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

Version 1:

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

Version 2:

```scheme
(define (square x) (* x x))
(define (sum-of-squares a b)
  (+ (square a) (square b)))

(define (greater-of a b)
  (if (> a b) a b))

(define (exercise a b c)
  (if (> a b)
      (sum-of-squares a (greater-of b c))
      (sum-of-squares b (greater-of a c))))
```

### Exercise 1.4

This procedure takes the value of an `if` expression (in this case, either `+` or `-`) and uses *it* as an operator in a combination with `a` and `b` as operands. The value computed as a result is equal to $\text{a}+|\text{b}|$.

### Exercise 1.5

In the former case, Ben will observe that the REPL seemingly freezes, as the interpreter enters an infinite loop while trying to evaluate the operand `(p)` in the expression provided.\
In the latter case, Ben will observe that the REPL responds with `0`, since the evaluation of `(p)` is postponed to the `if` expression, where it ends up being skipped all together.

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

## Section 1.2

### Exercise 1.9

The first process is recursive:

```scheme
(+ 4 5)
(inc (+ 3 5))
(inc (inc (+ 2 5)))
(inc (inc (inc (+ 1 5))))
(inc (inc (inc (inc (+ 0 5)))))
(inc (inc (inc (inc 5))))
(inc (inc (inc 6)))
(inc (inc 7))
(inc 8)
9
```

The second is iterative:

```scheme
(+ 4 5)
(+ 3 6)
(+ 2 7)
(+ 1 8)
(+ 0 9)
9
```

### Exercise 1.10

```scheme
> (A 1 10)
1024
> (A 2 4)
65536
> (A 3 3)
65536
```

$f(n) \vcentcolon= A(0,n) = \left\{\begin{array}{ll}
    0 & \text{for } n = 0 \text{,}\\
    2n & \text{otherwise.}
  \end{array}\right\} = 2n$\
$g(n) \vcentcolon= A(1,n) = \left\{\begin{array}{ll}
    0 & \text{for } n = 0 \text{,}\\
    2 & \text{for } n = 1 \text{,}\\
    A(0,A(1,n-1)) & \text{otherwise.}
  \end{array}\right\} = \left\{\begin{array}{ll}
    0 & \text{for } n = 0 \text{,}\\
    2 & \text{for } n = 1 \text{,}\\
    f(g(n-1)) & \text{otherwise.}
  \end{array}\right\} = \begin{cases}
    0 & \text{for } n = 0 \text{,}\\
    2^n & \text{otherwise.}
  \end{cases}$\
$h(n) \vcentcolon= A(2,n) = \left\{\begin{array}{ll}
    0 & \text{for } n = 0 \text{,}\\
    2 & \text{for } n = 1 \text{,}\\
    A(1,A(2,n-1)) & \text{otherwise.}
  \end{array}\right\} = \left\{\begin{array}{ll}
    0 & \text{for } n = 0 \text{,}\\
    2 & \text{for } n = 1 \text{,}\\
    g(h(n-1)) & \text{otherwise.}
  \end{array}\right\} = \begin{cases}
    0 & \text{for } n = 0 \text{,}\\
    \underbrace{2^{2^{\cdotp^{\cdotp^{\cdotp^2}}}}}_n & \text{otherwise.}
  \end{cases}$

### Exercise 1.11

Recursise version:

```scheme
(define (f n) 
  (if (< n 3)
      n
      (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3))))))
```

Iterative version:

```scheme
(define (f n)
  (define (f-iter a b c count)
    (if (= count 0)
        a
        (f-iter b
                c
                (+ (* 3 a) (* 2 b) c)
                (dec count))))
  (f-iter 0 1 2 n))
```

### Exercise 1.12

```scheme
(define (pascal row column)
  (cond ((= column 0) 1)
        ((= row 0) 0)
        ((> column row) 0)  ;; Not strictly necessary, but speeds things up
        (else (+ (pascal (- row 1) column) (pascal (- row 1) (- column 1))))))
```

### Exercise 1.13

Let $\phi = (1+\sqrt{5})/2$ and $\psi = (1-\sqrt{5})/2$.\
First, we prove that $\text{Fib}(n) = (\phi^n - \psi^n)/\sqrt{5}$ for all $n > 0$.\
Second, we show this formula is equivalent to $\text{round}(\phi^n/\sqrt{5})$, completing the proof.

**Part 1:** By induction.\
In the base case, we have $\text{Fib}(0) = (\phi^0-\psi^0)/\sqrt{5} = 0/\sqrt{5} = 0$ and $\text{Fib}(1) = (\phi^1-\psi^1)/\sqrt{5} = \sqrt{5}/\sqrt{5} = 1$, as desired.\
Assume $\text{Fib}(m) = (\phi^m-\psi^m)/\sqrt{5}$ for all $m \leq n$, so that we must prove $\text{Fib}(n+1) = (\phi^{n+1}-\psi^{n+1})/\sqrt{5}$.

```math
\begin{align}
  \text{Fib}(n+1) &= \text{Fib}(n)+\text{Fib}(n-1)\\
  &= \text{Fib}(n)+\text{Fib}(n-1)\\
  &= (\phi^n-\psi^n)/\sqrt{5} + (\phi^{n-1}-\psi^{n-1})/\sqrt{5}
\end{align}

```

Notice that $\phi+\psi = 1$ and that $|\psi^n| < 0.5$ for $n > 1$, such that $round()$
