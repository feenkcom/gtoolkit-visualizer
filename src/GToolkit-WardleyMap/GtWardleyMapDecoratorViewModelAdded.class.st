Class {
	#name : #GtWardleyMapDecoratorViewModelAdded,
	#superclass : #Announcement,
	#instVars : [
		'decoratorViewModel',
		'mapViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapDecoratorViewModelAdded >> decoratorViewModel [
	^ decoratorViewModel
]

{ #category : #accessing }
GtWardleyMapDecoratorViewModelAdded >> decoratorViewModel: anObject [
	decoratorViewModel := anObject
]

{ #category : #accessing }
GtWardleyMapDecoratorViewModelAdded >> mapViewModel [
	^ mapViewModel
]

{ #category : #accessing }
GtWardleyMapDecoratorViewModelAdded >> mapViewModel: anObject [
	mapViewModel := anObject
]
