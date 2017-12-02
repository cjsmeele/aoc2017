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

(define (main args)
  (when (not (length=? args 2))
    (format (current-error-port)
            "usage: ~a INPUT-FILE~%"
            (car args))
    (exit 2))
  (format #t "~a~%"
    (reduce + 0
      (map (lambda (row)
             (- (apply max row)
                (apply min row)))
           (slurp-table-file (cadr args))))))
