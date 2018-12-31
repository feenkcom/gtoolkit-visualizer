Class {
	#name : #GtGradSouthHierarchicalLayoutExamples,
	#superclass : #GtGradHierarchicalLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #examples }
GtGradSouthHierarchicalLayoutExamples >> layout [
	^ GtGradSouthHierarchicalLayout new
]

{ #category : #examples }
GtGradSouthHierarchicalLayoutExamples >> simpleExample [
	<gtExample>
	^ super simpleExample
]

{ #category : #examples }
GtGradSouthHierarchicalLayoutExamples >> simpleExampleDsiconnectedGraph [
	<gtExample>
	^ super simpleExampleDsiconnectedGraph
]

{ #category : #examples }
GtGradSouthHierarchicalLayoutExamples >> simpleExampleWhereAllNodesHaveIncomingEdges [
	<gtExample>
	^ super simpleExampleWhereAllNodesHaveIncomingEdges
]
