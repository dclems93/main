;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Assignment 2|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/image)

; Step 1: This problem is going to require an input of type
;         integer and will output a picture
; Step 2: The point of this problem is to create a picture and
;         to make it scaleable. First I will have to create the
;         picture.
; Step 3: input: (tree 100)
;         output: this will be a picture of a tree 100 by 100 pixels
;         input: (tree 300) 
;         output: this will be a tree 300 by 300 to scale
; Step 4: the basic template will be as follows:

;       (define (tree size)
;            ( code code code))
;         I will have to draw my basic picture first, and then
;         modify it into a method to make it scalable:
;(place-image (triangle 50 "solid" "green") 
 ;            50 
  ;           50 
   ;          (place-image 
    ;          (triangle 50 "solid" "green") 
     ;         50 
      ;        60 
       ;       (place-image 
        ;       (rectangle 
         ;       10 
          ;      20 
           ;     "solid" 
            ;    "brown")  
             ;  50 
              ; 80 
               ;(empty-scene 100 100))))
;Step 5:


(define t (triangle 50 "solid" "green"))
(define r (rectangle 10 20 "solid" "brown")) 

(define (tree size)
  
  (place-image (triangle (/ size 2) "solid" "green") 
             (/ size 2) 
             (/ size 2) 
             (place-image 
              (triangle (/ size 2) "solid" "green") 
              (/ size 2) 
              (*(/ size 100) 60) 
              (place-image 
               (rectangle 
                (*(/ size 100) 10) 
                (*(/ size 100) 20) 
                "solid" 
                "brown")  
               (/ size 2) 
               (*(/ size 100) 80) 
               (empty-scene size size)))))

(beside/align "bottom" (tree 210) (tree 120) (tree 80) (tree 50) (tree 30))



; Step 1: This problem will take an input of an integer and
;         will output an integer
; Step 2: The point of this program is calculate the pay that 
;         this person will recieve based on how much they work,
;         with $10 being the minimum they will recieve.
; Step 3: input: (payment 2)
;         output: 18
;          input: (payment 4)
;          output: 26
; Step 4: The basic outline will be:
;         (define (payment x)
;             (code code code))
; Step 5:

(define (payment count)
  (+(* count 4) 10))
  
(check-expect (payment 0) 10)
(check-expect (payment 1) 14)
(check-expect (payment 2) 18)
(check-expect (payment 3) 22)
(check-expect (payment 4) 26)
