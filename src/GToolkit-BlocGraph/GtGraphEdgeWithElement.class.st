Class {
	#name : #GtGraphEdgeWithElement,
	#superclass : #GtGraphEdge,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-BlocGraph-Core'
}

{ #category : #accessing }
GtGraphEdgeWithElement >> element [
	^ element
]

{ #category : #accessing }
GtGraphEdgeWithElement >> element: anObject [
	element := anObject
]
