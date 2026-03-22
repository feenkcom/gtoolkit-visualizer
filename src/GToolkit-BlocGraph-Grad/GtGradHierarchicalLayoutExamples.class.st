Class {
	#name : #GtGradHierarchicalLayoutExamples,
	#superclass : #GtGradLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'examples - layout' }
GtGradHierarchicalLayoutExamples >> allNodesHaveIncomingEdges [
	^ self subclassResponsibility
]

{ #category : #'examples - instance creation' }
GtGradHierarchicalLayoutExamples >> createDisconnectedGraph [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	^ self
		createGraph: 7
		pairs: {1 -> 2.
				2 -> 3.
				3 -> 4.
				5 -> 6.
				6 -> 7}
]

{ #category : #'examples - instance creation' }
GtGradHierarchicalLayoutExamples >> createGraphWithAllMultipleRanks [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	^ self
		createGraph: 5
		pairs: {1 -> 2.
				2 -> 3.
				3 -> 4.
				4 -> 5.
				4 -> 2.
				1 -> 5.
				2 -> 5.
				4 -> 1}
]

{ #category : #'examples - instance creation' }
GtGradHierarchicalLayoutExamples >> createGraphWithAllNodesHaveIncomingEdges [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	^ self
		createGraph: 5
		pairs: {1 -> 2.
				2 -> 3.
				3 -> 4.
				4 -> 5.
				4 -> 2.
				1 -> 5.
				2 -> 5.
				4 -> 1}
]

{ #category : #'examples - instance creation' }
GtGradHierarchicalLayoutExamples >> createSimpleGraph [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	^ self
		createGraph: 7
		pairs: {1 -> 2.
				2 -> 3.
				3 -> 4.
				2 -> 5.
				5 -> 6.
				6 -> 7.
				7 -> 3}
]

{ #category : #'examples - layout' }
GtGradHierarchicalLayoutExamples >> disconnectedGraph [
	^ self subclassResponsibility
]

{ #category : #'examples - layout' }
GtGradHierarchicalLayoutExamples >> disconnectedGraphIncreasedInterHierarchySpacing [
	^ self subclassResponsibility
]

{ #category : #'examples - layout' }
GtGradHierarchicalLayoutExamples >> graphWithIncreasedInterRanksSpacing [
	^ self subclassResponsibility
]

{ #category : #'examples - layout' }
GtGradHierarchicalLayoutExamples >> graphWithIncreasedIntraRankSpacing [
	^ self subclassResponsibility
]

{ #category : #'examples - instance creation' }
GtGradHierarchicalLayoutExamples >> layout [
	self subclassResponsibility
]

{ #category : #'examples - layout' }
GtGradHierarchicalLayoutExamples >> simpleGraph [
	^ self subclassResponsibility
]
