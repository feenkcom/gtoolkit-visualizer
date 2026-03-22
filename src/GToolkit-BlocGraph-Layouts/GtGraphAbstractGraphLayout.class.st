Class {
	#name : #GtGraphAbstractGraphLayout,
	#superclass : #GtGraphEdgeDrivenLayout,
	#instVars : [
		'verticalGap',
		'horizontalGap',
		'cachedChildren',
		'cachedParents',
		'cachedParentsWithHighestNestings'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Layouts'
}

{ #category : #constants }
GtGraphAbstractGraphLayout class >> horizontalGap [
	
	^3.0
]

{ #category : #testing }
GtGraphAbstractGraphLayout class >> isAbstract [
	^ self = GtGraphAbstractGraphLayout
]

{ #category : #constants }
GtGraphAbstractGraphLayout class >> verticalGap [
	
	^20.0
]

{ #category : #private }
GtGraphAbstractGraphLayout >> cachedChildren [
	
	cachedChildren ifNil: [cachedChildren := IdentityDictionary new: 1000].
	^cachedChildren
]

{ #category : #private }
GtGraphAbstractGraphLayout >> cachedParents [
	
	cachedParents ifNil: [cachedParents := IdentityDictionary new: 1000].
	^cachedParents
]

{ #category : #private }
GtGraphAbstractGraphLayout >> cachedParentsWithHighestNestings [
	
	cachedParentsWithHighestNestings
		ifNil: [cachedParentsWithHighestNestings := IdentityDictionary new: 1000].
	^cachedParentsWithHighestNestings
]

{ #category : #private }
GtGraphAbstractGraphLayout >> childrenFor: aNode [
	^ self cachedChildren
		at: aNode
		ifAbsentPut: [ | nodes |
			nodes := OrderedCollection new.
			self
				edgesDo: [ :edge | 
					(edge fromNode == aNode and: [ edge toNode ~= aNode ])
						ifTrue: [ (nodes includes: edge fromNode)
								ifFalse: [ nodes add: edge toNode ] ] ].
			nodes ]
]

{ #category : #private }
GtGraphAbstractGraphLayout >> childrenFor: aNode except: aNodeCollection [
	
	^(self childrenFor: aNode) 
		reject: [:each | aNodeCollection includes: each]
	
	"we are explicitly not using the default Collection>>difference: behavior here because we want to preserve the order of the collection"
]

{ #category : #private }
GtGraphAbstractGraphLayout >> childrenWithHighestNestingLevelFor: aNode [
	
	^(self childrenFor: aNode)
		select: [:eachChild | (self highestNestingParentFor: eachChild) == aNode]
]

{ #category : #private }
GtGraphAbstractGraphLayout >> clear [
	
	cachedParents := nil.
	cachedChildren := nil.
	cachedParentsWithHighestNestings := nil
]

{ #category : #'default values' }
GtGraphAbstractGraphLayout >> defaultFromPositions [
	
	^#(#bottomCenter)
]

{ #category : #hook }
GtGraphAbstractGraphLayout >> doInitialize: elements with: anExtentSpec [
	super doInitialize: elements with: anExtentSpec.
	self clear.
	self greedyCycleRemoval: elements
]

{ #category : #battista }
GtGraphAbstractGraphLayout >> greedyCycleRemoval: aCollection [
	"Di Battista Greedy-Cycle-Removal algorithm. Chapter 9.4, page 297. The last part is not like in the book. The original algorithm only takes
	 local optimas into account. This will break ordinary trees sometimes. This version also takes global optimas into account."

	| g sl sr s indeg outdeg degrees vertex |
	g := aCollection copy asOrderedCollection.
	sl := OrderedCollection new.
	sr := OrderedCollection new.	"While g contains a sink (aka leaf)"
	g copy
		do: [ :node | 
			(self childrenFor: node) isEmpty
				ifTrue:
					[ "self edges detect: [:edge | edge fromFigure == node] ifNone: [sr addFirst: node. g remove: node]"
					sr addFirst: node.
					g remove: node ] ].	"While g contains a source (aka root)"
	g copy
		do: [ :node | 
			(self parentsFor: node) isEmpty
				ifTrue:
					[ "self edges detect: [:edge | edge toFigure == node] ifNone: [sl addLast: node. g remove: node]"
					sl addLast: node.
					g remove: node ] ].	"Calculate deg for all remaining vertices"
	degrees := IdentityDictionary new.
	g
		do: [ :node | 
			indeg := (self parentsFor: node) size.
			outdeg := (self childrenFor: node) size.	"indeg := self edges inject: 0 into: [:sum :edge | (edge toFigure == node) ifTrue: [sum + 1] ifFalse: [sum]].
		outdeg := self edges inject: 0 into: [:sum :edge | (edge fromFigure == node) ifTrue: [sum + 1] ifFalse: [sum]]."
			degrees at: node put: outdeg - indeg ].	"While g not empty"
	g := g
		asSortedCollection: [ :a :b | (degrees at: a) >= (degrees at: b) ].
	[ g isEmpty ]
		whileFalse: [ vertex := g
				detect: [ :v | (self parentsFor: v) anySatisfy: [ :w | sl includes: w ] ]
				ifNone: [ g first ].	"Corner case: Closed cycle with not root at all. Eg 1 -> 2 -> 3 -> 1"
			sl addLast: vertex.
			g remove: vertex ].	"Remove all leftward edges"
	s := sl , sr.
	self edges notNil
		ifTrue: [ self edges copy
				do: [ :edge | 
					(s indexOf: edge fromNode) > (s indexOf: edge toNode)
						ifTrue: [ self edges remove: edge ] ] ].
	"Reset the cache"
	self clear
]

{ #category : #private }
GtGraphAbstractGraphLayout >> highestNestingParentFor: aNodeFigure [
	
	| parents |
	^self cachedParentsWithHighestNestings
		at: aNodeFigure
		ifAbsentPut:
			[parents := self parentsFor: aNodeFigure.
			parents isEmpty
				ifTrue: [0]
				ifFalse:
					[parents detectMax: [:eachParent | self nestingLevelFor: eachParent]]]
]

{ #category : #accessing }
GtGraphAbstractGraphLayout >> horizontalGap [
	
	^horizontalGap ifNil: [ self class horizontalGap ]
]

{ #category : #accessing }
GtGraphAbstractGraphLayout >> horizontalGap: anInteger [
	
	horizontalGap := anInteger
]

{ #category : #private }
GtGraphAbstractGraphLayout >> maximumDiameter: aCollection [
	
	^aCollection
		inject: 0
		into: [:max :node | max max: (node constraints graph radius * 2) ]
 
]

{ #category : #private }
GtGraphAbstractGraphLayout >> maximumRadius: aCollection [
	
	^aCollection
		inject: 0
		into: [:max :node | max max: node constraints graph radius ]
]

{ #category : #private }
GtGraphAbstractGraphLayout >> nestingLevelFor: aNodeFigure [
	
	| parents parentsNesting |
	parents := self parentsFor: aNodeFigure.
	parentsNesting := parents
		collect: [:eachParent | self nestingLevelFor: eachParent].
	^parentsNesting isEmpty
		ifTrue: [0]
		ifFalse: [parentsNesting max + 1]

]

{ #category : #private }
GtGraphAbstractGraphLayout >> parentsFor: aNode [
	^ self cachedParents
		at: aNode
		ifAbsentPut: [ | nodes |
			nodes := OrderedCollection new.
			self
				edgesDo: [ :edge | 
					edge toNode == aNode
						ifTrue: [ nodes add: edge fromNode ] ].
			nodes ]
]

{ #category : #private }
GtGraphAbstractGraphLayout >> rootNodesFor: aCollection [
	^ aCollection select: [:node | 
		(self parentsFor: node) isEmpty ].
	
]

{ #category : #private }
GtGraphAbstractGraphLayout >> shiftTree: aNode by: aPoint [
	
	aNode position: (aNode position + aPoint).
	(self childrenFor: aNode)
		do: [:child | self shiftTree: child by: aPoint]
]

{ #category : #accessing }
GtGraphAbstractGraphLayout >> verticalGap [
	
	^verticalGap ifNil: [self class verticalGap]
]

{ #category : #accessing }
GtGraphAbstractGraphLayout >> verticalGap: anInteger [
	
	verticalGap := anInteger
]
