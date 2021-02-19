Class {
	#name : #GtWardleyMapEdgeViewModelAdded,
	#superclass : #Announcement,
	#instVars : [
		'edgeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapEdgeViewModelAdded >> edgeViewModel [
	^ edgeViewModel
]

{ #category : #accessing }
GtWardleyMapEdgeViewModelAdded >> edgeViewModel: anObject [
	edgeViewModel := anObject
]
