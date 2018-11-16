Class {
	#name : #GtGradHierarchyEdge,
	#superclass : #GtGradHierarchyElement,
	#instVars : [
		'source',
		'target',
		'reversed'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #calculating }
GtGradHierarchyEdge >> invert [
	| temp |
	temp := self source.
	self source: self target.
	self target: temp.
	self reversed: (self reversed) negated.
]

{ #category : #accessing }
GtGradHierarchyEdge >> positionOnLayer: layer [
	^ self positionsPerLayer at: (layer - minRank -1)
]

{ #category : #accessing }
GtGradHierarchyEdge >> positionOnLayer: layer position: position [
	self positionsPerLayer at: (layer - minRank -1) put: position.
]

{ #category : #accessing }
GtGradHierarchyEdge >> reversed [
	^ reversed
]

{ #category : #accessing }
GtGradHierarchyEdge >> reversed: anObject [
	reversed := anObject
]

{ #category : #accessing }
GtGradHierarchyEdge >> source [
	^ source
]

{ #category : #accessing }
GtGradHierarchyEdge >> source: anObject [
	source := anObject
]

{ #category : #accessing }
GtGradHierarchyEdge >> target [
	^ target
]

{ #category : #accessing }
GtGradHierarchyEdge >> target: anObject [
	target := anObject
]
