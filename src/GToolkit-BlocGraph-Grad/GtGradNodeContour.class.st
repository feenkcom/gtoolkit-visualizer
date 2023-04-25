Class {
	#name : #GtGradNodeContour,
	#superclass : #Object,
	#instVars : [
		'upperTail',
		'upperHead',
		'lowerTail',
		'lowerHead'
	],
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #accessing }
GtGradNodeContour >> lowerHead [
	^lowerHead

]

{ #category : #accessing }
GtGradNodeContour >> lowerHead: aNodeContourLine [
	lowerHead := aNodeContourLine

]

{ #category : #accessing }
GtGradNodeContour >> lowerTail [
	^lowerTail

]

{ #category : #accessing }
GtGradNodeContour >> lowerTail: aNodeContourLine [
	lowerTail := aNodeContourLine

]

{ #category : #'private - layout' }
GtGradNodeContour >> mergeWith: aChildContour [
	| total upper childUpperTail parentLowerTail y parentUpperTail childLowerTail lower x |
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
		whileTrue: [ | offset lowerX upperX lowerY upperY |
			offset := lower
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
		ifTrue: [ | connectingLine |
			connectingLine := parentUpperTail
					connectingLine: lower
					x1: 0
					y1: 0
					x2: x
					y2: y.
			parentUpperTail := connectingLine next isNotNil
					ifTrue: [ childUpperTail ]
					ifFalse: [ connectingLine ].
			parentLowerTail := childLowerTail ]
		ifFalse: [ | connectingLine |
			connectingLine := childLowerTail
					connectingLine: upper
					x1: x
					y1: y
					x2: 0
					y2: 0.
			connectingLine next isNil ifTrue: [ parentLowerTail := connectingLine ] ].
	self lowerHead: aChildContour lowerHead.

	^ total
]

{ #category : #accessing }
GtGradNodeContour >> upperHead [
	^upperHead

]

{ #category : #accessing }
GtGradNodeContour >> upperHead: aNodeContourLine [
	upperHead := aNodeContourLine

]

{ #category : #accessing }
GtGradNodeContour >> upperTail [
	^upperTail

]

{ #category : #accessing }
GtGradNodeContour >> upperTail: aNodeContourLine [
	upperTail := aNodeContourLine

]
