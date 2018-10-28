Class {
	#name : #GtGradAbstractTreeLayoutExamples,
	#superclass : #GtGradLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> biggestNodesByLevels: theCurrentNode currentLevel: theCurrentLevel maxDimensionByLevels: aMaxDimensionsByLevelsMap [
	| nodeDimension currentMax |
	
	nodeDimension := self getNodeLevelConstantAxisDimension: theCurrentNode.
	currentMax := 0.
	(aMaxDimensionsByLevelsMap includesKey: theCurrentLevel)
		ifTrue: [ 
			currentMax := self getNodeLevelConstantAxisDimension: (aMaxDimensionsByLevelsMap at: theCurrentLevel).
		].
	nodeDimension > currentMax
		ifTrue: [ 
			aMaxDimensionsByLevelsMap at: theCurrentLevel put: theCurrentNode.
	].
	
	theCurrentNode nodes do: [ :aChildNode |
		self biggestNodesByLevels: aChildNode currentLevel: theCurrentLevel + 1 maxDimensionByLevels: aMaxDimensionsByLevelsMap
	].
	
	

	
	
]

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> calculateNodeAlignedPosition: aTreeNode alignment: alignment [
	| nodePosition parentPosition parentDimension |
	
	nodePosition := self getNodeLevelConstantPosition: aTreeNode.
	
	( alignment isMemberOf: GtGradTreeNodesTopAlignment)
		ifTrue: [ 
			"in case of top alignment all nodes on the same level should have the same position"
			^ nodePosition
		].

	parentPosition := self getNodeLevelConstantPosition: aTreeNode parent.
	parentDimension := self getNodeLevelConstantAxisDimension: aTreeNode parent.

	( alignment isMemberOf: GtGradTreeNodesBottomAlignment)
		ifTrue: [ 
			"in case of the bottom alignment positions of  nodes on the same level  - bottommost points
			of their parents should be the same "
			^ nodePosition - (parentPosition + parentDimension)
		].
	
	( alignment isMemberOf: GtGradTreeNodesBottomAlignment)
		ifTrue: [ 
			"in case of the bottom alignment positions of  nodes on the same level  - bottommost points
			of their parents / 2 should be the same "
			^ nodePosition - ((parentPosition + parentDimension) / 2)
		]
	
]

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> checkAlignmentOfNodes: aTreeNode alignment: alignment positionsByLevels: aPositionsByLevelsMap currentLevel: theCurrentLevel [
	| levelPosition |

	aTreeNode nodes isEmpty
		ifTrue: [ 
			^ self
		 ].
	levelPosition := nil.
	(aPositionsByLevelsMap includesKey: theCurrentLevel)
		ifTrue: [ 
			levelPosition := aPositionsByLevelsMap at: theCurrentLevel 
		]
		ifFalse: [ 
			| firstChild |
			firstChild := aTreeNode nodes first.
			levelPosition := self calculateNodeAlignedPosition: firstChild alignment: alignment.
			aPositionsByLevelsMap at: theCurrentLevel put: levelPosition.
		].
		
	aTreeNode nodes
		do: [ :aChildNode | 
			| currentChildNodePosition |
			currentChildNodePosition := self calculateNodeAlignedPosition: aChildNode alignment: alignment.
			self assert: currentChildNodePosition equals: levelPosition.
			self checkAlignmentOfNodes: aChildNode alignment: alignment  positionsByLevels: aPositionsByLevelsMap currentLevel: theCurrentLevel + 1.
	]
]

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> checkOverlapBetweenLevels: theRootNode levelDistance: levelDistance reversed: reversed [
	"This check should ensure that nodes on adjacent levels that are closest to each other vertically/horizontally do not overlap. Still work in progress. These nodes which are closest to each other are the biggest nodes on levels "
	| biggestNodesByLevelsMap numOfLevels |
	
	biggestNodesByLevelsMap := Dictionary new.
	self biggestNodesByLevels: theRootNode currentLevel: 1 maxDimensionByLevels: biggestNodesByLevelsMap.
	
	numOfLevels := biggestNodesByLevelsMap size.
	
	2 to: numOfLevels do:  [ :theCurrentLevel |
		| previousNode currentNode previousNodePosition currentNodePosition previousDim |
		previousNode := biggestNodesByLevelsMap at: theCurrentLevel - 1.
		currentNode := biggestNodesByLevelsMap at: theCurrentLevel.
		previousNodePosition:= self getNodeLevelConstantPosition: previousNode.
		currentNodePosition := self getNodeLevelConstantPosition: currentNode.
		previousDim := self getNodeLevelConstantAxisDimension: previousNode.
		reversed
			ifFalse: [
				self assert: currentNodePosition > (previousNodePosition + previousDim)
			]
			ifTrue: [ 
				self assert: currentNodePosition < (previousNodePosition - previousDim)
			].
	].
]

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> checkPositionsAndDistancesBetweenTreeNodes: theCurrentNode nodeDistance: nodeDistance levelDistance: levelDistance reversed: reversed [
	"
	In addition to checking if children of overlap and if children overlap with their parents, we also
	need to check if all nodes on one level have the same horizontal position.
	"
	| previousChildNode  maxPoint minPoint |
	previousChildNode := nil.
	maxPoint :=  self nodeMaximumPoint: theCurrentNode.
	minPoint := self nodeMinimumPoint: theCurrentNode.
	
	theCurrentNode nodes
		do: [ :aChildNode | 
			| childBounds |

			"check if that positions overlaps with the parent"
			reversed
				ifFalse: [ self
						assert: (self getNodeLevelConstantPosition: theCurrentNode) + levelDistance <= ( self getNodeLevelConstantPosition: aChildNode) ]
				ifTrue: [ self
						assert: ( self getNodeLevelConstantPosition: theCurrentNode) - levelDistance >= ( self getNodeLevelConstantPosition: aChildNode ) ].

			previousChildNode isNotNil
				ifTrue: [ | previousSize |
					"check if all children have the same y position"
					self
						assert: ( self getNodeLevelConstantPosition: previousChildNode )
						equals: ( self getNodeLevelConstantPosition: aChildNode ).
					previousSize := self getNodeLevelVariableAxisDimension: previousChildNode.
					"check if the space between nodes is equal to or
					greater than the specified space between nodes"
					self
						assert:
							( self getNodeLevelVariablePosition: aChildNode )
								- (( self getNodeLevelVariablePosition: previousChildNode ) + previousSize)
								>= nodeDistance ].
			previousChildNode := aChildNode.

			childBounds := self
				checkPositionsAndDistancesBetweenTreeNodes: aChildNode
				nodeDistance: nodeDistance
				levelDistance: levelDistance
				reversed: reversed.
			minPoint := minPoint min: childBounds x.
			maxPoint := maxPoint max: childBounds y ].
	^ minPoint @ maxPoint
]

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> checkPositionsOfSubtrees: theCurrentNode [
	"this method  should make sure that a node is positioned to the right
	 of the rightmost child of its left sibling"
	| previousChildNodesMaxChildPoint lastChildPosition lastChildDim |
	
	previousChildNodesMaxChildPoint := nil.

	theCurrentNode nodes do: [ :aChildNode |
		previousChildNodesMaxChildPoint isNotNil
			ifTrue: [ 
				self assert:  previousChildNodesMaxChildPoint < (self getNodeLevelVariablePosition: aChildNode).
			].
		previousChildNodesMaxChildPoint := self checkPositionsOfSubtrees: aChildNode.
	 ].

	theCurrentNode nodes isEmpty
		ifTrue: [ 
			^ nil	
		].

	lastChildPosition := self getNodeLevelVariablePosition: (theCurrentNode nodes last).
	lastChildDim := self getNodeLevelVariableAxisDimension: (theCurrentNode nodes last).
	^ lastChildPosition + lastChildDim

	
	

]

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> checkPositionsOfTreesAndNodes: theNodes layout: aTreeLayout [
	| forest previousMaxPoint previousRoot|
	forest := self constructForest: theNodes.
	previousMaxPoint := nil.
	previousRoot := nil.
	
	forest trees
		do: [ :aRootNode | 
			| bounds |
			previousRoot isNotNil
			ifTrue: [ 
				self assert: (self getNodeLevelConstantPosition: previousRoot) equals: (self getNodeLevelConstantPosition: aRootNode).
			].
			previousRoot := aRootNode.
			bounds := self
					checkPositionsAndDistancesBetweenTreeNodes: aRootNode
											 nodeDistance: aTreeLayout nodeDistance
							    			 	 levelDistance: aTreeLayout levelDistance
											 reversed: aTreeLayout reverse.

			previousMaxPoint isNotNil
				ifTrue: [ 
					self assert: ( previousMaxPoint + aTreeLayout treesDistance )  <=  bounds x.
				].
			previousMaxPoint := bounds y.

			aTreeLayout separateSubtrees
				ifTrue: [ 
					self checkPositionsOfSubtrees: aRootNode
				].
			self checkAlignmentOfNodes: aRootNode alignment: aTreeLayout nodesAlignment positionsByLevels: Dictionary new currentLevel: 1.
			self checkOverlapBetweenLevels: aRootNode levelDistance: aTreeLayout levelDistance reversed: aTreeLayout reverse.
	
			]
]

{ #category : #'example - instance creation' }
GtGradAbstractTreeLayoutExamples >> constructForest: theNodes [
	self subclassResponsibility
]

{ #category : #'example - instance creation' }
GtGradAbstractTreeLayoutExamples >> constructGraphWithANodeWithSeveralIncomingEdges [
	^ self subclassResponsibility
]

{ #category : #'example - instance creation' }
GtGradAbstractTreeLayoutExamples >> constructTreeWithNodesWithAndWithoutChildrenOnTheSameLevel [
	^ self subclassResponsibility
]

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> distinctSubtrees [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtGradAbstractTreeLayoutExamples >> getNodeLevelConstantAxisDimension: arg1 [ 
	^ self subclassResponsibility
]

{ #category : #accessing }
GtGradAbstractTreeLayoutExamples >> getNodeLevelConstantPosition: arg1 [ 
	^ self subclassResponsibility
]

{ #category : #accessing }
GtGradAbstractTreeLayoutExamples >> getNodeLevelVariableAxisDimension: arg1 [ 
	^ self subclassResponsibility
]

{ #category : #accessing }
GtGradAbstractTreeLayoutExamples >> getNodeLevelVariablePosition: arg1 [ 
	^ self subclassResponsibility
]

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> graphWithANodeWithSeveralIncomingEdges [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtGradAbstractTreeLayoutExamples >> nodeMaximumPoint: arg1 [ 
	^ self subclassResponsibility
]

{ #category : #accessing }
GtGradAbstractTreeLayoutExamples >> nodeMinimumPoint: arg1 [ 
	^ self subclassResponsibility
]
