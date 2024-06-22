Class {
	#name : #GtWardleyMapNodeDecoratorContext,
	#superclass : #GtWardleyMapDecoratorContext,
	#instVars : [
		'nodeViewModel',
		'nodeElement'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #accessing }
GtWardleyMapNodeDecoratorContext >> labelContainerDo: aBlock [
	self nodeElement labelContainerDo: aBlock
]

{ #category : #accessing }
GtWardleyMapNodeDecoratorContext >> nodeElement [
	^ nodeElement
]

{ #category : #accessing }
GtWardleyMapNodeDecoratorContext >> nodeElement: anObject [
	nodeElement := anObject
]

{ #category : #accessing }
GtWardleyMapNodeDecoratorContext >> nodeViewModel [
	^ nodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodeDecoratorContext >> nodeViewModel: anObject [
	nodeViewModel := anObject
]
