Class {
	#name : #GtGradTreeNode,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'element',
		'depth',
		'parent',
		'contour',
		'offset',
		'maxWidths',
		'maxHeights'
	],
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'instance creation' }
GtGradTreeNode class >> on: anElement [
	<return: #GtGradTreeNode>

	^ self new element: anElement
]

{ #category : #'api - visiting' }
GtGradTreeNode >> accept: aVisitor [
	self nodes do: [ :aTreeNode | aTreeNode accept: aVisitor ].

	aVisitor visitNode: self.

	self isRoot ifTrue: [ aVisitor visitRootNode: self ].

	self nodes
		ifEmpty: [ aVisitor visitLeafNode: self ]
		ifNotEmpty: [ aVisitor visitCompositeNode: self ]
]

{ #category : #'api - adding' }
GtGradTreeNode >> add: aTreeNode [
	
	aTreeNode parent: self.
	aTreeNode depth: self depth + 1.

	self nodes add: aTreeNode
]

{ #category : #'api - adding' }
GtGradTreeNode >> addAll: aCollectionOfNodes [
	| aChildDepth |
	
	aChildDepth := self depth + 1.	
	aCollectionOfNodes
		do: [ :aTreeNode |
			aTreeNode parent: self.
			aTreeNode depth: aChildDepth ].

	self nodes addAll: aCollectionOfNodes
]

{ #category : #'instance-creation' }
GtGradTreeNode >> addChildNodesToLeaves [
	| queue |
	queue := OrderedCollection new.
	queue add: self.

	[ queue isNotEmpty ]
		whileTrue: [ | theCurrentNode |
			theCurrentNode := queue removeAt: 1.
			theCurrentNode nodes isEmpty
				ifTrue: [ theCurrentNode add: (GtGradTreeNode on: theCurrentNode element) ]
				ifFalse: [ queue addAll: theCurrentNode nodes ] ]
]

{ #category : #accessing }
GtGradTreeNode >> allParents [
	| result n |
	result := OrderedCollection new.
	n := self.
	[ n hasParent ]
		whileTrue: [ result add: n parent.
			n := n parent ].
	^result
]

{ #category : #'gt-extension' }
GtGradTreeNode >> asTraceView [
	| elem verts minY newVerts |
	verts := self gtTraceCoordsFrom: 0 @ 0 into: OrderedCollection new.
	minY := (verts collect: #y) min.
	elem := BlElement new
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ].
	newVerts := self
			gtTraceCoordsFrom: 10 @ (10 + minY abs)
			into: OrderedCollection new.
	elem
		addChild: (BlPolygonElement new
				vertices: newVerts;
				bePolyline;
				border: (BlBorder paint: Color blue width: 1)).
	newVerts
		do: [ :each | 
			elem
				addChild: (BlElement new
						geometry: BlEllipseGeometry new;
						size: 6 @ 6;
						background: Color red;
						relocate: each - (3 @ 3)) ].
	^ elem
]

{ #category : #accessing }
GtGradTreeNode >> contour [
	^ contour
]

{ #category : #accessing }
GtGradTreeNode >> contour: anObject [
	contour := anObject
]

{ #category : #accessing }
GtGradTreeNode >> depth [
	<return: #Number>

	^ depth
]

{ #category : #accessing }
GtGradTreeNode >> depth: aNumber [
	| aChildDepth |
	"Changing my depth also updates the depth of my children"
	depth := aNumber.

	aChildDepth := depth + 1.
	self nodes do: [ :aTreeNode | aTreeNode depth: aChildDepth ]
]

{ #category : #accessing }
GtGradTreeNode >> element [
	<return: #BlElement>

	^ element
]

{ #category : #accessing }
GtGradTreeNode >> element: anElement [
	element := anElement
]

{ #category : #'gt-extension' }
GtGradTreeNode >> gtContoursFor: aView [
	<gtView>
	^ aView tree
		title: 'Contours';
		priority: 2;
		items: [ {self} ];
		children: [ :aNode | aNode nodes ];
		itemText: [ :aNode | aNode contour ];
		transformation: [ :aNode | aNode contour];
		expandAll
]

{ #category : #'gt-extension' }
GtGradTreeNode >> gtNodesFor: aView [
	<gtView>

	^ aView tree
		title: 'Tree';
		priority: 1;
		items: [ { self } ];
		children: [ :aNode | aNode nodes ];
		expandAll
]

{ #category : #'gt-extension' }
GtGradTreeNode >> gtOffsetTraceFor: aView [
	<gtView>
	^ aView explicit
		title: 'Layout trace';
		priority: 3;
		stencil: [ self asTraceView ]
]

{ #category : #'gt-extension' }
GtGradTreeNode >> gtOffsetTraceListFor: aView [
	<gtView>
	^ aView list
		title: 'Trace list';
		priority: 4;
		items: [ self gtTraceCoordsFrom: 0@0 into: OrderedCollection new]
]

{ #category : #'gt-extension' }
GtGradTreeNode >> gtTraceCoordsFrom: aPoint into: aCollection [
	| newPoint |
	newPoint := offset + aPoint.
	aCollection add: newPoint.
	self nodes
		do: [ :node | 
			node gtTraceCoordsFrom: newPoint into: aCollection.
			newPoint := newPoint + node offset ].
	^ aCollection
]

{ #category : #'api - testing' }
GtGradTreeNode >> hasParent [
	<return: #Boolean>
	
	^ parent isNotNil
]

{ #category : #'api - geometry' }
GtGradTreeNode >> height [
	"Return the height of my element"
	<return: #Number>
	
	^ self element height
]

{ #category : #initialization }
GtGradTreeNode >> initialize [
	super initialize.

	nodes := OrderedCollection new.
	depth := 0.

	"I get a parent when I am added to the other node as a child"
	parent := nil.
	"by default we are not attached to any element"
	element := nil.
	contour := GtGradNodeContour new.
	offset := 0@0.
]

{ #category : #'api - testing' }
GtGradTreeNode >> isRoot [
	<return: #Boolean>
	
	^ self hasParent not
]

{ #category : #'api - geometry' }
GtGradTreeNode >> maxDepthHeight [
	"Return the maximum height of the nodes at the same depth as me"
	<return: #Number>
	| aMaxHeight |

	aMaxHeight := self height.

	self root
		nodesAt: self depth
		do: [ :aTreeNode | aMaxHeight := aMaxHeight max: aTreeNode height ].
		
	^ aMaxHeight
]

{ #category : #'api - geometry' }
GtGradTreeNode >> maxDepthWidth [
	"Return the maximum width of the nodes at the same depth as me"
	<return: #Number>
	| aMaxWidth |

	aMaxWidth := self width.

	self root
		nodesAt: self depth
		do: [ :aTreeNode | aMaxWidth := aMaxWidth max: aTreeNode width ].
		
	^ aMaxWidth
]

{ #category : #'api - geometry' }
GtGradTreeNode >> maxHeight [
	"Return the maximum height of my direct children nodes"
	<return: #Number>
	
	^ self nodes
		ifEmpty: [ 0 ]
		ifNotEmpty: [ (self nodes detectMax: [ :aTreeNode | aTreeNode height ]) height ]
]

{ #category : #accessing }
GtGradTreeNode >> maxHeightAt: aTreeNode [
	<return: #Number>

	maxHeights isNil
		ifTrue: [ maxHeights := PluggableDictionary new ].

	^ maxHeights
		at: aTreeNode depth
		ifAbsentPut: [ aTreeNode maxDepthHeight ]
]

{ #category : #'api - geometry' }
GtGradTreeNode >> maxWidth [
	"Return the maximum width of my direct children nodes"
	<return: #Number>
	
	^ self nodes
		ifEmpty: [ 0 ]
		ifNotEmpty: [ (self nodes detectMax: [ :aTreeNode | aTreeNode width ]) width ]
]

{ #category : #accessing }
GtGradTreeNode >> maxWidthAt: aTreeNode [
	<return: #Number>
	
	maxWidths isNil
		ifTrue: [ maxWidths := PluggableDictionary new ].

	^ maxWidths
		at: aTreeNode depth
		ifAbsentPut: [ aTreeNode maxDepthWidth ]
]

{ #category : #accessing }
GtGradTreeNode >> nodes [
	<return: #Collection of: #GtGradTreeNode>

	^ nodes
]

{ #category : #'api - enumeration' }
GtGradTreeNode >> nodesAt: aDepth do: aBlock [

	"Already deeper than needed"
	self depth > aDepth
		ifTrue: [ ^ self ].

	self depth = aDepth
		ifTrue: [
			aBlock value: self.
			^ self ].

	self nodes do: [ :aTreeNode | aTreeNode nodesAt: aDepth do: aBlock ]
]

{ #category : #accessing }
GtGradTreeNode >> offset [
	^ offset
]

{ #category : #accessing }
GtGradTreeNode >> offset: aPoint [
	offset := aPoint
]

{ #category : #accessing }
GtGradTreeNode >> parent [
	<return: #GtGradTreeNode>

	self
		assert: [ self hasParent ]
		description: [ 'Can not access parent if it does not exist' ].

	^ parent
]

{ #category : #accessing }
GtGradTreeNode >> parent: aTreeNode [
	parent := aTreeNode
]

{ #category : #printing }
GtGradTreeNode >> printOn: aStream [

	aStream
		nextPutAll: 'Node';
		nextPut: $[;
		nextPutAll: self depth asString;
		nextPut: $];
		space;
		print: self offset;
		nextPut: $(;
		print: self element;
		nextPut: $)
]

{ #category : #'api - adding' }
GtGradTreeNode >> remove: aTreeNode [
	
	aTreeNode parent: nil.
	aTreeNode depth: 0.

	self nodes remove: aTreeNode.
]

{ #category : #accessing }
GtGradTreeNode >> root [
	"Return the root of this tree"
	<return: #GtGradTreeNode>
	
	^ self hasParent
		ifTrue: [ self parent root ]
		ifFalse: [ self ]
]

{ #category : #'api - geometry' }
GtGradTreeNode >> width [
	"Return the width of my element"
	<return: #Number>
	
	^ self element width
]
