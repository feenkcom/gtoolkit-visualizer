Class {
	#name : #GtWardleyMapEdgeDecoratorViewModelAdded,
	#superclass : #Announcement,
	#instVars : [
		'edgeViewModel',
		'decoratorViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapEdgeDecoratorViewModelAdded >> decoratorViewModel [
	^ decoratorViewModel
]

{ #category : #accessing }
GtWardleyMapEdgeDecoratorViewModelAdded >> decoratorViewModel: anObject [
	decoratorViewModel := anObject
]

{ #category : #accessing }
GtWardleyMapEdgeDecoratorViewModelAdded >> edgeViewModel [
	^ edgeViewModel
]

{ #category : #accessing }
GtWardleyMapEdgeDecoratorViewModelAdded >> edgeViewModel: anObject [
	edgeViewModel := anObject
]
