"
I represent a circle node in a circle pack front-chain. I know an element which I describe, and a circle object that encapsulates radius, margin and center of the node.
Since I am a part of the front-chain which is a double linked list I also know the next node after me


"
Class {
	#name : 'GtGraphCirclePackNode',
	#superclass : 'DoubleLink',
	#instVars : [
		'circle'
	],
	#category : 'GToolkit-BlocGraph-Layouts-Data Structures - Circle'
}

{ #category : 'instance creation' }
GtGraphCirclePackNode class >> for: anElement [
	^ self basicNew initializeWith: anElement
]

{ #category : 'instance creation' }
GtGraphCirclePackNode class >> new [
	self error: 'Error use for: instead'
]

{ #category : 'geometry' }
GtGraphCirclePackNode >> alignTo: aCircle and: anotherCircle [
	self center: (GtGraphCircleNeighbourhood computeNeighbourCenter: circle near: aCircle circle and: anotherCircle circle)
]

{ #category : 'converting' }
GtGraphCirclePackNode >> asElement [
	^ BlScalableElement new
		geometry: BlCircle new;
		size: self radius * 2 asPoint;
		relocate: self center - self radius asPoint;
		border: (BlBorder paint: Color black width: 1);
		addChild: (BlTextElement new text: self index asRopedText; padding: (BlInsets all: 10))
]

{ #category : 'accessing' }
GtGraphCirclePackNode >> center [
	^ circle center
]

{ #category : 'accessing' }
GtGraphCirclePackNode >> center: aPoint [
	circle center: aPoint.
	self element position: self center - self radius asPoint
]

{ #category : 'accessing' }
GtGraphCirclePackNode >> circle [
	^ circle
]

{ #category : 'accessing' }
GtGraphCirclePackNode >> element [
	^ self value
]

{ #category : 'gt-inspector-extension' }
GtGraphCirclePackNode >> gtPreviewFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Preview';
		stencil: [ self asElement ]
]

{ #category : 'accessing' }
GtGraphCirclePackNode >> index [
	| anIndex aPreviousLink |
	
	anIndex := 1.
	
	aPreviousLink := self.
	
	[ aPreviousLink hasPredecessor ] whileTrue: [
		anIndex := anIndex + 1.
		aPreviousLink := aPreviousLink previousLink ].
	
	^ anIndex
]

{ #category : 'initialization' }
GtGraphCirclePackNode >> initializeWith: anElement [
	value := anElement.

	circle := GtGraphCircle new.
	circle radius: anElement extent max / 2.0.
	circle margin: anElement margin max
]

{ #category : 'geometry' }
GtGraphCirclePackNode >> intersects: anotherCircle [
	| aCenterVector aMagnitude |
	
	aCenterVector := (self center - anotherCircle center).
	aMagnitude := ( (aCenterVector x * aCenterVector x) + (aCenterVector y * aCenterVector y) ) sqrt.
	
	^ aMagnitude < (self radius + anotherCircle radius - 1.0e-0006)
]

{ #category : 'accessing' }
GtGraphCirclePackNode >> radius [
	<return: #Number>

	^ circle radius
]
