Class {
	#name : #GtWardleyMapActionButtonStencil,
	#superclass : #BrStencil,
	#instVars : [
		'icon',
		'label',
		'action',
		'aptitude',
		'model'
	],
	#category : #'GToolkit-WardleyMap-Helpers - Actions'
}

{ #category : #accessing }
GtWardleyMapActionButtonStencil >> action [
	^ action
]

{ #category : #accessing }
GtWardleyMapActionButtonStencil >> action: anObject [
	action := anObject
]

{ #category : #accessing }
GtWardleyMapActionButtonStencil >> aptitude [
	^ aptitude
]

{ #category : #accessing }
GtWardleyMapActionButtonStencil >> aptitude: anObject [
	aptitude := anObject
]

{ #category : #building }
GtWardleyMapActionButtonStencil >> create [
	| aButton |
	aButton := BrButton new.
	icon ifNotNil: [ aButton icon: self icon ].
	label ifNotNil: [ aButton label: self label ].
	action ifNotNil: [ aButton action: self action ].
	aButton aptitude: self newButtonAptitude.
	aButton beTinySize.
	aButton model: self model.
	aButton wardley beDecorator.
	aButton constraintsDo: [ :c |
		c linear vertical alignCenter.
		c linear horizontal alignCenter ].
	^ aButton
]

{ #category : #accessing }
GtWardleyMapActionButtonStencil >> icon [
	^ icon
]

{ #category : #accessing }
GtWardleyMapActionButtonStencil >> icon: anObject [
	icon := anObject
]

{ #category : #accessing }
GtWardleyMapActionButtonStencil >> label [
	^ label
]

{ #category : #accessing }
GtWardleyMapActionButtonStencil >> label: anObject [
	label := anObject
]

{ #category : #accessing }
GtWardleyMapActionButtonStencil >> model [
	^ model
]

{ #category : #accessing }
GtWardleyMapActionButtonStencil >> model: anObject [
	model := anObject
]

{ #category : #private }
GtWardleyMapActionButtonStencil >> newButtonAptitude [
	aptitude ifNotNil: [ :aBlock | ^ aBlock value ].
	icon ifNil: [ 
		^ BrGlamorousButtonWithLabelAptitude new ].
	label ifNil: [ 
		^ BrGlamorousButtonWithIconAptitude new ].
	^ BrGlamorousButtonWithIconAndLabelAptitude new
]