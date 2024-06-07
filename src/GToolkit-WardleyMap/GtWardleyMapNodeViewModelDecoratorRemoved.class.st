Class {
	#name : #GtWardleyMapNodeViewModelDecoratorRemoved,
	#superclass : #Announcement,
	#instVars : [
		'nodeViewModel',
		'decorator'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeViewModelDecoratorRemoved >> decorator [
	^ decorator
]

{ #category : #accessing }
GtWardleyMapNodeViewModelDecoratorRemoved >> decorator: anObject [
	decorator := anObject
]

{ #category : #accessing }
GtWardleyMapNodeViewModelDecoratorRemoved >> nodeViewModel [
	^ nodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodeViewModelDecoratorRemoved >> nodeViewModel: anObject [
	nodeViewModel := anObject
]
