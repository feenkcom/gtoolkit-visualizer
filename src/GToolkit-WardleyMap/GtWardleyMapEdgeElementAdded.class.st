Class {
	#name : #GtWardleyMapEdgeElementAdded,
	#superclass : #BlEvent,
	#instVars : [
		'edgeElement',
		'edgeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapEdgeElementAdded >> edgeElement [
	^ edgeElement
]

{ #category : #accessing }
GtWardleyMapEdgeElementAdded >> edgeElement: anObject [
	edgeElement := anObject
]

{ #category : #accessing }
GtWardleyMapEdgeElementAdded >> edgeViewModel [
	^ edgeViewModel
]

{ #category : #accessing }
GtWardleyMapEdgeElementAdded >> edgeViewModel: anObject [
	edgeViewModel := anObject
]
