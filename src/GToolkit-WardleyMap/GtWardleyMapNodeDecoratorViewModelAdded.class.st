Class {
	#name : #GtWardleyMapNodeDecoratorViewModelAdded,
	#superclass : #Announcement,
	#instVars : [
		'nodeViewModel',
		'decoratorViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeDecoratorViewModelAdded >> decoratorViewModel [
	^ decoratorViewModel
]

{ #category : #accessing }
GtWardleyMapNodeDecoratorViewModelAdded >> decoratorViewModel: anObject [
	decoratorViewModel := anObject
]

{ #category : #accessing }
GtWardleyMapNodeDecoratorViewModelAdded >> nodeViewModel [
	^ nodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodeDecoratorViewModelAdded >> nodeViewModel: anObject [
	nodeViewModel := anObject
]
