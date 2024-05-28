Class {
	#name : #GtWardleyMapEdgeViewModelLabelMoved,
	#superclass : #Announcement,
	#instVars : [
		'edgeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapEdgeViewModelLabelMoved >> edgeViewModel [
	^ edgeViewModel
]

{ #category : #accessing }
GtWardleyMapEdgeViewModelLabelMoved >> edgeViewModel: anObject [
	edgeViewModel := anObject
]
