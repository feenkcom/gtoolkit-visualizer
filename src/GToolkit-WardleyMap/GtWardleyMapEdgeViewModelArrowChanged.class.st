Class {
	#name : #GtWardleyMapEdgeViewModelArrowChanged,
	#superclass : #Announcement,
	#instVars : [
		'edgeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapEdgeViewModelArrowChanged >> edgeViewModel [
	^ edgeViewModel
]

{ #category : #accessing }
GtWardleyMapEdgeViewModelArrowChanged >> edgeViewModel: anObject [
	edgeViewModel := anObject
]
