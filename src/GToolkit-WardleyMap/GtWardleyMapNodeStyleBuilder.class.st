Class {
	#name : #GtWardleyMapNodeStyleBuilder,
	#superclass : #Object,
	#instVars : [
		'element',
		'viewModel'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #accessing }
GtWardleyMapNodeStyleBuilder >> element [
	^ element
]

{ #category : #accessing }
GtWardleyMapNodeStyleBuilder >> element: anObject [
	element := anObject
]

{ #category : #'api - hooks' }
GtWardleyMapNodeStyleBuilder >> onHovered [
]

{ #category : #'api - hooks' }
GtWardleyMapNodeStyleBuilder >> onNodeColored [
]

{ #category : #'api - hooks' }
GtWardleyMapNodeStyleBuilder >> onUnhovered [
	self onNodeColored
]

{ #category : #accessing }
GtWardleyMapNodeStyleBuilder >> viewModel [
	^ viewModel
]

{ #category : #accessing }
GtWardleyMapNodeStyleBuilder >> viewModel: anObject [
	viewModel := anObject
]
