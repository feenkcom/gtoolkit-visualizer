Class {
	#name : #GtGradHorizontalDominanceCenteredTreeLayoutExamples,
	#superclass : #GtGradDominanceCenteredTreeLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'example - instance creation' }
GtGradHorizontalDominanceCenteredTreeLayoutExamples >> centeredDominanceTreeLayout [
	<gtExample>
	|  aTreeLayout |

	aTreeLayout := GtGradHorizontalDominanceCenteredTreeLayout new.
	self assert: aTreeLayout levelDistance equals: 10.
	self assert: aTreeLayout nodeDistance equals: 1.

	^ aTreeLayout
]

{ #category : #'example - instance creation' }
GtGradHorizontalDominanceCenteredTreeLayoutExamples >> getNodeLevelConstantAxisDimension: aTreeNode [
	^ aTreeNode element measuredBounds extent x.
	
]

{ #category : #'example - instance creation' }
GtGradHorizontalDominanceCenteredTreeLayoutExamples >> getNodeLevelConstantPosition: aTreeNode [
	^ aTreeNode element position x
	
]

{ #category : #'example - instance creation' }
GtGradHorizontalDominanceCenteredTreeLayoutExamples >> getNodeLevelVariableAxisDimension: aTreeNode [
	^ aTreeNode element measuredBounds extent  y.
	
]

{ #category : #'example - instance creation' }
GtGradHorizontalDominanceCenteredTreeLayoutExamples >> getNodeLevelVariablePosition: aTreeNode [
	^ aTreeNode element position y

]

{ #category : #example }
GtGradHorizontalDominanceCenteredTreeLayoutExamples >> graphWithANodeWithSeveralIncomingEdges [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view.
	aTreeLayout := self centeredDominanceTreeLayout.
	theNodes := self constructGraphWithANodeWithSeveralIncomingEdges key.
	view addChildren: theNodes.
	view layout: aTreeLayout.
	view forceLayout.
	
	self checkPositionsOfTreesAndNodes:	theNodes layout: aTreeLayout.

	^ view
]

{ #category : #example }
GtGradHorizontalDominanceCenteredTreeLayoutExamples >> moreComplexGraphWithANodeWithSeveralIncomingEdges [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view.
	aTreeLayout := self centeredDominanceTreeLayout.
	theNodes := self constructMoreComplexGraphWithANodeWithSeveralIncomingEdges key.
	view addChildren: theNodes.
	view layout: aTreeLayout.
	view forceLayout.
	
	self checkPositionsOfTreesAndNodes:	theNodes layout: aTreeLayout.

	^ view
]

{ #category : #'example - instance creation' }
GtGradHorizontalDominanceCenteredTreeLayoutExamples >> nodeMaximumPoint: aTreeNode [
	^ aTreeNode element position y + aTreeNode element measuredBounds extent y.
]

{ #category : #'example - instance creation' }
GtGradHorizontalDominanceCenteredTreeLayoutExamples >> nodeMinimumPoint: aTreeNode [
	^ aTreeNode element position y
]

{ #category : #example }
GtGradHorizontalDominanceCenteredTreeLayoutExamples >> treeWithEdgesWhoseSoucesAreOnDifferentLevels [
	<gtExample>
		
	| view theNodes aTreeLayout |
	
	view := self view.
	aTreeLayout := self centeredDominanceTreeLayout.
	theNodes := self construcTreeWithEdgesWhoseSoucesAreOnDifferentLevels key.
	view addChildren: theNodes.
	view layout: aTreeLayout.
	view forceLayout.
	
	self checkPositionsOfTreesAndNodes:	theNodes layout: aTreeLayout.

	^ view
]
