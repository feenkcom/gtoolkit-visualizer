Class {
	#name : #GtGradNodeContour,
	#superclass : #Object,
	#instVars : [
		'upperPoints',
		'lowerPoints'
	],
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #visiting }
GtGradNodeContour class >> height: height width: width [
	^ self new
		upperPoints: {0 @ 0.
				width @ 0} asOrderedCollection;
		lowerPoints: {0 @ height.
				width @ height} asOrderedCollection
]

{ #category : #accessing }
GtGradNodeContour >> asTraceElementForLayout: aLayout [
	| elem u l |

	elem := BlElement new
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ].

				
	u := aLayout transformPoints: upperPoints.
	l := aLayout transformPoints: lowerPoints.
	elem
		addChild: (BlPolygonElement new
				bePolyline;
				vertices: u;
				border: (BlBorder paint: Color blue width: 1)).
	elem
		addChild: (BlPolygonElement new
				bePolyline;
				vertices: l;
				border: (BlBorder paint: Color red width: 1)).
	u
		do: [ :each | 
			elem
				addChild: (BlElement new
						geometry: BlEllipseGeometry new;
						size: 6 @ 6;
						background: (Color blue alpha: 0.5);
						relocate: each - (3 @ 3)) ].
	l
		do: [ :each | 
			elem
				addChild: (BlElement new
						geometry: BlEllipseGeometry new;
						size: 6 @ 6;
						background: (Color red alpha: 0.5);
						relocate: each - (3 @ 3)) ].
	^ elem
]

{ #category : #accessing }
GtGradNodeContour >> computeOffsetTo: aGtGradNodeContour [
	| upperStream lowerStream offset upperPoint lowerPoint |
	offset := 0.
	upperStream := lowerPoints readStream.
	lowerStream := aGtGradNodeContour upperPoints readStream.
	[ upperStream atEnd or: [ lowerStream atEnd ] ]
		whileFalse: [ upperPoint := upperStream peek.
			lowerPoint := lowerStream peek.
			offset := offset max: upperPoint y - lowerPoint y.
			upperPoint x <= lowerPoint x ifTrue: [ upperStream next ].
			upperPoint x >= lowerPoint x ifTrue: [ lowerStream next ] ].
	^ offset
]

{ #category : #accessing }
GtGradNodeContour >> gtLowerPointViewOn: aView [
	<gtView>
	^ aView columnedList
		title: 'Lower Points';
		priority: 2;
		column: 'points' text: [ :item | item ];
		items: [ lowerPoints ]
]

{ #category : #accessing }
GtGradNodeContour >> gtTracePolyOn: aView [
	<gtView>
	^ aView explicit
		title: 'Trace';
		priority: 1;
		stencil: [ self asTraceElementForLayout: GtGradVerticalTreeLayout new ]
]

{ #category : #accessing }
GtGradNodeContour >> gtUpperPointViewOn: aView [
	<gtView>
	^ aView columnedList
		title: 'Upper Points';
		priority: 3;
		column: 'points' text: [ :item | item ];
		items: [ upperPoints ]
]

{ #category : #'as yet unclassified' }
GtGradNodeContour >> height [
	^lowerPoints max: #y
]

{ #category : #accessing }
GtGradNodeContour >> lowerPoints [
	^ lowerPoints
]

{ #category : #visiting }
GtGradNodeContour >> lowerPoints: aColl [
	lowerPoints := aColl 
]

{ #category : #accessing }
GtGradNodeContour >> mergeContour: aGtGradNodeContour offsetCollection: aCollection [
	| newUpper newLower offset |
	offset := self computeOffsetTo: aGtGradNodeContour.
	aCollection add: 0 @ offset.

	newUpper := OrderedCollection withAll: upperPoints.
	newLower := aGtGradNodeContour lowerPoints
			collect: [ :each | each x @ (each y + offset) ]
			into: OrderedCollection new.

	newUpper last x < newLower last x
		ifTrue: [ newUpper
				addAll: (aGtGradNodeContour upperPoints
						select: [ :each | each x > newUpper last x ]
						thenCollect: [ :each | each x @ (each y + offset) ]) ].

	newLower last x < newUpper last x
		ifTrue: [ newLower
				addAll: (self lowerPoints select: [ :each | each x > newLower last x ]) ].

	^ GtGradNodeContour new
		upperPoints: newUpper;
		lowerPoints: newLower
]

{ #category : #accessing }
GtGradNodeContour >> mergeContourOf: aGtGradNode [
	| newUpper newLower offset aGtGradNodeContour |
	aGtGradNodeContour := aGtGradNode contour.
	offset := self computeOffsetTo: aGtGradNodeContour.
	aGtGradNode offset: (0 @ offset).

	newUpper := OrderedCollection withAll: upperPoints.
	newLower := aGtGradNodeContour lowerPoints
			collect: [ :each | each x @ (each y + offset) ]
			into: OrderedCollection new.

	newUpper last x < newLower last x
		ifTrue: [ newUpper
				addAll: (aGtGradNodeContour upperPoints
						select: [ :each | each x > newUpper last x ]
						thenCollect: [ :each | each x @ (each y + offset) ]) ].

	newLower last x < newUpper last x
		ifTrue: [ newLower
				addAll: (self lowerPoints select: [ :each | each x > newLower last x ]) ].

	^ GtGradNodeContour new
		upperPoints: newUpper;
		lowerPoints: newLower
]

{ #category : #'private - layout' }
GtGradNodeContour >> middleOfFront [
	^ (lowerPoints first y - upperPoints first y) / 2 + upperPoints first y
]

{ #category : #accessing }
GtGradNodeContour >> translateBy: aPoint [
	upperPoints := upperPoints collect: [ :each | each + aPoint ].
	lowerPoints := lowerPoints collect: [ :each | each + aPoint ]
]

{ #category : #accessing }
GtGradNodeContour >> upperPoints [
	^ upperPoints
]

{ #category : #visiting }
GtGradNodeContour >> upperPoints: aColl [
	upperPoints := aColl 
]
