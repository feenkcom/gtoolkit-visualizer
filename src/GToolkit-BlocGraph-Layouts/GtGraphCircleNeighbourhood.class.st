Class {
	#name : #GtGraphCircleNeighbourhood,
	#superclass : #Object,
	#instVars : [
		'circles',
		'neighbourCircle'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Circle'
}

{ #category : #'private - algebra' }
GtGraphCircleNeighbourhood class >> computeNeighbourCenter: aCircle [
	"I calculate the center of aCircle in a neighbourhood consisting of just that one circle"	
	<return: #Point>

	^ 0@0
]

{ #category : #'private - algebra' }
GtGraphCircleNeighbourhood class >> computeNeighbourCenter: aCircle near: anAnotherCircle [
	"I calculate the center of aCircle according to its radius and tangency of aCircleNode to aOneCircle and anAnotherCircle"	
	<return: #Point>
	| r1 r c1 |

	r := aCircle outerRadius.
	r1 := anAnotherCircle outerRadius.

	c1 := anAnotherCircle center.

	^ c1 + (r1 @ 0) + (r @ 0)
]

{ #category : #'private - algebra' }
GtGraphCircleNeighbourhood class >> computeNeighbourCenter: aCircle near: aOneCircle and: anAnotherCircle [
	"I calculate the center of aCircle according to its radius and tangency of aCircleNode to aOneCircle and anAnotherCircle"	
	<return: #Point>
	| r1 r2 r c1 c2 v c1c2 d h c |

	r := aCircle outerRadius.
	r1 := aOneCircle outerRadius.
	r2 := anAnotherCircle outerRadius.

	c1 := aOneCircle center.
	c2 := anAnotherCircle center.
	v := (c2 - c1).
	c1c2 := ((v x * v x) + (v y * v y)) sqrt.

	d := ((r + r1) squared - (r + r2) squared + c1c2 squared) / (2 * c1c2).
	h := ((r + r1) squared - d squared) sqrt.

	c := c1 + (d / c1c2 * v) + (h / c1c2 * v leftRotated).

	^ c
]

{ #category : #'api - adding' }
GtGraphCircleNeighbourhood >> addCircle: aCircle [
	| theCircles aNeighbourCircle |
	"The last added circle is a neighbour circle"
	
	theCircles := circles
		ifNil: [ Array new ]
		ifNotNil: [ circles, { neighbourCircle } ].

	aNeighbourCircle := aCircle.

	self circles: theCircles neighbour: aNeighbourCircle
]

{ #category : #'private - algebra' }
GtGraphCircleNeighbourhood >> allCircles [
	^ circles, { neighbourCircle }
]

{ #category : #'gt-inspector-extension' }
GtGraphCircleNeighbourhood >> asElement [
	^ GtGraphCircleNeighbourhoodElement new neighbourhood: self
]

{ #category : #'private - algebra' }
GtGraphCircleNeighbourhood >> averageOutgoingEdgeVector: aCircle [
	| theVectors allPairCircles |

	allPairCircles := self allCircles select: [ :each | each ~~ aCircle ].
	allPairCircles
		ifEmpty: [ ^ (0 @ -1) ].

	theVectors := allPairCircles collect: [ :eachCircle | (eachCircle center - aCircle center) normalized ].
	^ theVectors average
]

{ #category : #'private - algebra' }
GtGraphCircleNeighbourhood >> averageRadius [
	self isEmpty
		ifTrue: [ ^ 0 ].
	^ (self allCircles collect: #outerRadius) average
]

{ #category : #accessing }
GtGraphCircleNeighbourhood >> circles [
	^ circles
]

{ #category : #initialize }
GtGraphCircleNeighbourhood >> circles: aCollectionOfCircles neighbour: aNeighbourCircle [

	self
		assert: [ aCollectionOfCircles size <= 2 ]
		description: [ 'A total mount of circles in a neighbourhood must be less or equal to 3 (two circles and a new neighbour)' ].

	circles := aCollectionOfCircles.
	neighbourCircle := aNeighbourCircle.
	neighbourCircle center: self computeNeighbourCenter
]

{ #category : #'private - algebra' }
GtGraphCircleNeighbourhood >> computeNeighbourCenter [
	"Compute a neighbour center based on how many neighbours there are"
	<return: #Point>
	
	circles
		ifEmpty: [ ^ self class computeNeighbourCenter: neighbourCircle ].

	circles size = 1
		ifTrue: [ ^ self class computeNeighbourCenter: neighbourCircle near: circles first ].
		
	circles size = 2
		ifTrue: [ ^ self class computeNeighbourCenter: neighbourCircle near: circles first and: circles second ].
		
	self error: 'Too many circles in a neighbourhood'
]

{ #category : #'gt-inspector-extension' }
GtGraphCircleNeighbourhood >> gtPreviewFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Preview';
		stencil: [ self asElement asScalableElement margin: (BlInsets all: 10)]
]

{ #category : #testing }
GtGraphCircleNeighbourhood >> isEmpty [
	^ self size isZero
]

{ #category : #'private - algebra' }
GtGraphCircleNeighbourhood >> largestCircle [
	^ self allCircles detectMax: #outerRadius
]

{ #category : #accessing }
GtGraphCircleNeighbourhood >> neighbourCircle [
	^ neighbourCircle
]

{ #category : #'private - algebra' }
GtGraphCircleNeighbourhood >> neighbourProjection [
	<return: #Point>

	circles size = 0
		ifTrue: [ ^ 0@0 ].

	circles size = 1
		ifTrue: [ ^ circles first center + ((neighbourCircle center - circles first center) normalized * circles first outerRadius) ].
	
	circles size = 2
		ifTrue: [
			| d v c c1 c2 c1c c2c c1c2 |
			
			c1 := circles first center.
			c2 := circles second center.
			c := neighbourCircle center.
			c1c := c1 distanceTo: c.
			c2c := c2 distanceTo: c.
			c1c2 := c1 distanceTo: c2.

			v := (c2 - c1) normalized.
			d := (c1c squared - c2c squared + c1c2 squared) / (2 * c1c2).
			
			^ c1 + (v * d) ].
		
	self error: 'Too many circles in a neighbourhood'
]

{ #category : #accessing }
GtGraphCircleNeighbourhood >> size [
	^ circles size + neighbourCircle isNotNil asBit
]
