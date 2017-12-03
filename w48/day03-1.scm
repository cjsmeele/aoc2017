#!/usr/bin/env gosh

;; Chris Smeele, 2017.

;; 65 64 63 62 61 60 59 58 57
;; 66 37 36 35 34 33 32 31 56
;; 67 38 17 16 15 14 13 30 55
;; 68 39 18  5  4  3 12 29 54
;; 69 40 19  6  1  2 11 28 53
;; 70 41 20  7  8  9 10 27 52
;; 71 42 21 22 23 24 25 26 51
;; 72 43 44 45 46 47 48 49 50
;; 73 74 75 76 77 78 79 80 81

;; Round a number upwards to an uneven square.
;; (e.g. 10 => 25, 2 => 9, 55 => 81, 9 => 9)
;; This gets us the lower-right corner of n's layer.
(define (nearest-uneven-square n)
  (if (equal? n 1)
      #f
      (if (even? n)
          (nearest-uneven-square (+ n 1))
          (or (and (integer? (sqrt n)) n)
              (nearest-uneven-square (+ n 2))))))

(define (main args)
  (when (not (length=? args 2))
    (format (current-error-port)
            "usage: ~a NUMBER~%"
            (car args))
    (exit 2))
  (let ((number (string->number (cadr args))))
    (format #t "~a~%"
      (if (equal? number 1)
          0
          (letrec* (;; nus   = value in lower right corner of number's layer.
                    (nus          (nearest-uneven-square number))
                    ;; pnus  = same, for one layer closer to 1.
                    (pnus         (expt (- (sqrt nus) 2) 2))
                    ;; layer = the amount of steps from the center
                    ;;         to number's layer.
                    (layer        (/    (- (sqrt nus) 1) 2))
                    (layer-size   (- nus pnus))
                    (quarter-size (/ layer-size 4))
                    (local-n      (- number pnus))
                    ;; determine the intralayer distance to a position
                    ;; that is aligned with '1' on either axis.
                    (distance-to-any-axis-center
                     (abs (- (/ quarter-size 2)
                             (modulo local-n quarter-size)))))
            ;; Now it's only a simple addition. :-)
            (+ layer distance-to-any-axis-center))))))
