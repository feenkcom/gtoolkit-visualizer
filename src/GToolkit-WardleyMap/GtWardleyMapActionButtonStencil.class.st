Class {
	#name : #GtWardleyMapActionButtonStencil,
	#superclass : #BrStencil,
	#instVars : [
		'icon',
		'label',
		'action',
		'aptitude',
		'model',
		'tooltip',
		'buttonClass',
		'elementId'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
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

{ #category : #accessing }
GtWardleyMapActionButtonStencil >> buttonClass [
	^ buttonClass ifNil: [ buttonClass := BrButton ]
]

{ #category : #accessing }
GtWardleyMapActionButtonStencil >> buttonClass: aButtonClass [
	buttonClass := aButtonClass
]

{ #category : #building }
GtWardleyMapActionButtonStencil >> create [
	| aButton |
	aButton := self buttonClass new.
	elementId ifNotNil: [ aButton id: self elementId ].
	icon ifNotNil: [ aButton icon: self icon ].
	tooltip ifNotNil: [ aButton label: self tooltip ].
	label ifNotNil: [ aButton label: self label ].
	action ifNotNil: [ aButton action: self action ].
	aButton margin: (BlInsets left: 2).
	aButton aptitude: self newButtonAptitude.
	aButton beTinySize.
	aButton model: self model.
	aButton wardley beDecorator.
	aButton margin: (BlInsets left: 2).
	aButton constraintsDo: [ :c |
		c linear vertical alignCenter.
		c linear horizontal alignCenter ].
	^ aButton
]

{ #category : #accessing }
GtWardleyMapActionButtonStencil >> elementId [
	<return: #BlElementId or: nil>
	^ elementId
]

{ #category : #accessing }
GtWardleyMapActionButtonStencil >> elementId: anObject [
	elementId := anObject
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
	icon
		ifNil: [ tooltip
				ifNil: [ ^ BrGlamorousButtonWithLabelAptitude new ]
				ifNotNil: [ ^ BrGlamorousButtonWithLabelAptitude new
						+ (BrGlamorousWithExplicitTooltipAptitude text: tooltip) ] ].
	label ifNil: [ ^ BrGlamorousButtonWithIconAptitude new ].
	tooltip
		ifNotNil: [ ^ BrGlamorousButtonWithIconAndLabelAptitude new
				+ (BrGlamorousWithExplicitTooltipAptitude text: tooltip) ].
	^ BrGlamorousButtonWithIconAndLabelAptitude new
]

{ #category : #accessing }
GtWardleyMapActionButtonStencil >> tooltip [
	^ tooltip
]

{ #category : #accessing }
GtWardleyMapActionButtonStencil >> tooltip: anObject [
	tooltip := anObject
]
