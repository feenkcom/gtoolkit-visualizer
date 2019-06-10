"
I represent a circle node in a circle pack front-chain. I know an element which I describe, its center, radius and a distance from the origin.
Since I am a part of the front-chain which is a double linked list I also know the next node after me
"
Class {
	#name : #GtGraphCirclePackNode,
	#superclass : #DoubleLink,
	#instVars : [
		'center',
		'radius'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures'
}

{ #category : #'instance creation' }
GtGraphCirclePackNode class >> for: anElement [
	^ self basicNew initializeWith: anElement
]

{ #category : #'instance creation' }
GtGraphCirclePackNode class >> new [
	self error: 'Error use for: instead'
]

{ #category : #geometry }
GtGraphCirclePackNode >> alignTo: aCircle and: anotherCircle [
	self center: (aCircle findCenterOf: self relativeTo: anotherCircle)
]

{ #category : #converting }
GtGraphCirclePackNode >> asElement [
	^ BlScalableElement new
		geometry: BlCircle new;
		size: self radius * 2 asPoint;
		relocate: self center - self radius asPoint;
		border: (BlBorder paint: Color black width: 1);
		addChild: (BlTextElement new text: self index asRopedText; padding: (BlInsets all: 10))
]

{ #category : #accessing }
GtGraphCirclePackNode >> center [
	^ center
]

{ #category : #accessing }
GtGraphCirclePackNode >> center: aPoint [
	center := aPoint.
	self element measuredBounds position: center - self radius asPoint
]

{ #category : #accessing }
GtGraphCirclePackNode >> element [
	^ self value
]

{ #category : #geometry }
GtGraphCirclePackNode >> findCenterOf: aCircleNode relativeTo: anotherCircleNode [
	<return: #Point>
	"I calculate the center of aCircleNode according to its radius and the tangency of aCircleNode to me and anotherCircleNode"	
	| r1 r2 r c1 c2 v c1c2 d h c |
	
	r := aCircleNode radius.
	r1 := self radius.
	r2 := anotherCircleNode radius.
	
	c1 := self center.
	c2 := anotherCircleNode center.
	v := (c2 - c1).
	c1c2 := ((v x * v x) + (v y * v y)) sqrt.

	d := ((r + r1) squared - (r + r2) squared + c1c2 squared) / ( 2 * c1c2).
	h := ((r + r1) squared - d squared) sqrt.
	
	c := c1 + (d / c1c2 * v) + (h / c1c2 * v leftRotated).
	
	^ c
]

{ #category : #'gt-inspector-extension' }
GtGraphCirclePackNode >> gtPreviewFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Preview';
		stencil: [ self asElement ]
]

{ #category : #accessing }
GtGraphCirclePackNode >> index [
	| anIndex aPreviousLink |
	
	anIndex := 1.
	
	aPreviousLink := self.
	
	[ aPreviousLink hasPredecessor ] whileTrue: [
		anIndex := anIndex + 1.
		aPreviousLink := aPreviousLink previousLink ].
	
	^ anIndex
]

{ #category : #initialization }
GtGraphCirclePackNode >> initializeWith: anElement [
	value := anElement.
	radius := anElement measuredExtent max / 2.0
]

{ #category : #geometry }
GtGraphCirclePackNode >> intersects: anotherCircle [
	| aCenterVector aMagnitude |
	
	aCenterVector := (self center - anotherCircle center).
	aMagnitude := ( (aCenterVector x * aCenterVector x) + (aCenterVector y * aCenterVector y) ) sqrt.
	
	^ aMagnitude < (self radius + anotherCircle radius - 1.0e-0006)
]

{ #category : #accessing }
GtGraphCirclePackNode >> radius [
	^ radius
]
