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

Let $\phi = (1+\sqrt{5})/2$ and $\psi = (1-\sqrt{5})/2$, i.e. the pair of real solutions to $1 = 1/x + 1/x^2$. As a consequence, $\phi$ and $\psi$ are also solutions of all equations of the form $x^n = x^{n-1}+x^{n-2}$.\
In order to prove $\text{Fib}(n) = \text{round}(\phi^n/\sqrt{5})$ we will proceed in two major steps. First, we prove that $\text{Fib}(n) = (\phi^n-\psi^n)/\sqrt{5}$ by induction; then, we show this formula is equivalent to $\text{round}(\phi^n/\sqrt{5})$, completing the proof.

**1st part:**\
The base case is stablished as follows:\
$\text{Fib}(0) = (\phi^0-\psi^0)/\sqrt{5} = 0/\sqrt{5} = 0$ and\
$\text{Fib}(1) = (\phi^1-\psi^1)/\sqrt{5} = \sqrt{5}/\sqrt{5} = 1$.\
Then, assuming $\text{Fib}(m) = (\phi^m-\psi^m)/\sqrt{5}$ for all $m < n$:

```math
\begin{align}
  \text{Fib}(n) &= \text{Fib}(n-1)+\text{Fib}(n-2) & \text{By definition.}\\
  &= (\phi^{n-1}-\psi^{n-1})/\sqrt{5} + (\phi^{n-2}-\psi^{n-2})/\sqrt{5} & \text{Apply hypothesis.}\\
  &= (\phi^{n-1}+\phi^{n-2}-(\psi^{n-1}+\psi^{n-2}))/\sqrt{5} & \text{Factor and regroup.}\\
  &= (\phi^n-\psi^n)/\sqrt{5} & \text{Properties of } \phi \text{ and } \psi \text{.}
\end{align}
```

as desired.

**2nd part:**\
Notice that $\text{round}(x+\epsilon) = \text{round}(x)$ as long as $|\epsilon| < 0.5$, and also that $\text{Fib}(n) = \text{round}(\text{Fib}(n)) = \text{round}(\phi^n/\sqrt{5}-\psi^n/\sqrt{5})$, as proved above.\
Therefore, $\text{Fib}(n) = \text{round}(\phi^n/\sqrt{5})$ as long as $|-\psi^n/\sqrt{5}| < 0.5$.\
Since $|-\psi^n/\sqrt{5}| = |\psi|^n/\sqrt{5}$, we need only that $|\psi|^n < \sqrt{5}/2$, but $|\psi| < 1$, and so the proof is complete.

$\blacksquare$

### Exercise 1.14

Draw the tree illustrating the process gen-
erated by the count-change procedure of Section 1.2.2 in
making change for 11 cents. What are the orders of growth
of the space and number of steps used by this process as
the amount to be changed increases?

```scheme
(count-change 11)
(cc 11 5)
  (cc 11 4)
  | (cc 11 3)
  | | (cc 11 2)
  | | | (cc 11 1)
  | | | | (cc 11 0)  ;; 0
  | | | | (cc 10 1)
  | | | |   (cc 10 0)  ;; 0
  | | | |   (cc 9 1)
  | | | |     (cc 9 0)  ;; 0
  | | | |     (cc 8 1)
  | | | |       (cc 8 0)  ;; 0
  | | | |       (cc 7 1)
  | | | |         (cc 7 0)  ;; 0
  | | | |         (cc 6 1)
  | | | |           (cc 6 0)  ;; 0
  | | | |           (cc 5 1)
  | | | |             (cc 5 0)  ;; 0
  | | | |             (cc 4 1)
  | | | |               (cc 4 0)  ;; 0
  | | | |               (cc 3 1)
  | | | |                 (cc 3 0)  ;; 0
  | | | |                 (cc 2 1)
  | | | |                   (cc 2 0)  ;; 0
  | | | |                   (cc 1 1)
  | | | |                     (cc 1 0)  ;; 0
  | | | |                     (cc 0 1)  ;; 1
  | | | (cc 6 2)
  | | |   (cc 6 1)
  | | |   | (cc 6 0)  ;; 0
  | | |   | (cc 5 1)
  | | |   |   (cc 5 0)  ;; 0
  | | |   |   (cc 4 1)
  | | |   |     (cc 4 0)  ;; 0
  | | |   |     (cc 3 1)
  | | |   |       (cc 3 0)  ;; 0
  | | |   |       (cc 2 1)
  | | |   |         (cc 2 0)  ;; 0
  | | |   |         (cc 1 1)
  | | |   |           (cc 1 0)  ;; 0
  | | |   |           (cc 0 1)  ;; 1
  | | |   (cc 1 2)
  | | |     (cc 1 1)
  | | |     | (cc 1 0)  ;; 0
  | | |     | (cc 0 1)  ;; 1
  | | |     (cc -4 2)  ;; 0
  | | (cc 1 3)
  | |   (cc 1 2)
  | |   | (cc 1 1)
  | |   | | (cc 1 0)  ;; 0
  | |   | | (cc 0 1)  ;; 1
  | |   | (cc -4 2)  ;; 0
  | |   (cc -9 3)  ;; 0
  | (cc -14 4) ;; 0
  (cc -39 5)  ;; 0
```

The order of growth of the space used by a process is proportional to the depth of it's tree. In this case, the tree grows as deep as $\text{amount}+5$ (corresponding to the case where only pennies are used), that is, it grows in $\Theta(\text{amount})$.\
The order of growth of the number of the steps used by a process is proportional to the number of nodes in it's tree. The exact value is hard to pin down in this case, but...\
Let $R(a,k)$ be the number of calls to `cc` invoqued by evaluating `(cc a k)` with $a$ in for `a` and $k$ in for `k`.\
Notice that $R(a, 1) = 2a+1 = \Theta(a)$ and that $R(a, 2) = 1+\lceil a/5 \rceil+\sum_{i=0}^{\lceil a/5 \rceil-1}R(a-5i,1)$. That is, $R(a,2) = \Theta(a^2)$, since we're adding a number of $\Theta(a)$ terms proportional to $a$.\
In general, if $d(k)$ is the denomination of a coin of kind $k$, then $R(a,k) = 1+\lceil a/d(k) \rceil+\sum_{i=0}^{\lceil a/d(k) \rceil-1}R(a-d(k)i,k-1)$; so that $R(a,k)$ is $\Theta(a^k)$, by induction, in accordance with sum.\
This suggests `count-change` is $\Theta(\text{amount}^5)$ in the number of steps.

```scheme
(cc 'a 2)         ;; 0
  (cc 'a 1)       ;; R(a,1)
  (cc 'a-5 2)     ;; 1
    (cc 'a-5 1)   ;; R(a-5,1)
    (cc 'a-10 2)  ;; 2
      ...         ;; ...
        (cc 5 1)  ;; R(5,1)
        (cc 0 2)  ;; a/5
```

### Exercise 1.15

**a.** Exactly 5 times, as revealed by the test:

```scheme
(define (sine-count angle count) 
  (if (not (> (abs angle) 0.1))
      count
      (sine-count (/ angle 3.0) (inc count))))
(sine-count 12.5 0)
```

**b.** The order of growth of this process is $\Theta(\log a)$ in both space and number of steps. More precisely, we have that $R(a) = \lceil \log_3 a - \log_3 0.1 \rceil$ is the resource function in both cases.

### Exercises 1.16

```scheme
(define (fast-expt b n)
  (define (expt-iter b n a)
    (cond ((= n 0) a)
          ((even? n) (expt-iter (square b) (/ n 2) a))
          (else (expt-iter b (- n 1) (* a b)))))
  (expt-iter b n 1))
```

### Exercises 1.17

```scheme
(define (fast-mult a b)
  (cond ((= b 0) 0)
        ((even? b) (double (fast-mult a (halve b))))
        (else (+ a (fast-mult a (- b 1))))))
```

### Exercises 1.18

```scheme
(define (fast-mult a b)
  (define (mult-iter a b c)
    (cond ((= b 0) c)
          ((even? b) (mult-iter (double a) (halve b) c))
          (else (mult-iter a (- b 1) (+ c a)))))
  (mult-iter a b 0))
```

### Exercises 1.19

```math
\begin{align}
  T^2_{pq}(a,b) &= T_{pq}(bq+aq+ap,bp+aq)\\
  &= (bpq+aq^2+bq^2+aq^2+apq+bpq+apq+ap^2,bp^2+apq+bq^2+aq^2+apq)\\
  &= (b(pq+q^2+pq)+a(q^2+pq+pq)+a(q^2+p^2),b(p^2+q^2)+a(pq+q^2+pq))\\
  &= T_{(p^2+q^2)(q^2+2pq)}(a,b)
\end{align}
```

That is, $p' = p^2+q^2$ and $q' = q^2+2pq$.\
See [fast-fib](fast-fib.rkt).

### Exercises 1.20

Normal-order evaluation:

```scheme
(gcd 206 40)
(gcd 40 (remainder 206 40))
;(remainder 206 40)
(gcd (remainder 206 40)
     (remainder 40 (remainder 206 40)))
;(remainder 40 (remainder 206 40))
(gcd (remainder 40 (remainder 206 40))
     (remainder (remainder 206 40)
                (remainder 40 (remainder 206 40))))
;(remainder (remainder 206 40)
;           (remainder 40 (remainder 206 40)))
(gcd (remainder (remainder 206 40)
                (remainder 40 (remainder 206 40)))
     (remainder (remainder 40 (remainder 206 40))
                (remainder (remainder 206 40)
                           (remainder 40 (remainder 206 40)))))
;(remainder (remainder 40 (remainder 206 40))
;           (remainder (remainder 206 40)
;                      (remainder 40 (remainder 206 40))))
(remainder (remainder 206 40)                
           (remainder 40 (remainder 206 40)))

;; 18 remainders performed
```

Applicative-order evaluation:

```scheme
(gcd 206 40)
;(remainder 206 40)
(gcd 40 6)
;(remainder 40 6)
(gcd 6 4)
;(remainder 6 4)
(gcd 4 2)
;(remainder 4 2)
(gcd 2 0)

;; 4 remainders performed
```

### Exercises 1.21

```scheme
> (smallest-divisor 199)
199
> (smallest-divisor 1999)
1999
> (smallest-divisor 19999)
7
```

### Exercises 1.22

See [search-for-primes](search-for-primes.rkt).\
The timing data does not bear out a $\sqrt{10}$ times increase going from 1'000 to 10'000, and it shows a two times increase going from 100'000 to 1'000'000. However, as the numbers get 10 times bigger, the growth ratio seems to approach the predicted value.\
This suggests that the time spent running a program is, indeed, proportional to the number of steps required for the computation, in my machine.

### Exercises 1.23

See [find-divisor](find-divisor.rkt).\
The data does not confirm our expectations here, and it seems the ratio of the speeds of the different versions is closer to 3/2. This discrepancy can be explained by the added overhead of an equality check every iteration.\
The following replacements provide the desired 2 times speed up.

```scheme
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 2)))))
(define (smallest-divisor n)
  (if (divides? 2 n)
      2
      (find-divisor n 3)))
```

### Exercises 1.24

See [fast-prime](fast-prime.rkt).\
We would expect the test times to grow linearly as the numbers increase exponentially, and this prediction is vindicated by the data.

### Exercises 1.25

She is correct in a mathematical sense, but this procedure is inadequate for our purposes.\
In prime testing large numbers, we would end up having to incur the performance costs of representing (and multiplying) much much larger numbers, when we could be taking remainders along the way very cheaply.

### Exercises 1.26

By expanding the definition of `square` where they did, Louis garantees that `expmod` will call itself recursively twice whenever it would usually do it once. This change makes the number of nodes in the corresponding tree grow exponentially with it's depth, which is logarithmic with respect to the input, resulting in an overall $\Theta(n)$ order of growth in time.

### Exercises 1.27

See [carmichael-test](carmichael-test.rkt).

### Exercises 1.28

See [miller-rabin-test](miller-rabin-test.rkt).

## Section 1.3

### Exercise 1.29

### Exercise 1.30

### Exercise 1.31

### Exercise 1.32

### Exercise 1.33

### Exercise 1.34

### Exercise 1.35

### Exercise 1.36

### Exercise 1.37

### Exercise 1.38

### Exercise 1.39

### Exercise 1.40

### Exercise 1.41

### Exercise 1.42

### Exercise 1.43

### Exercise 1.44

### Exercise 1.45

### Exercise 1.46
