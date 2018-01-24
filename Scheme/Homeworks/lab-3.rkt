;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname labe-three-c211-sp15) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/image)
;; Lab 3 
;; Dylan Clements

;; 13:
;; a. my input will be two integers and my output will be an integer
;; b. input is 3 4 output will be 5
;;    input is 4 5 output will be (sqrt 41)
;;    input is 5 6 output will be (sqrt 61)
;; c. distanceorigin 
;; d. distanceorigin: Int Int -> Int
;; e. The purpose pf this function is to produce the distance to the origin of a point
;; f. (distanceorigin inputa inputb) -> 5
;; g. (define (distanceorigin x y)
;;           (... x x ... y y) )
;; h. 


(define (distanceorigin x y)
  (sqrt (+ (* x x) (* y y))))

;; i.
(check-expect (distanceorigin 3 4) 5)
;; I would use more check-expect statements but check-expect requires exact numbers
;; and will not work with the sqrt function to compare the results




;;14;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; a. my input will be an integer and my output will be an integer
;; b. input is 3 output will be 27
;;    input is 4 output will be 64
;;    input is 5 output will be 125
;; c. cubevolume
;; d. cubevolume: Int -> Int
;; e. The purpose pf this function is to produce volume of a cube with the given side-length
;; f. (cubevolume 3) -> 27
;; g. (define (cubevolume x)
;;           (... x x x ....) )
;; h. 
(define (cubevolume x)
  (*(* x x) x))
;; i.
(check-expect (cubevolume 4) 64)
(check-expect (cubevolume 5) 125)

;; 15;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; a. my input will be a string and my output will be a string of length 1
;; b. input "this" output will be "t"
;;    input "randy" outpit will be "r"
;;    input "steve" output will be "s"
;; c. string-first
;; d. string-first: string -> string
;; e. The purpose of this function is to produce the first letter of a string
;; f. (string-first "this") -> t
;; g. (define (string-first str)
;;           (... str ... ) )
;; h. 

(define (string-first str)
  (string-ith str 0))
;; i. 
(check-expect (string-first "this") "t")
(check-expect (string-first "steve") "s")
(check-expect (string-first "randy") "r")
;;16;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; a. my input will be a string and my output will be a string of size one
;; b. input "this" output will be "s"
;;    input "steve" output will be "e"
;;    input "rufus" output will be "s"
;; c. string-last 
;; d. string-last: string -> string
;; e. The purpose pf this function is to produce the last letter of a given string
;; f. (string-last "steve") -> "e"
;; g. (define (string-last str)
;;           (...str...) )
;; h. 

(define (string-last str)
  (string-ith str (- (string-length str) 1)))

;; i.
(check-expect (string-last "this") "s")
(check-expect (string-last "that") "t")


;;17;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; a. my input will be two booleans my output will be a boolean
;; b. input is false false output will be false
;;    input is true true outpit will be false
;;    input is false true output will be true
;; c. bool-imply
;; d. bool-imply: bool bool -> bool
;; e. The purpose of this function is to check and see if two bools imply eachother
;; f. (bool-imply false true) -> true
;; g. (define (bool-imply sunny Friday)
;;           (... sunny ... Friday) )
;; h. 
(define (bool-imply sunny Friday)
  (if (and (not sunny) Friday) #true #false))

(check-expect (bool-imply false true) true)
(check-expect (bool-imply true true) false)

;;18;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; a. my input will be an img my output will be an int
;; b. input is (square 5) output will be 25
;;    input is (square 10) outpit will be 100
;; c. image-area 
;; d. image-area: image -> Int
;; e. The purpose pf this function is to produce the area of an image in terms of pixels
;; f. (image-area (square 5 "solid" "red")) -> 25
;; g. (define (image-area img)
;;           (...image-height img ...image-width img ...) )
;; h. 


(define (image-area img)
  (* (image-width img) (image-height img)))

(check-expect (image-area (square 5 "solid" "red")) 25)
(check-expect (image-area (square 10 "solid" "blue")) 100)

;;19;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; a. my input will be an image my output will be a string
;; b. input (square 5 "solid" "red") output will be "square"
;;    input is (rectangle 4 5) outpit will be "tall"
;; c. image-classify 
;; d. image-classify: image -> str
;; e. The purpose pf this function is to classify the size of an image
;; f. (image-classify (square 5 "solid" "red")) -> "square"
;; g. (define (image-classify img)
;;           (... img ... "wide") )
;; h. 

(define (image-classify img)
  (if (> (image-height img) (image-width img))
      "tall"
      (if (> (image-width img) (image-height img))
      "wide"
      "square")))

(check-expect (image-classify (square 5 "solid" "red")) "square")

;;20;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The purpose of this is to append two strings together with "_" in the middle
;; string-join: string string -> string
;; (string-join "this" "that") -> "this_that"
;; (define (string-join str1 str2)
;;        (str1.... str2....)))
(define (string-join str1 str2)
  (string-append str1 "_" str2))

(check-expect (string-join "this" "that") "this_that")

;;21;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; string-insert : string int -> string
;; the purpose of this function is to take a string and a number and place _ in the ints place
;; (string-insert "this" 0) -> "_his"
;; (string-insert "this" 1) -> "t_is"
;; (define (string-insert str i)
;;       (str... i)))

(define (string-insert str i)
  (if (> (string-length str) 0)
      (string-append (substring str 0 i) "_" (substring str (+ i 1) (string-length str)))
      str))

(check-expect (string-insert "this" 0) "_his")
(check-expect (string-insert "this" 1) "t_is")

;;22;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; string-delete : string int -> string
;; the purpose of this function is to take a string and a number and delete the letter in the int place
;; (string-delete "this" 0) -> "his"
;; (string-insert "this" 1) -> "tis"
;; (define (string-delete str i)
;;       (str... i)))
(define (string-delete str i)
  (if (> (string-length str) 0)
      (string-append (substring str 0 i) (substring str (+ i 1) (string-length str)))
      str))

(check-expect (string-delete "this" 0) "his")
(check-expect (string-delete "this" 1) "tis")


