;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Assignment 6|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/batch-io)
;Assignment 6
;Dylan Clements


; Problem 119

(define-struct List-of-names [ls])

;A List-of-names is one of
; - A name
; -empty

(define ls1 (make-List-of-names 
         (cons "fred" (cons "ruth" 
                            (cons "steve" 
                                  (cons "randy" 
                                        (cons "rick" empty)))))))
(define-struct List-of-booleans [ls])

;Problem 120

;A List-of-booleans is one of:
; - A boolean
; - empty

; Problem 123

; contains? :: list string -> boolean
; contains takes a string and a list and references the list to see
; if that string is within the list.
(check-expect (contains? (list "mary" "ruth" "bob") "mary" ) true)
(check-expect (contains? (list "andy" "ruth" "bob") "mary" ) false)

(define (contains? ls str)
  (cond
    [(empty? ls) false]
    [(string=? (first ls) str) true]
    [else (contains? (rest ls) str)]))

;Problem 127

; all-true? :: List-of-booleans -> boolean
; all-true? takes a list of booleans and produces true if all of the 
; booleans within the list are true. If false is contained within the 
; list, it produces false.

(check-expect (all-true? (list true false true true)) false)
(check-expect (all-true? (list true true true true)) true)

(define (all-true? ls)
  (cond
    [(empty? ls) true]
    [(false? (first ls)) false]
    [else (all-true? (rest ls))]))

; one-true? :: List-of-booleans -> boolean
; one-true? takes a List-of-booleans and produces true if true is 
; contained within this list of booleans.

(check-expect (one-true? (list true false true)) true)
(check-expect (one-true? (list false false false)) false)

(define (one-true? ls)
  (cond
    [(empty? ls) false]
    [(not (false? (first ls))) true]
    [else (one-true? (rest ls))]))

;Problem 128

; juxtapoze :: List-of-strings -> string
; juxtapoze takes a list of strings and outputs all of the elements of this
; list of strings as one large string.

(check-expect (juxtapoze (list "a" "b" "c" "d")) "abcd")
(check-expect (juxtapoze (list "hello " "world!")) "hello world!")

(define (juxtapoze ls)
  (cond
    [(empty? ls) ""]
    [else (string-append (first ls) (juxtapoze (rest ls)))]))


; Exercise 1 

; A frequency contains
; - a string
; - a number

(define-struct Frequency [str num])

; Exercise 2

; A ListOfStrings is one of
; - a list containing strings
; - empty

(define-struct ListOfStrings [ls])

; A ListOfFrequency is one of
; - A Frequency
; - empty

(define-struct ListOfFrequency [ls])

; Exercise 3

; count-all-words :: ListOfFrequency string -> ListOfFrequency
; count-all-words consumes a list of frequency and a string and returns a 
; new list of frequency with the frequency of that string modified.

(define lof1 (list (make-Frequency "ruth" 1)
                   (make-Frequency "roger" 1)
                   (make-Frequency "andy" 1)
                   (make-Frequency "beth" 0)))

(define lof2 (list (make-Frequency "ruth" 1)
                   (make-Frequency "roger" 1)
                   (make-Frequency "andy" 1)
                   (make-Frequency "beth" 1)))
(define lof3 (list (make-Frequency "ruth" 1)
                   (make-Frequency "roger" 1)
                   (make-Frequency "andy" 1)))
(define lof4 (list 
              (make-Frequency "beth" 1)
              (make-Frequency "ruth" 1)
              (make-Frequency "roger" 1)
              (make-Frequency "andy" 1)
              ))

(check-expect (count-word lof1 "beth") lof2)
(check-expect (count-word lof3 "beth") lof4)

(define (count-word LoF str)
  (cond
    [(not (lofcontain? LoF str)) (cons (make-Frequency str 1) LoF)]
    [else (counthelp LoF str)]))

(define (counthelp LoF str)
  (cond
    [(empty? LoF) LoF]
    [(string=? str (Frequency-str(first LoF)))
     (cons (make-Frequency str (+ (Frequency-num (first LoF)) 1))
           (counthelp (rest LoF) str))]
    [else (cons (first LoF) (counthelp (rest LoF) str))]))

(define (lofcontain? LoF str)
  (cond
    [(empty? LoF) false]
    [(string=? str (Frequency-str (first LoF))) true]
    [else (lofcontain? (rest LoF) str)]))

; count-all-words :: ListOfStrings -> ListOfFrequency
; count-all-words takes a list of strings and produces a list of frequency
; based on that list of strings.

(define (count-all-words LoS)
  (make-ListOfFrequency (countallhelp LoS empty)))
(define (countallhelp LoS LoF)
  (cond
    [(empty? LoS) LoF]
    [else (countallhelp (rest LoS) (count-word LoF (first LoS)))]))


; exercise 5
;(count-all-words (read-words "pg2264.txt"))



; exercise 6

; bigfrequency :: ListOfFrequency -> ListOfFrequency
; bigfrequency takes a list of frequency and produces a list of frequencies
; that are larger than 100


(define (bigfrequency LoF)
  (bigfrequencyhelp (ListOfFrequency-ls LoF)))
(define (bigfrequencyhelp LoF)
  (cond
    [(empty? LoF) LoF]
    [(>= (Frequency-num (first LoF)) 100) 
     (cons (first LoF) (bigfrequencyhelp (rest LoF)))]
    [else (bigfrequencyhelp (rest LoF))]))

(define lof5 (list 
              (make-Frequency "beth" 100)
              (make-Frequency "ruth" 109)
              (make-Frequency "roger" 1)
              (make-Frequency "andy" 3)))

(define macbethtop (make-ListOfFrequency 
                    (cons
                     (make-Frequency "Macb." 137)
                     (cons
                      (make-Frequency "haue" 114)
                      (cons
                       (make-Frequency "And" 169)
                       (cons
                        (make-Frequency "his" 127)
                        (cons
                         (make-Frequency "my" 170)
                         (cons
                          (make-Frequency "I" 326)
                          (cons
                           (make-Frequency "that" 158)
                           (cons
                            (make-Frequency "it" 128)
                            (cons
                             (make-Frequency "with" 141)
                             (cons
                              (make-Frequency "and" 427)
                              (cons
                               (make-Frequency "The" 131)
                               (cons
                                (make-Frequency "not" 142)
                                (cons
                                 (make-Frequency "you" 193)
                                 (cons
                                  (make-Frequency "this" 108)
                                  (cons
                                   (make-Frequency "in" 190)
                                   (cons
                                    (make-Frequency "a" 256)
                                    (cons
                                     (make-Frequency "your" 122)
                                     (cons
                                      (make-Frequency "for" 100)
                                      (cons
                                       (make-Frequency "to" 367)
                                       (cons
                                        (make-Frequency "be" 133)
                                        (cons
                                         (make-Frequency "the" 620)
                                         (cons
                                          (make-Frequency "our" 117)
                                          (cons
                                           (make-Frequency "is" 185)
                                           (cons
                                            (make-Frequency "of" 396)
                                            empty))))))))))))))))))))))))))






