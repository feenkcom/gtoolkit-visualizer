Class {
	#name : 'GtGraphQuadTree',
	#superclass : 'Object',
	#instVars : [
		'charge',
		'x',
		'y',
		'leaf',
		'nodes',
		'origin',
		'corner',
		'node',
		'cx',
		'cy'
	],
	#category : 'GToolkit-BlocGraph-Layouts-Data Structures'
}

{ #category : 'public' }
GtGraphQuadTree class >> withAll: aNodeCollection [
	^ self
		withAll: aNodeCollection
		origin:
			(aNodeCollection collect: [ :e | e position x ]) min
				@ (aNodeCollection collect: [ :e | e position y ]) min
		corner:
			(aNodeCollection collect: [ :e | e position x ]) max
				@ (aNodeCollection collect: [ :e | e position y ]) max
]

{ #category : 'public' }
GtGraphQuadTree class >> withAll: aNodeCollection origin: aPoint corner: anotherPoint [
	| dx dy root |
	dx := anotherPoint x - aPoint x.
	dy := anotherPoint y - aPoint y.
	(dx closeTo: dy)
		ifTrue: [ root := self new.
			root
				origin: aPoint;
				corner: anotherPoint.
			aNodeCollection do: [ :e | root add: e ].
			^ root ].
	dx > dy
		ifTrue: [ ^ self
				withAll: aNodeCollection
				origin: aPoint
				corner: anotherPoint x @ (aPoint y + dx) ].
	dy > dx
		ifTrue: [ ^ self
				withAll: aNodeCollection
				origin: aPoint
				corner: (aPoint x + dy) @ anotherPoint y ]
]

{ #category : 'adding' }
GtGraphQuadTree >> add: aNode [

	self isLeaf
		ifFalse: [ ^ self addChild: aNode ].

	"I am a leaf at this point"
	self
		assert: [ self nodes allSatisfy: #isNil ]
		description: [ 'Leaf must not have any sub-nodes' ].
	
	x
		ifNotNil: [ (x - aNode position x) abs + (y - aNode position y) abs < 0.01
			ifTrue: [ self addChild: aNode ]
			ifFalse: [
				| aCurrentNode |
				aCurrentNode := node.

				x := nil.
				y := nil.
				node := nil.

				self
					addChild: aNode;
					addChild: aCurrentNode ] ]
		ifNil: [
			x := aNode position x.
			y := aNode position y.
			node := aNode ]
]

{ #category : 'private - adding' }
GtGraphQuadTree >> addChild: aNode [
	| center |
	
	center := self center.
	leaf := false.

	aNode position x < center x
		ifTrue: [ aNode position y < center y
				"top left quad"
				ifTrue: [
					(nodes at: 1) ifNil: [
						| new |
						new := GtGraphQuadTree new
							origin: origin;
							corner: center.
						nodes at: 1 put: new ].
					(nodes at: 1) add: aNode ]

				"bottom left quad"
				ifFalse: [
					(nodes at: 3) ifNil:[
						| new |
						new := GtGraphQuadTree new
							origin: origin x @ center y;
							corner: center x @ corner y.
						nodes at: 3 put: new ].
					(nodes at: 3) add: aNode ] ]

		ifFalse: [ aNode position y < center y
				"top right quad"
				ifTrue: [
					(nodes at: 2) ifNil: [
						| new |
						new := GtGraphQuadTree new
							origin: center x @ origin y;
							corner: corner x @ center y.
						nodes at: 2 put: new ].
					(nodes at: 2) add: aNode ]

				"bottom right quad"
				ifFalse: [ (nodes at: 4) ifNil: [
						| new |
						new := GtGraphQuadTree new
							origin: center;
							corner: corner.
						nodes at: 4 put: new ].
					(nodes at: 4) add: aNode ] ]
]

{ #category : 'enumerating' }
GtGraphQuadTree >> allNodes [
	^ Array streamContents: [ :aStream | self allNodesDo: [ :each | aStream nextPut: each ] ]
]

{ #category : 'enumerating' }
GtGraphQuadTree >> allNodesDo: aBlock [
	aBlock value: self.
	self nodes do: [ :each | each ifNotNil: [ each allNodesDo: aBlock ] ]
]

{ #category : 'accessing' }
GtGraphQuadTree >> center [
	| sx sy |

	sx := (origin x / 2.0) + (corner x / 2.0).
	sy := (origin y / 2.0) + (corner y / 2.0).

	^ sx @ sy
]

{ #category : 'accessing' }
GtGraphQuadTree >> charge [
	^ charge
]

{ #category : 'accessing' }
GtGraphQuadTree >> charge: anObject [
	charge := anObject
]

{ #category : 'accessing' }
GtGraphQuadTree >> corner [
	^ corner
]

{ #category : 'accessing' }
GtGraphQuadTree >> corner: anObject [
	corner := anObject
]

{ #category : 'accessing' }
GtGraphQuadTree >> cx [
	^ cx
]

{ #category : 'accessing' }
GtGraphQuadTree >> cx: aFloat [
	cx := aFloat
]

{ #category : 'accessing' }
GtGraphQuadTree >> cy [
	^ cy
]

{ #category : 'accessing' }
GtGraphQuadTree >> cy: aFloat [
	cy := aFloat
]

{ #category : 'accessing' }
GtGraphQuadTree >> extent [
	^ self corner - self origin
]

{ #category : 'gt-extension' }
GtGraphQuadTree >> gtMapFor: aView [
	<gtView>
	^ aView explicit
		title: 'Map';
		stencil: [
			BlElement new
				constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent ];
				layout: BlFitLayout new;
				addChildren: (self allNodes collect: [ :each |
					BlElement new
						background: (each isLeaf ifTrue: [ BrGlamorousColors primaryBorderColor alpha: 0.8 ] ifFalse: [ Color gray alpha: 0.1 ]);
						border: (BlBorder paint: Color white width: 0.5);
						relocate: each origin;
						size: each extent
				]);
				asScalableElement
		]
]

{ #category : 'gt-extension' }
GtGraphQuadTree >> gtTreeFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Tree';
		painting: [ :aMondrian | self paintTreeWith: aMondrian ]
]

{ #category : 'accessing' }
GtGraphQuadTree >> height [
	^ self corner y - self origin y
]

{ #category : 'initialize-release' }
GtGraphQuadTree >> initialize [ 

	super initialize.
	
	leaf := true.
	nodes := Array new: 4
]

{ #category : 'testing' }
GtGraphQuadTree >> isLeaf [
	^ leaf
]

{ #category : 'accessing' }
GtGraphQuadTree >> leaf [
	^ leaf
]

{ #category : 'accessing' }
GtGraphQuadTree >> node [
	^ node
]

{ #category : 'accessing' }
GtGraphQuadTree >> nodes [
	^ nodes
]

{ #category : 'accessing' }
GtGraphQuadTree >> origin [
	^ origin
]

{ #category : 'accessing' }
GtGraphQuadTree >> origin: aPoint [
	origin := aPoint
]

{ #category : 'gt-extension' }
GtGraphQuadTree >> paintTreeWith: view [
	view nodes
		shape: [ :each |
			BlElement new
				size: 10@10;
				padding: (BlInsets all: 13);
				geometry: (BlCircle new);
				border: (each isLeaf
					ifTrue: [BlBorder paint: BrGlamorousColors primaryBorderColor width: 2 ]
					ifFalse: [ BlBorder paint: Color gray width: 1 ]);
				background: Color white;
				zIndex: 10 ];
		with: (self withDeepCollect: #nodes).
	view edges
		fromNearestTightCircle;
		toNearestTightCircle;
		shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.5) width: 1 ) ];
		connectToAll: #nodes.
	view layout tree 
		nodeDistance: 10;
		levelDistance: 20
]

{ #category : 'accessing' }
GtGraphQuadTree >> width [
	^ self corner x - self origin x
]
