;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lab5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/universe)
(require 2htdp/image)
;exercise 1

; A ManyPosn is one of:
;  - 0
;  - (make-many Posn ManyPosn)
 
(define-struct many (posn many))
 
; A Posn is
;  (make-posn Number Number)
; Note: the posn structure is defined in Beginning Student,
; and looks like:
;(define-struct posn (x y))

;processmanyposn :: ManyPosn -> posn
;processmanyposn takes a manyposn and returns some info about it

;(define (processmanyposn mp)
;  (cond
;    [(= (many-ManyPosn mp) 0) ...]
;    [ ... (posn-x (many-Posn mp)) ... (posn-y (many-Posn mp)) 
;          ... (processmanyposn (many-ManyPosn))]))


; exercise 2

(define many1 
  (make-many 
   (make-posn 50 50) 
   (make-many 
    (make-posn 25 25)
    (make-many 
     (make-posn 10 10) 
     0))))

(define many2
  (make-many
   (make-posn 10 10)
   (make-many
    (make-posn 30 35)
    0)))


(define many3
  (make-many
   (make-posn 05 04)
   (make-many
    (make-posn 30 20)
    (make-many
     (make-posn 100 100)
     (make-many
      (make-posn -8 99)
      (make-many
       (make-posn 999 300)
       0))))))

; exercise 3

; many-positive? :: many -> boolean
; many-positive? takes a many and produces a true boolean if all of the 
; posn in that many are positive.

(check-expect (many-positive? many1) true)
(check-expect (many-positive? many2) true)
(check-expect (many-positive? many3) false)

(define (many-positive? mp)
  (cond
    [(not (many? (many-many mp))) true]
    [(or (not (positive? (posn-x (many-posn mp))))
         (not (positive? (posn-y (many-posn mp))))) false]
    [else (many-positive? (many-many mp))]))

; exercise 4

(define-struct ListOfPosn [ls])

; a ls is a list

(define listposn1 
  (make-ListOfPosn (cons (make-posn 10 10)
                       (cons (make-posn 25 25)
                             (cons (make-posn -10 5)
                                   empty)))))
(define listposn2
  (make-ListOfPosn (cons (make-posn 5 5)
                       (cons (make-posn 6 6)
                             (cons (make-posn 2 2)
                                   (cons (make-posn 9 9)
                                         empty))))))
(define listposn3
  (make-ListOfPosn (cons (make-posn 200 200)
                       (cons (make-posn 333 333)
                             (cons (make-posn 155 222)
                                   (cons (make-posn 237 2222)
                                         empty))))))

; exercise 6

; all-positive? :: ListOfPosn -> boolean
; all-positive takes a ListOfPosn and returns a boolean true if all the 
; posns in the list are positive.

(check-expect (all-positive? listposn1) false)
(check-expect (all-positive? listposn2) true)
(check-expect (all-positive? listposn3) true)

(define (all-positive? lp)
  (poshelp (ListOfPosn-ls lp)))
(define (poshelp lp)
  (cond
    [(empty? lp) true]
    [(or (not (positive? (posn-x (car lp))))
         (not(positive? (posn-y (car lp))))) false]
    [else (poshelp (cdr lp))]))


; exercise 8 (there is no 7)

; triangleplot :: ListOfPosn -> image
; triangleplot takes a ManyPosn and produces an image with triangles plotted in
; all of the posns from the ManyPosn


(define (triangleplot lp)
  (triangleplothelp (ListOfPosn-ls lp)))
(define (triangleplothelp ls)
  (cond
    [(empty? ls) (empty-scene 100 100)]
    [else (place-image 
           (triangle 8 "solid" "green")
           (posn-x (car ls)) 
           (posn-y (car ls)) 
           (triangleplothelp (cdr ls)))]))

; exercise 9

; move :: ManyPosn -> ManyPosn
; move takes a ManyPosn and produces a new ManyPosn with all of the 
; y coordinates in the ManyPosn are increased by 1.

(check-expect (move listposn2) (make-ListOfPosn (cons (make-posn 5 6)
                       (cons (make-posn 6 7)
                             (cons (make-posn 2 3)
                                   (cons (make-posn 9 10)
                                         empty))))))
(check-expect (move listposn3) (make-ListOfPosn (cons (make-posn 200 201)
                       (cons (make-posn 333 334)
                             (cons (make-posn 155 223)
                                   (cons (make-posn 237 2223)
                                         empty))))))

(define (move lp)
  (make-ListOfPosn (movehelp (ListOfPosn-ls lp))))

(define (movehelp ls)
  (cond
    [(empty? ls) empty]
    [else (cons (make-posn (posn-x (car ls))
                           (+ (posn-y (car ls)) 1))
                (movehelp (cdr ls)))]))

; exercise 10

; leftpress :: LoP KeyEvent -> LoP
; leftpress takes a LoP and a keyevent and produces a new lop
; if the keyevent is "left"

(define (leftpress lp ke)
  (make-ListOfPosn (leftpresshelp (ListOfPosn-ls lp) ke)))

(define (leftpresshelp ls ke)
  (cond
    [(string=? ke "left")
     (cons (make-posn (random 100)
                      (random 100))
           ls)]
    [else ls]))

; exercise 11

; trianglecrazy :: ListOfPosn -> animation
; trianglecrazy takes a list of posns and produces an animation where the
; posns are plotted as triangles and are moving down the screen. If you 
; press the left arrow, more triangles will appear.



(define (trianglecrazy lop)
  (big-bang lop
            [on-tick move]
            [on-key leftpress]
            [to-draw triangleplot]
            ))













