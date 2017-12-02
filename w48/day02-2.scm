#!/usr/bin/env gosh

;; Chris Smeele, 2017.

(define (slurp-table-file filename)
  (let loop ((p (open-input-file filename))
             (table '()))
    (let ((v (read-line p)))
      (if (eof-object? v)
          (reverse table)
          (loop p (cons (map string->number (string-split v #\tab))
                        table))))))

;; Return x/y if they are divisible, #f otherwise.
(define (divide-if-divisible x y)
  (and (equal? 0 (modulo x y))
       (div x y)))

;; Return all possible pairs (disregarding order of elements within each pair)
;; for the given list.
(define (pairmutations l)
  (if (length>=? l 2)
      (append
        (map (lambda (el)
                (cons (car l) el))
            (cdr l))
        (pairmutations (cdr l)))
      '()))

(define (main args)
  (when (not (length=? args 2))
    (format (current-error-port)
            "usage: ~a INPUT-FILE~%"
            (car args))
    (exit 2))
  (format #t "~a~%"
    (reduce + 0
      (map (lambda (row)
             (any (lambda (pair)
                    (or (divide-if-divisible (car pair) (cdr pair))
                        (divide-if-divisible (cdr pair) (car pair))))
                  (pairmutations row)))
           (slurp-table-file (cadr args))))))
