Class {
	#name : #GtGradNodeContourLine,
	#superclass : #Object,
	#instVars : [
		'position',
		'next'
	],
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'private - layout' }
GtGradNodeContourLine >> calculateOffsetTo: contour2 x: x y: y [
	| contour1y offset contour2y contour1x contour2x |
	offset := 0.
	contour1x := self position x.
	contour1y := self position y.
	contour2x := contour2 position x.
	contour2y := contour2 position y.

	(contour2x <= x or: [ x + contour1x <= 0 ]) ifTrue: [ ^ 0 ].
	contour2x * contour1y - (contour1x * contour2y) > 0
		ifTrue: [ x < 0 ifTrue: [ offset := x * contour1y / contour1x - y ].
			x > 0 ifTrue: [ offset := x * contour2y / contour2x - y ].
			x = 0 ifTrue: [ offset := 0 - y ] ]
		ifFalse: [ offset := contour2x < (x + contour1x)
					ifTrue: [ contour2y - (y + ((contour2x - x) * contour1y / contour1x)) ]
					ifFalse: [ contour2x > (x + contour1x)
							ifTrue: [ (contour1x + x) * contour2y / contour2x - (y + contour1y) ]
							ifFalse: [ contour2y - (y + contour1y) ] ] ].
	offset > 0 ifTrue: [ ^ offset ].
	^ 0
]

{ #category : #calculating }
GtGradNodeContourLine >> connectingLine: otherLine x1: x1 y1: y1 x2: x2 y2: y2 [
	| newX newY otherX otherY retLine nextLine|

	otherX := otherLine position x.
	otherY := otherLine position y.
	newX := x2 + otherX - x1.
	newY := otherX = 0
		ifTrue: [ otherY ]
		ifFalse: [ (newX * otherY) / otherX ].
		
	retLine := self class new position: newX @ newY.
	retLine next: (otherLine next).
	nextLine := self class new position: 0@(y2 + otherY - newY - y1).
	nextLine next: retLine.
	self next: nextLine.
	
	^ retLine.
	
]

{ #category : #initializing }
GtGradNodeContourLine >> initialize [
	super initialize.
	
	position := 0@0.
]

{ #category : #accessing }
GtGradNodeContourLine >> next [
	^ next
]

{ #category : #accessing }
GtGradNodeContourLine >> next: aNodeContourLine [
	next := aNodeContourLine
]

{ #category : #accessing }
GtGradNodeContourLine >> position [
	^position
]

{ #category : #accessing }
GtGradNodeContourLine >> position: aPoint [
	position := aPoint
]
