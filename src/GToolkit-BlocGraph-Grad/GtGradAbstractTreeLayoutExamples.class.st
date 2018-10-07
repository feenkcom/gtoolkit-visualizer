Class {
	#name : #GtGradAbstractTreeLayoutExamples,
	#superclass : #GtGradLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> checkBottomAlignmentOfNodes: aTreeNode positionsByLevels: aPositionsByLevelsMap currentLevel: theCurrentLevel [
]

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> checkCenterAlignmentOfNodes: aTreeNode positionsByLevels: aPositionsByLevelsMap currentLevel: theCurrentLevel [
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
			
			]
]

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> checkTopAlignmentOfNodes: aTreeNode positionsByLevels: aPositionsByLevelsMap currentLevel: theCurrentLevel [
	| levelVerticalPosition |
	"WIP!"

	levelVerticalPosition := nil.
	(aPositionsByLevelsMap includesKey: theCurrentLevel)
		ifTrue:
			[ levelVerticalPosition := aPositionsByLevelsMap at: theCurrentLevel ].
		
	aTreeNode nodes
		do: [ :aChildNode | 
			| currentChildNodePosition  |
			currentChildNodePosition := aChildNode element position.
			levelVerticalPosition
				ifNotNil: [ self
						assert: currentChildNodePosition x
						equals: levelVerticalPosition ]
				ifNil: [ aPositionsByLevelsMap
						at: theCurrentLevel
						put: currentChildNodePosition x ].
	]
]

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> constructForest: theNodes [
	self subclassResponsibility
]
