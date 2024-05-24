Class {
	#name : #GtWardleyMapNodeStyleBuilder,
	#superclass : #Object,
	#instVars : [
		'element',
		'viewModel'
	],
	#category : #'GToolkit-WardleyMap-Helpers - Node Type'
}

{ #category : #factory }
GtWardleyMapNodeStyleBuilder class >> forElement: anElement [
	| aViewModel |
	aViewModel := anElement wardleyMapNodeViewModel.
	aViewModel isEvolveTargetType
		ifTrue: [ ^ GtWardleyMapNodeEvolveStyleBuilder new
				element: anElement;
				viewModel: aViewModel ]
		ifFalse: [ ^ GtWardleyMapNodeRegularStyleBuilder new
				element: anElement;
				viewModel: aViewModel ]
]

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
