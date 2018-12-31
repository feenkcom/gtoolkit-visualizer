Class {
	#name : #GtGradNorthHierarchicalLayoutExamples,
	#superclass : #GtGradHierarchicalLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #examples }
GtGradNorthHierarchicalLayoutExamples >> layout [
	^ GtGradNorthHierarchicalLayout new
]

{ #category : #examples }
GtGradNorthHierarchicalLayoutExamples >> simpleExample [
	<gtExample>
	^ super simpleExample
]

{ #category : #examples }
GtGradNorthHierarchicalLayoutExamples >> simpleExampleDsiconnectedGraph [
	<gtExample>
	^ super simpleExampleDsiconnectedGraph
]

{ #category : #examples }
GtGradNorthHierarchicalLayoutExamples >> simpleExampleWhereAllNodesHaveIncomingEdges [
	<gtExample>
	^ super simpleExampleWhereAllNodesHaveIncomingEdges
]
