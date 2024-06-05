Class {
	#name : #GtWardleyMapEvolveViewModelAdded,
	#superclass : #Announcement,
	#instVars : [
		'evolveViewModel',
		'evolveEdgeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapEvolveViewModelAdded >> evolveEdgeViewModel [
	^ evolveEdgeViewModel
]

{ #category : #accessing }
GtWardleyMapEvolveViewModelAdded >> evolveEdgeViewModel: anObject [
	evolveEdgeViewModel := anObject
]

{ #category : #accessing }
GtWardleyMapEvolveViewModelAdded >> evolveViewModel [
	^ evolveViewModel
]

{ #category : #accessing }
GtWardleyMapEvolveViewModelAdded >> evolveViewModel: anObject [
	evolveViewModel := anObject
]
