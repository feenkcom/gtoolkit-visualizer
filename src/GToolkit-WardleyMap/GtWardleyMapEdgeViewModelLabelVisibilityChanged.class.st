Class {
	#name : #GtWardleyMapEdgeViewModelLabelVisibilityChanged,
	#superclass : #Announcement,
	#instVars : [
		'edgeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapEdgeViewModelLabelVisibilityChanged >> edgeViewModel [
	^ edgeViewModel
]

{ #category : #accessing }
GtWardleyMapEdgeViewModelLabelVisibilityChanged >> edgeViewModel: anObject [
	edgeViewModel := anObject
]
