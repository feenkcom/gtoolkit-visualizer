Class {
	#name : #GtGradEastHierarchicalLayoutExamples,
	#superclass : #GtGradHierarchicalLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #examples }
GtGradEastHierarchicalLayoutExamples >> layout [
	^ GtGradEastHierarchicalLayout new
]

{ #category : #examples }
GtGradEastHierarchicalLayoutExamples >> simpleExample [
	<gtExample>
	^ super simpleExample
]

{ #category : #examples }
GtGradEastHierarchicalLayoutExamples >> simpleExampleDsiconnectedGraph [
	<gtExample>
	^ super simpleExampleDsiconnectedGraph
]

{ #category : #examples }
GtGradEastHierarchicalLayoutExamples >> simpleExampleWhereAllNodesHaveIncomingEdges [
	<gtExample>
	^ super simpleExampleWhereAllNodesHaveIncomingEdges
]
