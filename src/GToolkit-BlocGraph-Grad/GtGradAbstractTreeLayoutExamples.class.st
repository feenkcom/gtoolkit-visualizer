Class {
	#name : #GtGradAbstractTreeLayoutExamples,
	#superclass : #GtGradLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> checkPositionsAndDistancesBetweenHorizontalTreeNodes: theCurrentNode nodeDistance: nodeDistance levelDistance: levelDistance reversed: reversed positionsByLevels: aPositionsByLevelsMap currentLevel: theCurrentLevel [
	"
	In addition to checking if children of overlap and if children overlap with their parents, we also 
	need to check if all nodes on one level have the same horizontal position. 
	"

	| previousChildNode previousChildNodePosition currentNodePosition levelHorizontalPosition topmostPoint bottommostPoint |
	previousChildNode := nil.
	previousChildNodePosition := nil.
	levelHorizontalPosition := nil.
	currentNodePosition := theCurrentNode element position.
	topmostPoint := currentNodePosition y
		+ theCurrentNode element bounds extent y.
	bottommostPoint := currentNodePosition y.
	(aPositionsByLevelsMap includesKey: theCurrentLevel)
		ifTrue:
			[ levelHorizontalPosition := aPositionsByLevelsMap at: theCurrentLevel ].
	theCurrentNode nodes
		do: [ :aChildNode | 
			| currentChildNodePosition childBounds |
			currentChildNodePosition := aChildNode element position.
			levelHorizontalPosition
				ifNotNil: [ self
						assert: currentChildNodePosition x
						equals: levelHorizontalPosition ]
				ifNil: [ aPositionsByLevelsMap
						at: theCurrentLevel
						put: currentChildNodePosition x ].

			"check if that positions overlaps with the parent"
			reversed
				ifFalse: [ self
						assert: currentNodePosition x + levelDistance <= currentChildNodePosition x ]
				ifTrue: [ self
						assert: currentNodePosition x - levelDistance >= currentChildNodePosition x ].
			previousChildNode isNotNil
				ifTrue: [ | previousHeight |
					"check if all children have the same y position"
					self
						assert: previousChildNodePosition x
						equals: currentChildNodePosition x.
					previousHeight := previousChildNode element bounds extent y.
					"check if the space between nodes is equal to or
				greater than the specified space between nodes"
					self
						assert:
							currentChildNodePosition y
								- (previousChildNodePosition y + previousHeight)
								>= nodeDistance ].
			previousChildNode := aChildNode.
			previousChildNodePosition := currentChildNodePosition.
			childBounds := self
				checkPositionsAndDistancesBetweenHorizontalTreeNodes: aChildNode
				nodeDistance: nodeDistance
				levelDistance: levelDistance
				reversed: reversed
				positionsByLevels: aPositionsByLevelsMap
				currentLevel: theCurrentLevel + 1.
			topmostPoint := topmostPoint min: childBounds x.
			bottommostPoint := bottommostPoint max: childBounds y ].
	^ bottommostPoint @ topmostPoint
]

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> checkPositionsAndDistancesBetweenVerticalTreeNodes: theCurrentNode nodeDistance: nodeDistance levelDistance: levelDistance reversed: reversed positionsByLevels: aPositionsByLevelsMap currentLevel: theCurrentLevel [
	"
	In addition to checking if children of overlap and if children overlap with their parents, we also
	 need to check if all nodes on one level have the same vertical position. 
	"

	| previousChildNode previousChildNodePosition currentNodePosition levelVerticalPosition rightmostPoint leftmostPoint |
	previousChildNode := nil.
	previousChildNodePosition := nil.
	levelVerticalPosition := nil.
	currentNodePosition := theCurrentNode element position.
	rightmostPoint := currentNodePosition x
		+ theCurrentNode element bounds extent x.
	leftmostPoint := currentNodePosition x.
	(aPositionsByLevelsMap includesKey: theCurrentLevel)
		ifTrue:
			[ levelVerticalPosition := aPositionsByLevelsMap at: theCurrentLevel ].
	theCurrentNode nodes
		do: [ :aChildNode | 
			| currentChildNodePosition childBounds |
			currentChildNodePosition := aChildNode element position.
			levelVerticalPosition
				ifNotNil: [ self
						assert: currentChildNodePosition y
						equals: levelVerticalPosition ]
				ifNil: [ aPositionsByLevelsMap
						at: theCurrentLevel
						put: currentChildNodePosition y ].

			"check if that positions overlaps with the parent"
			reversed
				ifFalse: [ self
						assert: currentNodePosition y + levelDistance <= currentChildNodePosition y ]
				ifTrue: [ self
						assert: currentNodePosition y - levelDistance >= currentChildNodePosition y ].
			previousChildNode isNotNil
				ifTrue: [ | previousNodeWidth |
					"check if all children have the same y position"
					self
						assert: previousChildNodePosition y
						equals: currentChildNodePosition y.
					previousNodeWidth := previousChildNode element bounds extent x.
					"check if the space between nodes is equal to or
				greater than the specified space between nodes"
					self
						assert:
							currentChildNodePosition x
								- (previousChildNodePosition x + previousNodeWidth)
								>= nodeDistance ].
			previousChildNode := aChildNode.
			previousChildNodePosition := currentChildNodePosition.
			childBounds := self
				checkPositionsAndDistancesBetweenVerticalTreeNodes: aChildNode
				nodeDistance: nodeDistance
				levelDistance: levelDistance
				reversed: reversed
				positionsByLevels: aPositionsByLevelsMap
				currentLevel: theCurrentLevel + 1.
			leftmostPoint := leftmostPoint min: childBounds x.
			rightmostPoint := rightmostPoint max: childBounds y ].
	^ leftmostPoint @ rightmostPoint
]

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> checkPositionsOfHorizontalSubtrees: theCurrentNode [
	"this method  should make sure that a node is positioned below
	  the bottommost child of its closest sibling"
	| previousChildNodesBottommostChildPoint lastChildPosition lastChildHeight |
	
	previousChildNodesBottommostChildPoint := nil.

	theCurrentNode nodes do: [ :aChildNode |
		previousChildNodesBottommostChildPoint isNotNil
			ifTrue: [ 
				self assert:  previousChildNodesBottommostChildPoint < (aChildNode element position y).
			].
		previousChildNodesBottommostChildPoint := self checkPositionsOfHorizontalSubtrees: aChildNode.
	 ].

	theCurrentNode nodes isEmpty
		ifTrue: [ 
			^ nil	
		].

	lastChildPosition := (theCurrentNode nodes last) element position y.
	lastChildHeight :=  (theCurrentNode nodes last) element bounds extent y.
	^ lastChildPosition + lastChildHeight
	
]

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> checkPositionsOfHorizontalTreesAndNodes: theNodes layout: aTreeLayout [
	| forest previousBottommostPoint previousRootHorizontalPosition |
	forest := self constructForest: theNodes.
	previousBottommostPoint := nil.
	previousRootHorizontalPosition := nil.
	
	forest trees do: [ :aRootNode |
		| bounds |
		previousRootHorizontalPosition isNotNil
			ifTrue: [ 
				self assert: previousRootHorizontalPosition equals: aRootNode element position x.	
			].
		previousRootHorizontalPosition := aRootNode element position x.
		bounds := self checkPositionsAndDistancesBetweenHorizontalTreeNodes: aRootNode
											 				  nodeDistance: aTreeLayout nodeDistance
															  levelDistance: aTreeLayout levelDistance
															  reversed: aTreeLayout reverse
															  positionsByLevels: Dictionary new
				          								  currentLevel: 1.
		previousBottommostPoint isNotNil
			ifTrue: [ 
				self assert: previousBottommostPoint < bounds y	
			].
			previousBottommostPoint := bounds x.

			aTreeLayout separateSubtrees
				ifTrue: [ 
					self checkPositionsOfHorizontalSubtrees: aRootNode
				].
	]
	
]

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> checkPositionsOfVerticalSubtrees: theCurrentNode [
	"this method  should make sure that a node is positioned to the right
	 of the rightmost child of its left sibling"
	| previousChildNodesRightmostChildPoint lastChildPosition lastChildWidth |
	
	previousChildNodesRightmostChildPoint := nil.

	theCurrentNode nodes do: [ :aChildNode |
		previousChildNodesRightmostChildPoint isNotNil
			ifTrue: [ 
				self assert:  previousChildNodesRightmostChildPoint < (aChildNode element position x).
			].
		previousChildNodesRightmostChildPoint := self checkPositionsOfVerticalSubtrees: aChildNode.
	 ].

	theCurrentNode nodes isEmpty
		ifTrue: [ 
			^ nil	
		].

	lastChildPosition := (theCurrentNode nodes last) element position x.
	lastChildWidth :=  (theCurrentNode nodes last) element bounds extent x.
	^ lastChildPosition + lastChildWidth

	
	

]

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> checkPositionsOfVerticalTreesAndNodes: theNodes layout: aTreeLayout [
	| forest previousRightmostPoint previousRootVerticalPosition|
	forest := self constructForest: theNodes.
	previousRightmostPoint := nil.
	previousRootVerticalPosition := nil.

	forest trees
		do: [ :aRootNode | 
			| bounds |
			previousRootVerticalPosition isNotNil
			ifTrue: [ 
				self assert: previousRootVerticalPosition equals: aRootNode element position y.	
			].
			previousRootVerticalPosition := aRootNode element position y.
			bounds := self
					checkPositionsAndDistancesBetweenVerticalTreeNodes: aRootNode
											 nodeDistance: aTreeLayout nodeDistance
							    			 levelDistance: aTreeLayout levelDistance
											 reversed: aTreeLayout reverse
											 positionsByLevels: Dictionary new
											 currentLevel: 1.

			previousRightmostPoint isNotNil
				ifTrue: [ 
					self assert: previousRightmostPoint < bounds y	
				].

			aTreeLayout separateSubtrees
				ifTrue: [ 
					self checkPositionsOfVerticalSubtrees: aRootNode
				].
			
			]
]

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> constructForest: theNodes [
	self subclassResponsibility
]
