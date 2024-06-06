Class {
	#name : #GtWardleyMapEvolveViewModelRemoved,
	#superclass : #Announcement,
	#instVars : [
		'evolveViewModel',
		'evolveEdgeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapEvolveViewModelRemoved >> evolveEdgeViewModel [
	^ evolveEdgeViewModel
]

{ #category : #accessing }
GtWardleyMapEvolveViewModelRemoved >> evolveEdgeViewModel: anObject [
	evolveEdgeViewModel := anObject
]

{ #category : #accessing }
GtWardleyMapEvolveViewModelRemoved >> evolveViewModel [
	^ evolveViewModel
]

{ #category : #accessing }
GtWardleyMapEvolveViewModelRemoved >> evolveViewModel: anObject [
	evolveViewModel := anObject
]
