#lang racket

(provide push-equal)

(define (string->f op)
  (match op
    ["+" +]
    ["-" -]
    ["*" *]
    ["/" /]))

(define (push-equal expr)
  ;(printf "expr = '~a'\n" expr)
  (define ops-lst (regexp-match
                   #px"(\\d+[./]?\\d*)\\s*([-÷+×])\\s*(\\d+[./]?\\d*)"
                   expr))
  (define result 0)
  (match ops-lst
    [(list _ x f y)
     (number->string ((string->f f)
                      (string->number x)
                      (string->number y)))]
    [_ (raise exn:fail:user)]))

