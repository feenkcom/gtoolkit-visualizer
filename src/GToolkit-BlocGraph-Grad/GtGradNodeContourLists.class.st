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
GtGradNodeContourLists class >> newWithHeight: nodeHeight [
	| contourList |
	contourList := self new.
	contourList addPointsToUpperHead: {nodeHeight @ 0}.
	contourList addPointsToLowerHead: {nodeHeight @ 0}.
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
	upper addFirst: point.
	upper := upper collect: [ :each | point := point + each ].
	point := 0 @ 0.
	lower addFirst: point.
	lower := lower collect: [ :each | point := point + each ].
	minY := ((upper collect: #y) min min: (lower collect: #y) min) abs.
	upper := upper collect: [ :each | (10 + (each x * 5)) @ (10 + each y + minY) ].
	lower := lower collect: [ :each | (10 + (each x * 5)) @ (10 + each y + minY) ].

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
	| total upper childUpperTail parentLowerTail y parentUpperTail childLowerTail lower x offset lowerX upperX lowerY upperY connectingLink |
	x := 0.
	y := 0.
	total := 0.

	parentUpperTail := self upperTail.
	parentLowerTail := self lowerTail.

	childUpperTail := aChildContour upperTail.
	childLowerTail := aChildContour lowerTail.
	upper := self lowerHead.
	lower := aChildContour upperHead.

	[ lower isNotNil and: [ upper isNotNil ] ]
		whileTrue: [ offset := lower
					calculateOffsetTo: upper
					x: x
					y: y.
			y := y + offset.
			total := total + offset.
			lowerX := lower position x.
			upperX := upper position x.
			lowerY := lower position y.
			upperY := upper position y.
			lowerX = upperX
				ifTrue: [ x := x + lowerX.
					y := y + (lowerY max: upperY).
					lower := lower next.
					upper := upper next ]
				ifFalse: [ lowerX < upperX
						ifTrue: [ x := x + lowerX.
							y := y + lowerY.
							lower := lower next ]
						ifFalse: [ x := x + upperX.
							y := y + upperY.
							upper := upper next ] ] ].
	(lower isNil and: [ upper isNil ]) ifTrue: [ ^ total ].
	lower isNotNil
		ifTrue: [ connectingLink := parentUpperTail
					connectingLink: lower
					x: x 
					y: y negated.
			parentUpperTail := connectingLink next isNotNil
					ifTrue: [ childUpperTail ]
					ifFalse: [ connectingLink ].
			parentLowerTail := childLowerTail ]
		ifFalse: [ connectingLink := childLowerTail
					connectingLink: upper
					x: x
					y: y.
			connectingLink next isNil ifTrue: [ parentLowerTail := connectingLink ] ].
	lowerHead := connectingLink.

	^ total
]

{ #category : #accessing }
GtGradNodeContourLists >> upperHead [
	^upperHead

]

{ #category : #accessing }
GtGradNodeContourLists >> upperTail [
	^upperTail

]
