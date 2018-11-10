Class {
	#name : #GtGradHierarchicalConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'computedPosition'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #accessing }
GtGradHierarchicalConstraints >> computedPosition [
	^ computedPosition
]

{ #category : #accessing }
GtGradHierarchicalConstraints >> computedPosition: anObject [
	computedPosition := anObject
]
