Class {
	#name : #GtWardleyMapEdgeViewModelTypeChanged,
	#superclass : #Announcement,
	#instVars : [
		'edgeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapEdgeViewModelTypeChanged >> edgeViewModel [
	^ edgeViewModel
]

{ #category : #accessing }
GtWardleyMapEdgeViewModelTypeChanged >> edgeViewModel: anObject [
	edgeViewModel := anObject
]
