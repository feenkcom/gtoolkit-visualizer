"
I am a  builder for specifying edges. I exist mainly for the convenience of having a fluent API.

I work in close collaboration with the ==GtMondrianStep== who eventually has to store the edges I produce.
"
Class {
	#name : #GtMondrianEdgeBuilder,
	#superclass : #GtMondrianGraphBuilder,
	#instVars : [
		'fromAnchorClass',
		'toAnchorClass',
		'areEdgesPassive'
	],
	#category : #'GToolkit-Mondrian'
}

{ #category : #accessing }
GtMondrianEdgeBuilder >> areEdgesPassive [
	^ areEdgesPassive
]

{ #category : #accessing }
GtMondrianEdgeBuilder >> areEdgesPassive: aBoolean [
	areEdgesPassive := aBoolean
]

{ #category : #scripting }
GtMondrianEdgeBuilder >> connect: aCollection from: aBlockOrSymbol [ 
	^ self connect: aCollection from: aBlockOrSymbol to: [ :x | x ]
]

{ #category : #scripting }
GtMondrianEdgeBuilder >> connect: aCollection from: aFromBlock to: aToBlock [
	| elements |
	elements := self
		privateConnect: aCollection
		from: aToBlock
		to: aFromBlock.
	self topStep root addChildren: elements.
	^ elements
]

{ #category : #scripting }
GtMondrianEdgeBuilder >> connect: aCollection from: aFromBlock toAll: aToAllBlock [
"	^ aCollection flatCollect: [ :each |
		self connect: (aToAllBlock value: each) from: [ :x | aFromBlock value: each ] to: [ :x | x ] ]"
"connect: aCollection fromAll: aFromAllBlock to: aToBlock"
	| elements |
	elements := aCollection flatCollect: [ :each |
		(aToAllBlock value: each) flatCollect: [ :to |
			self connect: {each} from: [ :x | aFromBlock value: each ] to: [ :x | to ] ] ].
	"self topStep root addChildren: elements."
	^ elements
]

{ #category : #scripting }
GtMondrianEdgeBuilder >> connect: aCollection fromAll: aBlockOrSymbol [ 
	^ self 
		connect: aCollection
		fromAll: aBlockOrSymbol
		to: [ :x | x ]
]

{ #category : #scripting }
GtMondrianEdgeBuilder >> connect: aCollection fromAll: aFromAllBlock to: aToBlock [
	| elements |
	elements := aCollection flatCollect: [ :each |
		| currentEdges |
		currentEdges := OrderedCollection new.
		(aFromAllBlock value: each) do: [ :from |
			currentEdges addAll: (self 
				connect: {each} 
				from: [ :x | from ] 
				to: [ :x | aToBlock value: each ]) ].
		currentEdges ].
	"self topStep root addChildren: elements."
	^ elements
]

{ #category : #scripting }
GtMondrianEdgeBuilder >> connect: aCollection fromAll: aFromAllBlock toAll: aToAllBlock [
	| elements |
	elements := aCollection flatCollect: [ :each |
		(aFromAllBlock value: each) flatCollect: [ :from |
			self connect: {each} from: [ :x | from ] toAll: [ :x | aToAllBlock value: each ] ] ].
	^ elements
]

{ #category : #scripting }
GtMondrianEdgeBuilder >> connect: aCollection toAll: aToBlock [
	^ self
		connect: aCollection
		from: [ :each | each ] 
		toAll: aToBlock
]

{ #category : #scripting }
GtMondrianEdgeBuilder >> connectFrom: aFromBlock [
	^ self
		connectFrom: aFromBlock 
		to: [ :each | each ]
]

{ #category : #scripting }
GtMondrianEdgeBuilder >> connectFrom: aFromBlock to: aToBlock [
	^ self
		connect:
			(self topStep root graph nodeChildren
				collect: [ :each | each graph model ])
		from: aFromBlock
		to: aToBlock
]

{ #category : #scripting }
GtMondrianEdgeBuilder >> connectFrom: aFromBlock toAll: aToBlock [
	^ self
		connect:
			(self topStep root graph nodeChildren
				collect: [ :each | each graph model ])
		from: aFromBlock
		toAll: aToBlock
]

{ #category : #scripting }
GtMondrianEdgeBuilder >> connectFromAll: aFromBlock [
	^ self
		connectFromAll: aFromBlock 
		to: [ :each | each ]
]

{ #category : #scripting }
GtMondrianEdgeBuilder >> connectFromAll: aFromBlock to: aToBlock [
	^ self
		connect: 
			(self topStep root graph nodeChildren
				collect: [ :each | each graph model ])
		fromAll: aFromBlock
		to: aToBlock
]

{ #category : #scripting }
GtMondrianEdgeBuilder >> connectTo: aToBlock [
	^ self
		connectFrom: [ :each | each ] 
		to: aToBlock
]

{ #category : #scripting }
GtMondrianEdgeBuilder >> connectToAll: aToBlock [
	^ self
		connectFrom: [ :each | each ] 
		toAll: aToBlock
]

{ #category : #private }
GtMondrianEdgeBuilder >> defaultEdgeElement [
	^ BlLineElement new
		border: (BlBorder paint: (Color gray alpha: 0.5) width: 1);
		constraintsDo: [:c | c ignoreByLayout ];
		zIndex: -1
]

{ #category : #private }
GtMondrianEdgeBuilder >> edgeConstraintsFrom: fromElement to: toElement line: aLineElement [
	fromElement constraints graph addConnectedEdge: aLineElement graph model.
	toElement constraints graph addConnectedEdge: aLineElement graph model
]

{ #category : #accessing }
GtMondrianEdgeBuilder >> edgeElementFor: anObject [
	^ elementStencilBuilder
		ifNotNil: [ elementStencilBuilder value: anObject ]
		ifNil: [ self defaultEdgeElement ]
]

{ #category : #private }
GtMondrianEdgeBuilder >> edgeElementFor: anObject from: fromElement to: toElement [
	| edgeElement anEdgeModel |
	edgeElement := elementStencilBuilder
		ifNotNil: [ elementStencilBuilder 
				cull: anObject
				cull: fromElement
				cull: toElement ]
		ifNil: [ self defaultEdgeElement ].
	edgeElement
		fromAnchor: (fromAnchorClass referenceElement: fromElement relatedTo: toElement);
		toAnchor: (toAnchorClass referenceElement: toElement relatedTo: fromElement).
	edgeElement constraints ignoreByLayout.
	
	anEdgeModel := GtGraphEdgeWithElement new
		element: edgeElement;
		from: fromElement to: toElement.
	
	edgeElement graph model: anEdgeModel.
	edgeElement graph beEdge.
	^ edgeElement
]

{ #category : #'scripting anchors' }
GtMondrianEdgeBuilder >> fromAnchor: aClass [
	fromAnchorClass := aClass
]

{ #category : #'scripting anchors' }
GtMondrianEdgeBuilder >> fromCenterBottom [
	self fromAnchor: BlElementBottomCenterAnchor
]

{ #category : #'scripting anchors' }
GtMondrianEdgeBuilder >> fromCenterTop [
	self fromAnchor: BlElementTopCenterAnchor
]

{ #category : #'scripting anchors' }
GtMondrianEdgeBuilder >> fromLeftCenter [
	self fromAnchor: BlElementCenterLeftAnchor
]

{ #category : #'scripting anchors' }
GtMondrianEdgeBuilder >> fromNearestBounds [
	self fromAnchor: BlNearestPositionBoundsAnchor
]

{ #category : #'scripting anchors' }
GtMondrianEdgeBuilder >> fromNearestCircle [
	"Circle radius is computed as a half of bounds diagonal length.
	(Will not match circle nodes)"

	self fromAnchor: BlNearestPositionLooseCircleAnchor
]

{ #category : #'scripting anchors' }
GtMondrianEdgeBuilder >> fromNearestTightCircle [
	"Circle radius is computed as a half of the maximum of height and width.
	(matches circle nodes)"

	self fromAnchor: BlNearestPositionTightCircleAnchor
]

{ #category : #'scripting anchors' }
GtMondrianEdgeBuilder >> fromRightCenter [
	self fromAnchor: BlElementCenterRightAnchor
]

{ #category : #initialize }
GtMondrianEdgeBuilder >> initialize [
	areEdgesPassive := false.
	fromAnchorClass := BlNearestPositionBoundsAnchor.
	toAnchorClass := BlNearestPositionBoundsAnchor

]

{ #category : #scripting }
GtMondrianEdgeBuilder >> passive [
	"Specifies that the constructed edges should not add constraints between nodes. 
	For example, this is useful if you have a tree as base layout,
	but want to add extra edges on top that should not affect the base layout."
	self areEdgesPassive: true
]

{ #category : #scripting }
GtMondrianEdgeBuilder >> privateConnect: aCollection from: aToBlock to: aFromBlock [
	| elements |
	elements := OrderedCollection new.
	aCollection
		do: [ :each | 
			| fromObject toObject fromElement toElement line |
			fromObject := aFromBlock value: each.
			toObject := aToBlock value: each.
			fromElement := mondrian nodeAt: fromObject ifAbsent: [ nil ].
			toElement := mondrian nodeAt: toObject ifAbsent: [ nil ].
			(toElement notNil and: [ fromElement notNil ])
				ifTrue: [
					line := self edgeElementFor: each from: fromElement to: toElement.
					self areEdgesPassive
						ifFalse: [ self edgeConstraintsFrom: fromElement to: toElement line: line ].
					elements add: line ]
				ifFalse: [ (GtMondrianEdgeNotCreated new
						fromElement: fromElement;
						toElement: toElement;
						model: each;
						fromModel: fromObject;
						toModel: toObject) emit ] ].
	^ elements
]

{ #category : #'scripting anchors' }
GtMondrianEdgeBuilder >> toAnchor: aClass [
	toAnchorClass := aClass
]

{ #category : #'scripting anchors' }
GtMondrianEdgeBuilder >> toCenterBottom [
	self toAnchor: BlElementBottomCenterAnchor
]

{ #category : #'scripting anchors' }
GtMondrianEdgeBuilder >> toCenterTop [
	self toAnchor: BlElementTopCenterAnchor
]

{ #category : #'scripting anchors' }
GtMondrianEdgeBuilder >> toLeftCenter [
	self toAnchor: BlElementCenterLeftAnchor
]

{ #category : #'scripting anchors' }
GtMondrianEdgeBuilder >> toNearestBounds [
	self toAnchor: BlNearestPositionBoundsAnchor
]

{ #category : #'scripting anchors' }
GtMondrianEdgeBuilder >> toNearestCircle [
	"Circle radius is computed as a half of bounds diagonal length.
	(Will not match circle nodes)"

	self toAnchor: BlNearestPositionLooseCircleAnchor
]

{ #category : #'scripting anchors' }
GtMondrianEdgeBuilder >> toNearestTightCircle [
	"Circle radius is computed as a half of the maximum of height and width.
	(matches circle nodes)"

	self toAnchor: BlNearestPositionTightCircleAnchor
]

{ #category : #'scripting anchors' }
GtMondrianEdgeBuilder >> toRightCenter [
	self toAnchor: BlElementCenterRightAnchor
]
