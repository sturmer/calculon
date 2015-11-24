#lang racket

(require rackunit
         rackunit/text-ui
         "calculon.rkt")

(module+ test
  (define suite
    (test-suite
     "calculon: callback tests"
     
     (test-case
      "Check equal callback"
      (check-equal? (push-equal "8+5") "13")
      (check-equal? (push-equal "12.11  - 14.03") "-1.92")
      ;(check-equal? (push-equal "4/5 * 3") "12/5")  ; FIXME
      ;(check-equal? (push-equal "20/3 * 1/5") "10.0") ; FIXME
      )))
  (run-tests suite))
