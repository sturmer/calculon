#lang racket/gui

(require "calculon.rkt")

;; A simple calculator

;; TODO
;; Add something
;; - Define a button with min-width 30 and use it for the buttons
;; - Allow expressions with parenthesis

;; GUI-related functions
;; More than one change
;; Push a button of an operation (+, -, ...)
(define (push-operation op)
  (send display$ set-value (string-append (send display$ get-value) op)))

;; Push a button which is not an op (digit, decimal value)
(define (push-number button-value)
  (define current-display (send display$ get-value))
  (define result
    (match current-display
      [(regexp #rx"^0") button-value]
      [_ (string-append current-display button-value)]))
  (send display$ set-value result))

(define frame (new frame% [label "Calculon"]))

(define display$ (new text-field%
                      (label "")
                      (parent frame)
                      (init-value "0")))

;; Row 0: ? ? sqrt C
(define row0 (new horizontal-panel% [parent frame]))
(new button% [parent row0]
     [label ""]
     [min-width 30]
     [enabled #f])
(new button% [parent row0]
     [label ""]
     [min-width 30]
     [enabled #f])
(new button% [parent row0]
     [label ""]
     [min-width 30]
     [enabled #f])
(new button% [parent row0]
     [label "R"]
     [min-width 30]
     [callback (λ (b e)
                 (send display$ set-value "0"))])

;; Row 1: 9 8 7 +
(define row1 (new horizontal-panel% [parent frame]))

;; ASK: I want a button whose min-width is always 30. I'm afraid 
;; I don't know how to use inheritance (yet).
(new button% [parent row1]
     [label "9"]
     [min-width 30]
     [callback (λ (button event)
                 (push-number 9))])

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
                 (push-operation "+"))])

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
                 (push-operation "-"))])

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
                 (push-operation "*"))])

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
                 (define expr (send display$ get-value))
                 (send display$ set-value (push-equal expr)))])

(new button% [parent row4]
     [label "÷"]
     [min-width 30]
     [callback (λ (button event)
                 (push-operation "/"))])

(send frame show #t)
