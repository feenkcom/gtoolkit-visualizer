Class {
	#name : #GtGradWestHierarchicalLayoutExamples,
	#superclass : #GtGradHierarchicalLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #examples }
GtGradWestHierarchicalLayoutExamples >> layout [
	^ GtGradWestHierarchicalLayout new
]

{ #category : #examples }
GtGradWestHierarchicalLayoutExamples >> simpleExample [
	<gtExample>
	^ super simpleExample
]

{ #category : #examples }
GtGradWestHierarchicalLayoutExamples >> simpleExampleDsiconnectedGraph [
	<gtExample>
	^ super simpleExampleDsiconnectedGraph
]

{ #category : #examples }
GtGradWestHierarchicalLayoutExamples >> simpleExampleWhereAllNodesHaveIncomingEdges [
	<gtExample>
	^ super simpleExampleWhereAllNodesHaveIncomingEdges
]
