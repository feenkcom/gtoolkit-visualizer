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
	contourList addPointsToLowerHead: {(nodeHeight + distance) @ 0 .  0 @ (nodeWidth negated - distance). }.
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
					x1: 0
					y1: 0
					x2: x
					y2: y.
			parentUpperTail := connectingLine next isNotNil
					ifTrue: [ childUpperTail ]
					ifFalse: [ connectingLine ].
			parentLowerTail := childLowerTail ]
		ifFalse: [ connectingLine := childLowerTail
					connectingLine: upper
					x1: x
					y1: y
					x2: 0
					y2: 0.
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
