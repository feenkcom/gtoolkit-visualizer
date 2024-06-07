Class {
	#name : #GtWardleyMapNodeDecoratorViewModelRemoved,
	#superclass : #Announcement,
	#instVars : [
		'nodeViewModel',
		'decoratorViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeDecoratorViewModelRemoved >> decoratorViewModel [
	^ decoratorViewModel
]

{ #category : #accessing }
GtWardleyMapNodeDecoratorViewModelRemoved >> decoratorViewModel: anObject [
	decoratorViewModel := anObject
]

{ #category : #accessing }
GtWardleyMapNodeDecoratorViewModelRemoved >> nodeViewModel [
	^ nodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodeDecoratorViewModelRemoved >> nodeViewModel: anObject [
	nodeViewModel := anObject
]
