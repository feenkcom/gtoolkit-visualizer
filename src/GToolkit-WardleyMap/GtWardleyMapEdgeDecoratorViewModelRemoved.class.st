Class {
	#name : #GtWardleyMapEdgeDecoratorViewModelRemoved,
	#superclass : #Announcement,
	#instVars : [
		'edgeViewModel',
		'decoratorViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapEdgeDecoratorViewModelRemoved >> decoratorViewModel [
	^ decoratorViewModel
]

{ #category : #accessing }
GtWardleyMapEdgeDecoratorViewModelRemoved >> decoratorViewModel: anObject [
	decoratorViewModel := anObject
]

{ #category : #accessing }
GtWardleyMapEdgeDecoratorViewModelRemoved >> edgeViewModel [
	^ edgeViewModel
]

{ #category : #accessing }
GtWardleyMapEdgeDecoratorViewModelRemoved >> edgeViewModel: anObject [
	edgeViewModel := anObject
]
