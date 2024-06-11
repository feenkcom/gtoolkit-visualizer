Class {
	#name : #GtWardleyMapLinkButtonStencil,
	#superclass : #BrStencil,
	#instVars : [
		'icon',
		'label',
		'action',
		'aptitude',
		'model',
		'tooltip'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #accessing }
GtWardleyMapLinkButtonStencil >> action [
	^ action
]

{ #category : #accessing }
GtWardleyMapLinkButtonStencil >> action: anObject [
	action := anObject
]

{ #category : #accessing }
GtWardleyMapLinkButtonStencil >> aptitude [
	^ aptitude
]

{ #category : #accessing }
GtWardleyMapLinkButtonStencil >> aptitude: anObject [
	aptitude := anObject
]

{ #category : #building }
GtWardleyMapLinkButtonStencil >> create [
	| aButton |
	aButton := BrButton new.
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
GtWardleyMapLinkButtonStencil >> icon [
	^ icon
]

{ #category : #accessing }
GtWardleyMapLinkButtonStencil >> icon: anObject [
	icon := anObject
]

{ #category : #accessing }
GtWardleyMapLinkButtonStencil >> label [
	^ label
]

{ #category : #accessing }
GtWardleyMapLinkButtonStencil >> label: anObject [
	label := anObject
]

{ #category : #accessing }
GtWardleyMapLinkButtonStencil >> model [
	^ model
]

{ #category : #accessing }
GtWardleyMapLinkButtonStencil >> model: anObject [
	model := anObject
]

{ #category : #private }
GtWardleyMapLinkButtonStencil >> newButtonAptitude [
	aptitude ifNotNil: [ :aBlock | ^ aBlock value ].
	icon ifNil: [ 
		tooltip
			ifNil: [ ^ BrGlamorousButtonWithLabelAptitude new underline
				- BrGlamorousButtonExteriorAptitude ]
			ifNotNil: [ ^ BrGlamorousButtonWithLabelAptitude new underline 
				- BrGlamorousButtonExteriorAptitude
				+ (BrGlamorousWithLabelTooltipAptitude new text: tooltip) ] ].
	label ifNil: [ 
		^ BrGlamorousButtonWithIconAptitude new ].
	tooltip ifNotNil: [  
		^ BrGlamorousButtonWithIconAndLabelAptitude new underline
			- BrGlamorousButtonExteriorAptitude
			+ (BrGlamorousWithLabelTooltipAptitude new text: tooltip) ].
	^ BrGlamorousButtonWithIconAndLabelAptitude new underline
		- BrGlamorousButtonExteriorAptitude
]

{ #category : #accessing }
GtWardleyMapLinkButtonStencil >> tooltip [
	^ tooltip
]

{ #category : #accessing }
GtWardleyMapLinkButtonStencil >> tooltip: anObject [
	tooltip := anObject
]
