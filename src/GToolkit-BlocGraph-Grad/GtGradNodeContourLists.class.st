Class {
	#name : #GtGradNodeContourLists,
	#superclass : #Object,
	#instVars : [
		'upperTail',
		'upperHead',
		'lowerTail',
		'lowerHead'
	],
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #visiting }
GtGradNodeContourLists class >> height: nodeHeight width: nodeWidth [
	| contourList |
	contourList := self new.
	contourList
		addPointsToUpperHead: {0 @ 0.
				nodeWidth @ 0}.
	contourList
		addPointsToLowerHead: {0 @ nodeHeight.
				nodeWidth @ 0}.
	^ contourList
]

{ #category : #accessing }
GtGradNodeContourLists >> addPointsToLowerHead: aCollection [
	aCollection reverseDo: [ :each | self addToLowerHead: each ]
]

{ #category : #accessing }
GtGradNodeContourLists >> addPointsToUpperHead: aCollection [
	aCollection reverseDo: [ :each | self addToUpperHead: each ]
]

{ #category : #accessing }
GtGradNodeContourLists >> addToLowerHead: aPoint [
	| aNodeContourLine |
	aNodeContourLine := GtGradNodeContourListLink new
			position: aPoint;
			next: lowerHead.
	lowerHead := aNodeContourLine.
	lowerTail ifNil: [ lowerTail := lowerHead ]
]

{ #category : #accessing }
GtGradNodeContourLists >> addToUpperHead: aPoint [
	| aNodeContourLine |
	aNodeContourLine := GtGradNodeContourListLink new
			position: aPoint;
			next: upperHead.
	upperHead := aNodeContourLine.
	upperTail ifNil: [ upperTail := upperHead ]
]

{ #category : #accessing }
GtGradNodeContourLists >> asTrace [
	| upper lower l |
	upper := OrderedCollection new.
	lower := OrderedCollection new.
	l := upperHead.
	[l notNil] whileTrue: [upper add: l position. l := l next].
	l := lowerHead.
	[l notNil] whileTrue: [lower add: l position. l := l next].
	^{ #upper -> upper . #lower -> lower }
]

{ #category : #accessing }
GtGradNodeContourLists >> asTraceElement [
	| upper point lower elem minY |
	upper := self asTrace first value.
	lower := self asTrace second value.
	point := 0 @ 0.
	upper := upper collect: [ :each | point := point + each ].
	point := 0 @ 0.
	lower := lower collect: [ :each | point := point + each ].
	minY := ((upper collect: #y) min min: (lower collect: #y) min) abs.
	upper := upper collect: [ :each | each x @ (each y + minY) ].
	lower := lower collect: [ :each | each x @ (each y + minY) ].

	elem := BlElement new
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ].

	elem
		addChild: (BlPolygonElement new
				bePolyline;
				vertices: upper;
				border: (BlBorder paint: Color blue width: 1)).
	elem
		addChild: (BlPolygonElement new
				bePolyline;
				vertices: lower;
				border: (BlBorder paint: Color red width: 1)).
	upper
		do: [ :each | 
			elem
				addChild: (BlElement new
						geometry: BlEllipseGeometry new;
						size: 6 @ 6;
						background: (Color blue alpha: 0.5);
						relocate: each - (3 @ 3)) ].
	lower
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
GtGradNodeContourLists >> gtTraceOn: aView [
	<gtView>
	^ aView list
		title: 'Lists';
		items: [ self asTrace ]
]

{ #category : #accessing }
GtGradNodeContourLists >> gtTracePolyOn: aView [
	<gtView>
	^ aView explicit
		title: 'Trace';
		priority: 1;
		stencil: [ self asTraceElement ]
]

{ #category : #accessing }
GtGradNodeContourLists >> lowerHead [
	^lowerHead

]

{ #category : #accessing }
GtGradNodeContourLists >> lowerTail [
	^lowerTail

]

{ #category : #'private - layout' }
GtGradNodeContourLists >> mergeWith: aChildContour [
	| upper childUpperTail parentLowerTail y parentUpperTail childLowerTail lower x offset lowerX upperX lowerY upperY |
	x := 0.
	y := 0.
	offset := 0.

	parentUpperTail := self upperTail.
	parentLowerTail := self lowerTail.

	childUpperTail := aChildContour upperTail.
	childLowerTail := aChildContour lowerTail.
	upper := self lowerHead.
	lower := aChildContour upperHead.

	[ lower isNotNil and: [ upper isNotNil ] ]
		whileTrue: [ lowerX := lower position x.
			lowerY := lower position y.
			upperX := upper position x.
			upperY := upper position y.
			offset := offset max: upperY - lowerY.
			lowerX <= upperX ifTrue: [ lower := lower next ].
			lowerX >= upperX ifTrue: [ upper := upper next ] ].

	^ offset
]

{ #category : #accessing }
GtGradNodeContourLists >> upperHead [
	^upperHead

]

{ #category : #accessing }
GtGradNodeContourLists >> upperTail [
	^upperTail

]
