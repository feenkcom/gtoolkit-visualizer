Class {
	#name : #GtWardleyMapEdgeViewModelLabelTextChanged,
	#superclass : #Announcement,
	#instVars : [
		'edgeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapEdgeViewModelLabelTextChanged >> edgeViewModel [
	^ edgeViewModel
]

{ #category : #accessing }
GtWardleyMapEdgeViewModelLabelTextChanged >> edgeViewModel: anObject [
	edgeViewModel := anObject
]
