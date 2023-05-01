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
GtGradNodeContourLists class >> newWithHeight: nodeHeight width: nodeWidth distance: distance [
	| contourList |
	contourList := self new.
	contourList addPointsToUpperHead: {(nodeHeight + distance) @ 0}.
	contourList addPointsToLowerHead: {(nodeHeight + distance) @ (nodeWidth negated - distance)}.
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
GtGradNodeContourLists >> gtTraceOn: aView [
	<gtView>
	^ aView list
		title: 'Trace';
		items: [ self asTrace ]
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
	| total upper childUpperTail parentLowerTail y parentUpperTail childLowerTail lower x offset lowerX upperX lowerY upperY connectingLine aNodeContourLine |
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
			x + lowerX <= upperX
				ifTrue: [ x := x + lowerX.
					y := y + lowerY.
					lower := lower next ]
				ifFalse: [ x := x - upperX.
					y := y - upperY.
					upper := upper next ] ].
	lower isNotNil
		ifTrue: [ connectingLine := parentUpperTail
					connectingLine: lower
					x: x negated
					y: y negated.
			parentUpperTail := connectingLine next isNotNil
					ifTrue: [ childUpperTail ]
					ifFalse: [ connectingLine ].
			parentLowerTail := childLowerTail ]
		ifFalse: [ connectingLine := childLowerTail
					connectingLine: upper
					x: x
					y: y.
			connectingLine next isNil ifTrue: [ parentLowerTail := connectingLine ] ].
	aNodeContourLine := aChildContour lowerHead.
	lowerHead := aNodeContourLine.

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
