Class {
	#name : #GtWardleyMapDecoratorViewModelRemoved,
	#superclass : #Announcement,
	#instVars : [
		'mapViewModel',
		'decoratorViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapDecoratorViewModelRemoved >> decoratorViewModel [
	^ decoratorViewModel
]

{ #category : #accessing }
GtWardleyMapDecoratorViewModelRemoved >> decoratorViewModel: anObject [
	decoratorViewModel := anObject
]

{ #category : #accessing }
GtWardleyMapDecoratorViewModelRemoved >> mapViewModel [
	^ mapViewModel
]

{ #category : #accessing }
GtWardleyMapDecoratorViewModelRemoved >> mapViewModel: anObject [
	mapViewModel := anObject
]
