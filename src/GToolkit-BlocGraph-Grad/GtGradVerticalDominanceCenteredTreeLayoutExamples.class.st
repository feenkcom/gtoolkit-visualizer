Class {
	#name : #GtGradVerticalDominanceCenteredTreeLayoutExamples,
	#superclass : #GtGradDominanceCenteredTreeLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'example - instance creation' }
GtGradVerticalDominanceCenteredTreeLayoutExamples >> centeredDominanceTreeLayout [
	<gtExample>
	|  aTreeLayout |

	aTreeLayout := GtGradVerticalDominanceCenteredTreeLayout new.
	self assert: aTreeLayout levelDistance equals: 10.
	self assert: aTreeLayout nodeDistance equals: 1.

	^ aTreeLayout
]

{ #category : #accessing }
GtGradVerticalDominanceCenteredTreeLayoutExamples >> getNodeLevelConstantAxisDimension: aTreeNode [
	^ aTreeNode element measuredBounds extent y
]

{ #category : #accessing }
GtGradVerticalDominanceCenteredTreeLayoutExamples >> getNodeLevelConstantPosition: aTreeNode [
	^ aTreeNode element position y
	
]

{ #category : #accessing }
GtGradVerticalDominanceCenteredTreeLayoutExamples >> getNodeLevelVariableAxisDimension: aTreeNode [
	^ aTreeNode element measuredBounds extent  x.
	
]

{ #category : #accessing }
GtGradVerticalDominanceCenteredTreeLayoutExamples >> getNodeLevelVariablePosition: aTreeNode [
	^ aTreeNode element position x

]

{ #category : #example }
GtGradVerticalDominanceCenteredTreeLayoutExamples >> graphWithANodeWithSeveralIncomingEdges [
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
GtGradVerticalDominanceCenteredTreeLayoutExamples >> moreComplexGraphWithANodeWithSeveralIncomingEdges [
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

{ #category : #accessing }
GtGradVerticalDominanceCenteredTreeLayoutExamples >> nodeMaximumPoint: aTreeNode [
	^ aTreeNode element position x + aTreeNode element measuredBounds extent x.
]

{ #category : #accessing }
GtGradVerticalDominanceCenteredTreeLayoutExamples >> nodeMinimumPoint: aTreeNode [
	^ aTreeNode element position x
]

{ #category : #example }
GtGradVerticalDominanceCenteredTreeLayoutExamples >> treeWithEdgesWhoseSoucesAreOnDifferentLevels [
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
