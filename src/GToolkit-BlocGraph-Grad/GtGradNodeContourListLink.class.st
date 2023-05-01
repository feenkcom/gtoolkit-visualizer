Class {
	#name : #GtGradNodeContourListLink,
	#superclass : #Object,
	#instVars : [
		'position',
		'next'
	],
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'private - layout' }
GtGradNodeContourListLink >> calculateOffsetTo: contourLink x: x y: y [
	| contour1y offset contour2y contour1x contour2x |
	offset := 0.
	contour1x := position x.
	contour1y := position y.
	contour2x := contourLink position x.
	contour2y := contourLink position y.

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
GtGradNodeContourListLink >> connectingLink: otherLink x: x y: y [
	| newX newY otherX otherY retLink nextLink |
	otherX := otherLink position x.
	otherY := otherLink position y.
	newX := otherX - x.
	newY := otherX = 0 ifTrue: [ otherY ] ifFalse: [ newX * otherY / otherX ].

	retLink := self class new position: newX @ newY.
	retLink next: otherLink next.
	nextLink := self class new position: 0 @ (otherY - newY - y).
	nextLink next: retLink.
	self next: nextLink.

	^ retLink
]

{ #category : #initializing }
GtGradNodeContourListLink >> initialize [
	super initialize.
	
	position := 0@0.
]

{ #category : #accessing }
GtGradNodeContourListLink >> next [
	^ next
]

{ #category : #accessing }
GtGradNodeContourListLink >> next: aNodeContourLine [
	next := aNodeContourLine
]

{ #category : #accessing }
GtGradNodeContourListLink >> position [
	^position
]

{ #category : #accessing }
GtGradNodeContourListLink >> position: aPoint [
	position := aPoint
]

{ #category : #printing }
GtGradNodeContourListLink >> printOn: aStream [
	| node |
	node := self.
	aStream << self class name << '('.
	[node notNil and: [node next ~~ self]] whileTrue: [ 
		node position printOn: aStream.
		node := node next.
	].
	aStream << ')'.
	^aStream
]
