Class {
	#name : #GtGradAbstractTreeLayoutExamples,
	#superclass : #GtGradLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> checkIfAllChildrenHaveTheSameHorizontalPosition: theNodes [
	| forest |
	forest := GtGradDFSTreeForest from: theNodes separateSubtrees: false.
	
	forest trees do: [ :aRootNode |
		self checkIfAllChildrenHaveTheSameHorizontalPositionForTree: aRootNode. 	
	]
	
]

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> checkIfAllChildrenHaveTheSameHorizontalPositionForTree: theCurrentNode [
	| childrenPosition |
	
	childrenPosition := -1.
	theCurrentNode nodes do: [ :aChildNode |
		childrenPosition = -1
			ifTrue: [
				childrenPosition := aChildNode element position x
			]
			ifFalse: [ 
				self assert: aChildNode element position x equals: childrenPosition	
			].
		self checkIfAllChildrenHaveTheSameHorizontalPositionForTree: aChildNode.
	].
]

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> checkIfAllChildrenHaveTheSameVerticalPosition: theNodes [
	| forest |
	forest := GtGradDFSTreeForest from: theNodes separateSubtrees: false.
	
	forest trees do: [ :aRootNode |
		self checkIfAllChildrenHaveTheSameVerticalPositionForTree: aRootNode. 	
	]

]

{ #category : #example }
GtGradAbstractTreeLayoutExamples >> checkIfAllChildrenHaveTheSameVerticalPositionForTree: theCurrentNode [
	| childrenPosition |
	childrenPosition := -1.
	theCurrentNode nodes do: [ :aChildNode |
		childrenPosition = -1
			ifTrue: [
				childrenPosition := aChildNode element position y
			]
			ifFalse: [ 
				self assert: aChildNode element position y equals: childrenPosition	
			].
		self checkIfAllChildrenHaveTheSameVerticalPositionForTree: aChildNode.
	].
]
