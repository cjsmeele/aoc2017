#!/usr/bin/env gosh

;; Chris Smeele, 2017.

(define (main args)
  (when (not (length=? args 2))
    (format (current-error-port)
            "usage: ~a NUMBER-STRING~%"
            (car args))
    (exit 2))
  (format #t "~a~%"
    (letrec* ((numbers (map digit->integer
                            (string->list (cadr args))))
              (len (length numbers)))

      (reduce + 0
        ;; Map over numbers and the second half of numbers.
        ;; When two values are the same, add both of them.
        ;; map will quit when the second list is exhausted,
        ;; so we don't need to halve the first list first.
        (filter-map (lambda (x y)
                      (and (equal? x y) (+ x y)))
                    numbers
                    (drop numbers (div len 2)))))))
