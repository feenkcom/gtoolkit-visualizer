Class {
	#name : #GtGraphRectanglePackTree,
	#superclass : #Object,
	#instVars : [
		'used',
		'x',
		'y',
		'width',
		'height',
		'down',
		'right'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures'
}

{ #category : #accessing }
GtGraphRectanglePackTree >> children [
	^ Array streamContents: [ :aStream |
		right ifNotNil: [ :aNode | aStream nextPut: aNode ].
		down ifNotNil: [ :aNode | aStream nextPut: aNode ] ]
]

{ #category : #'api - tree' }
GtGraphRectanglePackTree >> detect: aPoint ifFound: aFoundBlock ifNone: anExceptionBlock [
	^ self used
		ifTrue: [ self right
			detect: aPoint
			ifFound: aFoundBlock
			ifNone: [
				self down
					detect: aPoint
					ifFound: aFoundBlock
					ifNone: anExceptionBlock ] ]
		ifFalse: [
			(aPoint x <= self width and: [ aPoint y <= self height ])
				ifTrue: [ aFoundBlock value: self ]
				ifFalse: [ anExceptionBlock value ] ]
]

{ #category : #accessing }
GtGraphRectanglePackTree >> down [
	<return: #GtGraphRectanglePackTree>

	^ down
]

{ #category : #accessing }
GtGraphRectanglePackTree >> down: anObject [
	down := anObject
]

{ #category : #'api - growing' }
GtGraphRectanglePackTree >> grow: aSizePoint [
	<return: #GtGraphRectanglePackTree>
	| canGrowDown canGrowRight shouldGrowRight shouldGrowDown |

	canGrowDown := aSizePoint x <= self width.
	canGrowRight := aSizePoint y <= self height.

	"attempt to keep square-ish by growing down  when width  is much greater than height"
	shouldGrowDown := canGrowDown and: [ self width >= (self height + aSizePoint y) ].
	
	"attempt to keep square-ish by growing right when height is much greater than width"
	shouldGrowRight := canGrowRight and: [ self height >= (self width + aSizePoint x) ].
	
	shouldGrowRight
		ifTrue: [ ^ self growRight: aSizePoint ].
		
	shouldGrowDown
		ifTrue: [ ^ self growDown: aSizePoint ].
		
	canGrowRight
		ifTrue: [ ^ self growRight: aSizePoint ].
		
	canGrowDown
		ifTrue: [ ^ self growDown: aSizePoint ].
		
	self error: 'Can not grow, need to ensure sensible root starting size to avoid this happening'
]

{ #category : #'api - growing' }
GtGraphRectanglePackTree >> growDown: aPoint [
	<return: #GtGraphRectanglePackTree>
	^ self class new
		used: true;
		x: 0;
		y: 0;
		width: self width;
		height: self height + aPoint y;
		down: (self class new
			x: 0;
			y: self height;
			width: self width;
			height: aPoint y);
		right: self
]

{ #category : #'api - growing' }
GtGraphRectanglePackTree >> growRight: aPoint [
	<return: #GtGraphRectanglePackTree>
	^ self class new
		used: true;
		x: 0;
		y: 0;
		width: self width + aPoint x;
		height: self height;
		down: self;
		right: (self class new
			x: self width;
			y: 0;
			width:  aPoint x;
			height: self height)
]

{ #category : #'gt-extension' }
GtGraphRectanglePackTree >> gtTreeFor: aView [
	<gtView>

	^ aView mondrian
		title: 'Tree';
		painting: [ :aMondrian | self paintTreeWith: aMondrian ]
]

{ #category : #accessing }
GtGraphRectanglePackTree >> height [
	^ height
]

{ #category : #accessing }
GtGraphRectanglePackTree >> height: anObject [
	height := anObject
]

{ #category : #initialization }
GtGraphRectanglePackTree >> initialize [
	super initialize.
	
	x := 0.
	y := 0.
	width := 0.
	height := 0.
	used := false.
	down := nil.
	right := nil
]

{ #category : #accessing }
GtGraphRectanglePackTree >> origin [
	^ self x @ self y
]

{ #category : #'gt-extension' }
GtGraphRectanglePackTree >> paintTreeWith: view [
	view nodes
		shape: [ :each |
			BlElement new
				size: 10@10;
				padding: (BlInsets all: 13);
				geometry: (BlCircle new);
				border: (BlBorder paint: Color gray width: 1);
				background: Color white;
				zIndex: 10 ];
		with: (self withDeepCollect: #children).
	view edges
		fromNearestTightCircle;
		toNearestTightCircle;
		shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.5) width: 1 ) ];
		connectToAll: #children.
	view layout tree 
		nodeDistance: 10;
		levelDistance: 20
]

{ #category : #accessing }
GtGraphRectanglePackTree >> right [
	<return: #GtGraphRectanglePackTree>

	^ right
]

{ #category : #accessing }
GtGraphRectanglePackTree >> right: anObject [
	right := anObject
]

{ #category : #'api - tree' }
GtGraphRectanglePackTree >> split: aPoint [

	self used: true.

	down := self class new
		x: self x;
		y: self y + aPoint y;
		width: self width;
		height: self height - aPoint y.
		
	right := self class new
		x: self x + aPoint x;
		y: self y;
		width: self width - aPoint x;
		height: self height
]

{ #category : #accessing }
GtGraphRectanglePackTree >> used [
	^ used
]

{ #category : #accessing }
GtGraphRectanglePackTree >> used: anObject [
	used := anObject
]

{ #category : #accessing }
GtGraphRectanglePackTree >> width [
	^ width
]

{ #category : #accessing }
GtGraphRectanglePackTree >> width: anObject [
	width := anObject
]

{ #category : #accessing }
GtGraphRectanglePackTree >> x [
	^ x
]

{ #category : #accessing }
GtGraphRectanglePackTree >> x: aNumber [
	x := aNumber
]

{ #category : #accessing }
GtGraphRectanglePackTree >> y [
	^ y
]

{ #category : #accessing }
GtGraphRectanglePackTree >> y: aNumber [
	y := aNumber
]
