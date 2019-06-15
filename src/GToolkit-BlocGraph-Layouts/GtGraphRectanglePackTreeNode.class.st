Class {
	#name : #GtGraphRectanglePackTreeNode,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'width',
		'height',
		'rectangle',
		'down',
		'right'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Rectangle'
}

{ #category : #accessing }
GtGraphRectanglePackTreeNode class >> rectangle: aRectangle [
	^ self new rectangle: aRectangle.
]

{ #category : #converting }
GtGraphRectanglePackTreeNode >> asElement [
	| aContainer anOrigin |
	
	aContainer := (self isLeaf not or: [ self rectangle isNil ])
		ifTrue: [ (GtGraphRectangle new origin: self x @ self y extent: self width @ self height) asElement ]
		ifFalse: [ self rectangle asElementWithInformation ].

	anOrigin := self x @ self y.

	self right ifNotNil: [ :aTree | aContainer addChild: (aTree asElement relocate: aTree origin - anOrigin) ].
	self down ifNotNil: [ :aTree | aContainer addChild: (aTree asElement relocate: aTree origin - anOrigin) ].

	(self isLeaf not or: [ self rectangle isNil ])
		ifTrue: [
			(aContainer childNamed: #rectangle) background: Color transparent.
			(aContainer childNamed: #margin) background: Color transparent ]
		ifFalse: [ (aContainer childNamed: #rectangle) background: (Color gray alpha: 0.2). ].

	^ aContainer
]

{ #category : #accessing }
GtGraphRectanglePackTreeNode >> children [
	^ Array streamContents: [ :aStream |
		right ifNotNil: [ :aNode | aStream nextPut: aNode ].
		down ifNotNil: [ :aNode | aStream nextPut: aNode ] ]
]

{ #category : #'api - tree' }
GtGraphRectanglePackTreeNode >> detect: aRectangle ifFound: aFoundBlock ifNone: anExceptionBlock [
	^ self isLeaf
		ifFalse: [ self down
			detect: aRectangle
			ifFound: aFoundBlock
			ifNone: [
				self right
					detect: aRectangle
					ifFound: aFoundBlock
					ifNone: anExceptionBlock ] ]
		ifTrue: [
			(self isEmpty and: [ (aRectangle outerWidth <= self width and: [ aRectangle outerHeight <= self height ]) ])
				ifTrue: [ aFoundBlock value: self ]
				ifFalse: [ anExceptionBlock value ] ]
]

{ #category : #accessing }
GtGraphRectanglePackTreeNode >> down [
	<return: #GtGraphRectanglePackTreeNode>

	^ down
]

{ #category : #accessing }
GtGraphRectanglePackTreeNode >> down: aGtRectanglePackTree [
	down := aGtRectanglePackTree
]

{ #category : #'api - growing' }
GtGraphRectanglePackTreeNode >> grow: aRectangle [
	<return: #GtGraphRectanglePackTreeNode>
	| canGrowDown canGrowRight shouldGrowRight shouldGrowDown |

	canGrowDown := aRectangle outerWidth <= self width.
	canGrowRight := aRectangle outerHeight <= self height.

	"attempt to keep square-ish by growing down  when width  is much greater than height"
	shouldGrowDown := canGrowDown and: [ self width >= (self height + aRectangle outerHeight) ].
	
	"attempt to keep square-ish by growing right when height is much greater than width"
	shouldGrowRight := canGrowRight and: [ self height >= (self width + aRectangle outerWidth) ].
	
	shouldGrowRight
		ifTrue: [ ^ self growRight: aRectangle ].
		
	shouldGrowDown
		ifTrue: [ ^ self growDown: aRectangle ].
		
	canGrowRight
		ifTrue: [ ^ self growRight: aRectangle ].
		
	canGrowDown
		ifTrue: [ ^ self growDown: aRectangle ].
		
	self error: 'Can not grow, need to ensure sensible root starting size to avoid this happening'
]

{ #category : #'api - growing' }
GtGraphRectanglePackTreeNode >> growDown: aRectangle [
	<return: #GtGraphRectanglePackTree>
	^ self class new
		x: 0;
		y: 0;
		width: self width;
		height: self height + aRectangle outerHeight;
		down: (self class new
			x: 0;
			y: self height;
			width: self width;
			height: aRectangle outerHeight);
		right: self
]

{ #category : #'api - growing' }
GtGraphRectanglePackTreeNode >> growRight: aRectangle [
	<return: #GtGraphRectanglePackTreeNode>
	^ self class new
		x: 0;
		y: 0;
		width: self width + aRectangle outerWidth;
		height: self height;
		down: self;
		right: (self class new
			x: self width;
			y: 0;
			width: aRectangle outerWidth;
			height: self height)
]

{ #category : #'gt-extension' }
GtGraphRectanglePackTreeNode >> gtPreviewFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Preview';
		priority: 31;
		stencil: [ self asElement asScalableElement margin: (BlInsets all: 10) ]
]

{ #category : #'gt-extension' }
GtGraphRectanglePackTreeNode >> gtTreeFor: aView [
	<gtView>

	^ aView mondrian
		title: 'Tree';
		priority: 32;
		painting: [ :aMondrian | self paintTreeWith: aMondrian ]
]

{ #category : #accessing }
GtGraphRectanglePackTreeNode >> height [
	^ height
]

{ #category : #accessing }
GtGraphRectanglePackTreeNode >> height: aNumber [
	height := aNumber
]

{ #category : #initialization }
GtGraphRectanglePackTreeNode >> initialize [
	super initialize.
		
	rectangle := nil.
	down := nil.
	right := nil
]

{ #category : #testing }
GtGraphRectanglePackTreeNode >> isEmpty [
	^ rectangle isNil
]

{ #category : #testing }
GtGraphRectanglePackTreeNode >> isLeaf [
	^ right isNil and: [ down isNil ]
]

{ #category : #accessing }
GtGraphRectanglePackTreeNode >> origin [
	^ self x @ self y
]

{ #category : #'gt-extension' }
GtGraphRectanglePackTreeNode >> paintTreeWith: view [
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

{ #category : #'api - adding' }
GtGraphRectanglePackTreeNode >> put: aGraphRectangle [
	| aNode |
	self
		assert: [ self isEmpty ]
		description: [ 'Can only put rectangle if I am empty' ].
	
	aNode := self split: aGraphRectangle.
	aGraphRectangle translateBy: aGraphRectangle margin topLeft + (aNode x @ aNode y) - aGraphRectangle origin.
	aNode rectangle: aGraphRectangle
]

{ #category : #accessing }
GtGraphRectanglePackTreeNode >> rectangle [
	^ rectangle
]

{ #category : #accessing }
GtGraphRectanglePackTreeNode >> rectangle: aGtGraphRectangle [
	rectangle := aGtGraphRectangle
]

{ #category : #accessing }
GtGraphRectanglePackTreeNode >> right [
	<return: #GtGraphRectanglePackTreeNode>

	^ right
]

{ #category : #accessing }
GtGraphRectanglePackTreeNode >> right: anObject [
	right := anObject
]

{ #category : #'api - tree' }
GtGraphRectanglePackTreeNode >> split: aGraphRectangle [
	<return: #GtGraphRectanglePackTreeNode>
	| rightSpace bottomSpace |
	
	rightSpace := self width - aGraphRectangle outerWidth.
	bottomSpace := self height - aGraphRectangle outerHeight.

	^ rightSpace > bottomSpace
		ifTrue: [ self splitHorizontally: aGraphRectangle ]
		ifFalse: [ self splitVertically: aGraphRectangle ]
]

{ #category : #'api - tree' }
GtGraphRectanglePackTreeNode >> splitHorizontally: aGraphRectangle [
	^ (self splitHorizontallyOnce: aGraphRectangle)
		splitVerticallyOnce: aGraphRectangle
]

{ #category : #'api - tree' }
GtGraphRectanglePackTreeNode >> splitHorizontallyOnce: aGraphRectangle [
	"left"
	down := self class new
		x: self x;
		y: self y;
		width: aGraphRectangle outerWidth;
		height: self height.
	
	"right"
	right := self class new
		x: self x + aGraphRectangle outerWidth;
		y: self y;
		width: self width - aGraphRectangle outerWidth;
		height: self height.
		
	^ down
]

{ #category : #'api - tree' }
GtGraphRectanglePackTreeNode >> splitVertically: aGraphRectangle [
	^ (self splitVerticallyOnce: aGraphRectangle)
		splitHorizontallyOnce: aGraphRectangle
]

{ #category : #'api - tree' }
GtGraphRectanglePackTreeNode >> splitVerticallyOnce: aGraphRectangle [
	"top"
	down := self class new
		x: self x;
		y: self y;
		width: self width;
		height: aGraphRectangle outerHeight.
	
	"down"
	right := self class new
		x: self x;
		y: self y  + aGraphRectangle outerHeight;
		width: self width;
		height: self height - aGraphRectangle outerHeight.
		
	^ down
]

{ #category : #accessing }
GtGraphRectanglePackTreeNode >> width [
	^ width
]

{ #category : #accessing }
GtGraphRectanglePackTreeNode >> width: aNumber [
	width := aNumber
]

{ #category : #accessing }
GtGraphRectanglePackTreeNode >> x [
	^ x
]

{ #category : #accessing }
GtGraphRectanglePackTreeNode >> x: aNumber [
	x := aNumber
]

{ #category : #accessing }
GtGraphRectanglePackTreeNode >> y [
	^ y
]

{ #category : #accessing }
GtGraphRectanglePackTreeNode >> y: aNumber [
	y := aNumber
]
