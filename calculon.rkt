#lang racket/gui

;; A simple calculator


;; TODO
;; - Avoid these horrible set!'s
;; - Define a button with min-width 30 and use it for the buttons


(define current-number 0)
(define op1 0)
(define op2 0)
(define decimal-point #f)
(define current-operation null)

(define (get-function fname)
  (cond
    [(equal? fname "+") +]
    [(equal? fname "-") -]
    [(equal? fname "/") /]
    [(equal? fname "*") *]))

(define (push-number button)
  (set! current-number (+ 
                        (* current-number 10) 
                        (string->number (send button get-label))))
  (send display$ set-value (number->string current-number)))

(define (push-operation button)
  (set! current-operation (send button get-label))
  (set! op1 current-number) ; assuming we only do op1 op op2
  (set! current-number 0))

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
     [callback (lambda (button event)
                 (push-number button))])

(new button% [parent row1]
     [label "8"]
     [min-width 30]
     [callback (lambda (button event)
                 (push-number button))])

(new button% [parent row1]
     [label "7"]
     [min-width 30]
     [callback (lambda (button event)
                 (push-number button))])

(new button% [parent row1]
     [label "+"]
     [min-width 30]     
     [callback (lambda (button event)
                 (push-operation button))])

;; Row 2: 6 5 4 -
(define row2 (new horizontal-panel% [parent frame]))

(new button% [parent row2]
     [label "6"]
     [min-width 30]     
     [callback (lambda (button event)
                 (push-number button))])

(new button% [parent row2]
     [label "5"]
     [min-width 30]
     [callback (lambda (button event)
                 (push-number button))])

(new button% [parent row2]
     [label "4"]
     [min-width 30]
     [callback (lambda (button event)
                 (push-number button))])

(new button% [parent row2]
     [label "-"]
     [min-width 30]
     [callback (lambda (button event)
                 (push-operation button))])

;; Row 3: 3 2 1 *
(define row3 (new horizontal-panel% [parent frame]))

(new button% [parent row3]
     [label "3"]
     [min-width 30]
     [callback (lambda (button event)
                 (push-number button))])

(new button% [parent row3]
     [label "2"]
     [min-width 30]
     [callback (lambda (button event)
                 (push-number button))])

(new button% [parent row3]
     [label "1"]
     [min-width 30]
     [callback (lambda (button event)
                 (push-number button))])

(new button% [parent row3]
     [label "*"]
     [min-width 30]
     [callback (lambda (button event)
                 (push-operation button))])

;; Row 4: 0 . = /
(define row4 (new horizontal-panel% [parent frame]))

(new button% [parent row4]
     [label "0"]
     [min-width 30]
     [callback (lambda (button event)
                 (push-number button))])

(new button% [parent row4]
     [label "."]
     [min-width 30]
     [callback (lambda (button event)
                 (set! decimal-point #t))])

(new button% [parent row4]
     [label "="]
     [min-width 30]
     [callback (lambda (button event)
                 (set! op2 current-number)
                 (set! current-number ((get-function current-operation) op1 op2))
                 (set! op1 0)
                 (set! op2 0)
                 (send display$ set-value (number->string current-number)))])

(new button% [parent row4]
     [label "/"]
     [min-width 30]
     [callback (lambda (button event)
                 (push-operation button))])

(send frame show #t)
