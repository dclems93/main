;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lab6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/batch-io)
(require 2htdp/universe)
(require 2htdp/image)

; Lab6
; Dylan Clements

; exercise 1

; processlos :: ListOfStrings -> info
; processlos takes a list of strings and returns ..something

(define-struct ListOfStrings [ls])

;(define (procsesslos los)
;  (cond
;    [(empty? los) ...]
;    [else (cons (car (ListOfStrings-ls los)) ...
;                (processlos (cdr (ListOfStrings-ls los))))]))

; exercise 2

; has-word? :: ListOfStrings String -> boolean
; has-word? tales a ListOfStrings and a String and returns true if that
; string is withing the ListOfStrings

(define (has-string? los str)
  (cond
    [(empty? (ListOfStrings-ls los)) false]
    [(string=? (car (ListOfStrings-ls los)) str) true]
    [else (has-string? 
           (make-ListOfStrings (cdr (ListOfStrings-ls los))) 
           str)]))

(define los1 (make-ListOfStrings (list "becky" "beth" "ruth" "randy")))

; exercise 3

(define filelist (make-ListOfStrings 
                  (list "thefly.txt" 
                        "thegerm.txt" 
                        "theoctopus.txt" 
                        "theostrich.txt" 
                        "thetermite.txt")))

; exercise 4

; file-has-word? :: string string -> boolean
; file-has-word? takes a string with a filename and a string and returns
; a boolean if the string is within the file.

(check-expect (file-has-word? "theostrich.txt" "ostrich") true)
(check-expect (file-has-word? "thetermite.txt" "ostrich") false)

(define (file-has-word? file str)
  (has-string?
      (make-ListOfStrings 
       (read-words file))
      str))



; exercise 5

; searchfiles :: ListOfStrings string -> ListOfStrings
; searchfiles takes a list of strings containg a list of filenames,
; which it then checks to see if the file contains the string and returs
; a list of strings with the files that contain that string.

(check-expect (search-files filelist "ostrich") 
              (make-ListOfStrings (cons "theostrich.txt" empty)))
(check-expect (search-files filelist "The")
              (make-ListOfStrings
               (cons
                "thefly.txt"
                (cons
                 "thegerm.txt"
                 (cons
                  "theoctopus.txt"
                  (cons "theostrich.txt" (cons "thetermite.txt" empty)))))))

(define (search-files los str)
  (make-ListOfStrings (searchfileshelp (ListOfStrings-ls los) str)))

(define (searchfileshelp ls str)
  (cond
    [(empty? ls) empty]
    [(has-string?
      (make-ListOfStrings 
       (read-words (car ls)))
      str)
     (cons (car ls) (searchfileshelp (cdr ls) str))]
    [else (searchfileshelp (cdr ls) str)]))

; exercise 6

;none of the files contain the word one...

(make-ListOfStrings empty)

; exercise 7

(define-struct ripple [x y size])
;a size is a positiv int
(define-struct listripples [ls])
; an ls is a list of ripples


; exercise 8

; processripple :: ripple -> info

;(define (processripple ripple)
;    ((ripple-x ripple) ... (ripple-y ripple) ... (ripple-size ripple)))


; exercise 9

; main :: int -> bigbangscene
; main calls rippleeffect and feeds it an empty listripple to start with.

(define (main x)
  (rippleeffect (make-listripples empty)))

; grow :: listripples -> listripples
; grow takes a listripples and makes all of those ripples bigger by 1
(define (grow rip)
  (make-listripples (growhelp (listripples-ls rip))))
(define (growhelp ls)
  (cond
    [(empty? ls) empty]
    [else (cons (make-ripple (ripple-x (car ls))
                             (ripple-y (car ls))
                             (+ (ripple-size (car ls)) 1))
                (growhelp (cdr ls)))]))


; rippleplot :: listripples -> image
; rippleplot takes a listripples and plots them

(define (rippleplot lr)
  (ripplehelp (listripples-ls lr)))
(define (ripplehelp ls)
  (cond
    [(empty? ls) (empty-scene 300 300)]
    [else (place-image 
           (circle (ripple-size (car ls)) "outline" "red")
           (ripple-x (car ls)) 
           (ripple-y (car ls)) 
           (ripplehelp (cdr ls)))]))

; mousehandler :: world x y mouseevent-> world
; mousehandler takes the x and y coordinates of the mouse click and plots
; that position into the world if the mouse event is "button-down"

(define (mousehandler world x y me)
  (make-listripples (mousehelp (listripples-ls world) x y me)))

(define (mousehelp world x y me)
  (cond
    [(string=? me "button-down")
     (cons (make-ripple x y 1) world)]
    [else world]))


; rippleeffect :: lor -> bigbangscene
; rippleeffect is the main big bang program that calls all of the arguments 
; for the scene.

(define (rippleeffect lor)
  (big-bang lor
            [on-tick grow]
            [on-mouse mousehandler]
            [to-draw rippleplot]
            ))





