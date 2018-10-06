Class {
	#name : #GtGradAbstractTreeLayoutExamples,
	#superclass : #GtGradLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> checkPositionsAndDistancesBetweenHorizontalTreeNodes: theCurrentNode nodeDistance: nodeDistance levelDistance: levelDistance reversed: reversed [
	| previousChildNode previousChildNodePosition currentNodePosition|
	previousChildNode := nil.
	previousChildNodePosition := nil.
	currentNodePosition := theCurrentNode element position.
	theCurrentNode nodes do: [ :aChildNode |
		| currentChildNodePosition |

		currentChildNodePosition := aChildNode element position.
		"check if that positions overlaps with the parent"
		reversed
			ifFalse: [ 
				self assert: currentNodePosition x + levelDistance <= currentChildNodePosition x.
			]
			ifTrue: [ 
				self assert: currentNodePosition x - levelDistance >= currentChildNodePosition x.
			].

		previousChildNode isNotNil
			ifTrue: [ 
				| previousNodeHeight |
				"check if all children have the same y position"
				self assert: previousChildNodePosition x equals: currentChildNodePosition x.
				previousNodeHeight := previousChildNode element bounds extent y.
				"check if the space between nodes is equal to or
				greater than the specified space between nodes"
				self assert: (currentChildNodePosition y  - (previousChildNodePosition y + previousNodeHeight)) >= nodeDistance. 
			].
		previousChildNode := aChildNode.
		previousChildNodePosition := currentChildNodePosition.
		self checkPositionsAndDistancesBetweenHorizontalTreeNodes: aChildNode
															   nodeDistance: nodeDistance
															   levelDistance: levelDistance
																reversed: reversed
	].
]

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> checkPositionsAndDistancesBetweenVerticalTreeNodes: theCurrentNode nodeDistance: nodeDistance levelDistance: levelDistance reversed: reversed [
	| previousChildNode previousChildNodePosition currentNodePosition|
	previousChildNode := nil.
	previousChildNodePosition := nil.
	currentNodePosition := theCurrentNode element position.
	theCurrentNode nodes do: [ :aChildNode |
		| currentChildNodePosition |

		currentChildNodePosition := aChildNode element position.
		"check if that positions overlaps with the parent"
		reversed
			ifFalse: [ 
				self assert: currentNodePosition y + levelDistance <= currentChildNodePosition y.
			]
			ifTrue: [ 
				self assert: currentNodePosition y - levelDistance >= currentChildNodePosition y.
			].

		previousChildNode isNotNil
			ifTrue: [ 
				| previousNodeWidth |
				"check if all children have the same y position"
				self assert: previousChildNodePosition y equals: currentChildNodePosition y.
				previousNodeWidth := previousChildNode element bounds extent x.
				"check if the space between nodes is equal to or
				greater than the specified space between nodes"
				self assert: (currentChildNodePosition x  - (previousChildNodePosition x + previousNodeWidth)) >= nodeDistance. 
			].
		previousChildNode := aChildNode.
		previousChildNodePosition := currentChildNodePosition.
		self checkPositionsAndDistancesBetweenVerticalTreeNodes: aChildNode
															   nodeDistance: nodeDistance
															   levelDistance: levelDistance
																reversed: reversed
	].
]

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> checkPositionsOfHorizontalTreesAndNodes: theNodes layout: aTreeLayout [
	| forest |
	forest := self constructForest: theNodes.
	
	forest trees do: [ :aRootNode |
		self checkPositionsAndDistancesBetweenHorizontalTreeNodes: aRootNode
											 				  nodeDistance: aTreeLayout nodeDistance
															  levelDistance: aTreeLayout levelDistance
															  reversed: aTreeLayout reverse.
	]
	
]

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> checkPositionsOfVerticalTreesAndNodes: theNodes layout: aTreeLayout [
	| forest |
	forest := self constructForest: theNodes.
	forest trees
		do: [ :aRootNode | 
			self
				checkPositionsAndDistancesBetweenVerticalTreeNodes: aRootNode
											 nodeDistance: aTreeLayout nodeDistance
							    			 levelDistance: aTreeLayout levelDistance
											 reversed: aTreeLayout reverse 
	]
]

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> constructForest: theNodes [
	self subclassResponsibility
]
