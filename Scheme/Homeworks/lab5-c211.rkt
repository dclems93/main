;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lab5-c211-su15) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; lab 5
;; Dylan Clements

(require 2htdp/universe)
(require 2htdp/image)

;; create-circle-scene : int -> image
;; create-circle-scene takes an int from the animate function and places a circle
;; at that state.

(check-expect (create-circle-scene 120) (underlay/xy (rectangle 300 300 "solid" "white")
                                                     120
                                                     120
                                                     (circle 20 "solid" "red")))
(define (create-circle-scene height)
  (underlay/xy (rectangle 300 300 "solid" "white") 
               height
               (if (>= height 140)
               (- 280 height)
               height)
               
               circles))

(define circles
  (circle 20 "solid" "red"))

(animate create-circle-scene)

;; key-handler : int string-> int
;; key-handler takes a width and a key press (string) and alters the width based on the input
(check-expect (key-handler 4 "left") 3)
(check-expect (key-handler 4 "right") 5)

(define (key-handler w a-key)
  (cond
    [(key=? a-key "left") (- w 1)]
    [(key=? a-key "right") (+ w 1)]
    [else w]))

;; main : int -> image
;; main takes an int and returns a big bang word with a circle starting
;; at that state
(define (main x)
  (big-bang x
            [on-key key-handler]
            [to-draw draw-world]
            ))
;; draw-world : int -> image
;; draw-world takes an int and produces an image. this is used by big bang to 
;; produce the world.
(check-expect (draw-world 120) (place-image (circle 20 "solid" "red")
                                            120
                                            150
                                            (empty-scene 300 300)))
(define (draw-world world)
  (place-image circles
               world
               150
               (empty-scene 300 300)))

(main 150)


