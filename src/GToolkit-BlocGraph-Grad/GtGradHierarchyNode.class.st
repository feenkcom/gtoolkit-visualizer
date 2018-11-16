Class {
	#name : #GtGradHierarchyNode,
	#superclass : #GtGradHierarchyElement,
	#instVars : [
		'incomingEdges',
		'outgoingEdges'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #accessing }
GtGradHierarchyNode >> incomingEdges [
	^ incomingEdges
]

{ #category : #accessing }
GtGradHierarchyNode >> incomingEdges: anObject [
	incomingEdges := anObject
]

{ #category : #accessing }
GtGradHierarchyNode >> outgoingEdges [
	^ outgoingEdges
]

{ #category : #accessing }
GtGradHierarchyNode >> outgoingEdges: anObject [
	outgoingEdges := anObject
]

{ #category : #accessing }
GtGradHierarchyNode >> positionOnLayer: layer [
	^ self positionsPerLayer at: layer
]

{ #category : #accessing }
GtGradHierarchyNode >> positionOnLayer: layer position: position [
	self positionsPerLayer at: layer put: position
]
