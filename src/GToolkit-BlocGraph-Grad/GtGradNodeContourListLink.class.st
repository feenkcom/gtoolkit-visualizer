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

	^ contour2y - contour1y
]

{ #category : #calculating }
GtGradNodeContourListLink >> connectingLine: otherLink x: x y: y [
	| newX newY otherX otherY retLink |
	otherX := otherLink position x.
	otherY := otherLink position y.
	newX := otherX - x.
	newY := otherX = 0 ifTrue: [ otherY ] ifFalse: [ newX * otherY / otherX ].

	retLink := self class new position: newX @ newY.
	retLink next: otherLink next.

	^ retLink
]

{ #category : #calculating }
GtGradNodeContourListLink >> connectingLink: otherLink x: x y: y [
	| newX newY otherX otherY retLink nextLink |
	otherX := otherLink position x.
	otherY := otherLink position y.
	newX := x.
	newY := otherX = x ifTrue: [ otherY ] ifFalse: [ newX * otherY / otherX ].

	retLink := self class new position: newX @ newY.
	nextLink := self class new position: otherX @ y.
	retLink next: nextLink.
	nextLink next: otherLink next.

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
