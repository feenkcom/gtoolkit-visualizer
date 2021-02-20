Class {
	#name : #GtWardleyMapEdgeViewModelRemoved,
	#superclass : #Announcement,
	#instVars : [
		'edgeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapEdgeViewModelRemoved >> edgeViewModel [
	^ edgeViewModel
]

{ #category : #accessing }
GtWardleyMapEdgeViewModelRemoved >> edgeViewModel: anObject [
	edgeViewModel := anObject
]
