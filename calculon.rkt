#lang racket/gui

;; A simple calculator

;; TODO
;; - Keep the current-number a string to which we append until we need to use 
;;     it as a number
;; - Define a button with min-width 30 and use it for the buttons
;; - Allow expressions with parenthesis

(define (get-function fname)
  (match fname
    ["+" +]
    ["-" -]
    ["×" *]
    ["÷" /]))

(define (push-number button)
  (define button-value (send button get-label))
  (define current-display (send display$ get-value))
  (match button-value
    [(regexp #rx"[0-9\\.]")
     (let ([result
            (match current-display    
              [(regexp #rx"^0") button-value]
              [_ (string-append current-display button-value)])])
       ;(printf "Pushed ~a\n" button-value)
       (send display$ set-value result))]
    [_ (send display$ set-value current-display)]))

(define (push-operation button)  
  (define acc (send display$ get-value))
  (define current-operation (send button get-label))
  ;(printf "Pushed ~a\n" current-operation)
  (send display$ set-value (string-append acc current-operation)))

(define (push-equal)  
  (define expr (send display$ get-value))
  (printf "expr = '~a'\n" expr)
  (define ops-lst (regexp-match
                   #px"(\\d+[./]?\\d*)\\s*([-÷+×])\\s*(\\d+[./]?\\d*)"
                   expr))
  (define result 0)
  (match ops-lst
    [(list _ x f y)
     (send display$ set-value (number->string
                               ((get-function f)
                                (string->number x)
                                (string->number y))))]
    [_ (raise exn:fail:user)]))

(define frame (new frame% [label "Calculon"]))

(define display$ (new text-field%
                      (label "")
                      (parent frame)
                      (init-value "0")))

;; Row 1: 9 8 7 +
(define row1 (new horizontal-panel% [parent frame]))

;; ASK: I want a button whose min-width is always 30. I'm afraid 
;; I don't know how to use inheritance (yet).
(new button% [parent row1]
     [label "9"]
     [min-width 30]
     [callback (λ (button event)
                 (push-number button))])

(new button% [parent row1]
     [label "8"]
     [min-width 30]
     [callback (λ (button event)
                 (push-number button))])

(new button% [parent row1]
     [label "7"]
     [min-width 30]
     [callback (λ (button event)
                 (push-number button))])

(new button% [parent row1]
     [label "+"]
     [min-width 30]     
     [callback (λ (button event)
                 (push-operation button))])

;; Row 2: 6 5 4 -
(define row2 (new horizontal-panel% [parent frame]))

(new button% [parent row2]
     [label "6"]
     [min-width 30]     
     [callback (λ (button event)
                 (push-number button))])

(new button% [parent row2]
     [label "5"]
     [min-width 30]
     [callback (λ (button event)
                 (push-number button))])

(new button% [parent row2]
     [label "4"]
     [min-width 30]
     [callback (λ (button event)
                 (push-number button))])

(new button% [parent row2]
     [label "-"]
     [min-width 30]
     [callback (λ (button event)
                 (push-operation button))])

;; Row 3: 3 2 1 *
(define row3 (new horizontal-panel% [parent frame]))

(new button% [parent row3]
     [label "3"]
     [min-width 30]
     [callback (λ (button event)
                 (push-number button))])

(new button% [parent row3]
     [label "2"]
     [min-width 30]
     [callback (λ (button event)
                 (push-number button))])

(new button% [parent row3]
     [label "1"]
     [min-width 30]
     [callback (λ (button event)
                 (push-number button))])

(new button% [parent row3]
     [label "×"]
     [min-width 30]
     [callback (λ (button event)
                 (push-operation button))])

;; Row 4: 0 . = /
(define row4 (new horizontal-panel% [parent frame]))

(new button% [parent row4]
     [label "0"]
     [min-width 30]
     [callback (λ (button event)
                 (push-number button))])

(new button% [parent row4]
     [label "."]
     [min-width 30]
     [callback (λ (button event)
                 (push-number button))])  #| find a better name for the function; 
                                             also do something with the decimal point 
                                             (again) |#

(new button% [parent row4]
     [label "="]
     [min-width 30]
     [callback (λ (b e) ; ASK: do we still need the args if unused?
                 (push-equal))])

(new button% [parent row4]
     [label "÷"]
     [min-width 30]
     [callback (λ (button event)
                 (push-operation button))])

(send frame show #t)
