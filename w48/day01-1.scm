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

      ;; Map over numbers and their right neighbors.
      ;; Add the number to the sum if they are the same.
      (+
       ;; Special case for wraparound.
       (if (equal? (car numbers)
                   (car (take-right numbers 1)))
           (car numbers) 0)
       (reduce + 0
        (filter-map (lambda (x y)
                      (and (equal? x y) x))
                    numbers
                    (cdr numbers)))))))
