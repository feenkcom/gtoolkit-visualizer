Class {
	#name : #GtWardleyMapAction,
	#superclass : #Object,
	#traits : 'TGtWardleyMapDecorator',
	#classTraits : 'TGtWardleyMapDecorator classTrait',
	#instVars : [
		'label',
		'icon',
		'action',
		'aptitude',
		'model'
	],
	#category : #'GToolkit-WardleyMap-Helpers - Actions'
}

{ #category : #accessing }
GtWardleyMapAction >> action [
	^ action
]

{ #category : #accessing }
GtWardleyMapAction >> action: anObject [
	action := anObject
]

{ #category : #accessing }
GtWardleyMapAction >> aptitude [
	^ aptitude
]

{ #category : #'api - decoration' }
GtWardleyMapAction >> aptitude: aBlock [
	aptitude := aBlock
]

{ #category : #'api - decoration' }
GtWardleyMapAction >> decorateNodeElement: aNodeElement [
	aNodeElement labelContainerDo: [ :aContainer | 
		aContainer addChild: self newButton ]
]

{ #category : #accessing }
GtWardleyMapAction >> icon [
	^ icon
]

{ #category : #accessing }
GtWardleyMapAction >> icon: anObject [
	icon := anObject
]

{ #category : #accessing }
GtWardleyMapAction >> label [
	^ label
]

{ #category : #accessing }
GtWardleyMapAction >> label: anObject [
	label := anObject
]

{ #category : #accessing }
GtWardleyMapAction >> model [
	^ model
]

{ #category : #accessing }
GtWardleyMapAction >> model: anObject [
	model := anObject
]

{ #category : #'api - decoration' }
GtWardleyMapAction >> newButton [
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

{ #category : #'api - decoration' }
GtWardleyMapAction >> newButtonAptitude [
	aptitude ifNotNil: [ :aBlock | ^ aBlock value ].
	icon isNil ifTrue: [ 
		^ BrGlamorousButtonWithLabelAptitude new ].
	label ifNil: [ 
		^ BrGlamorousButtonWithIconAptitude new ].
	^ BrGlamorousButtonWithIconAndLabelAptitude new
]

{ #category : #initialization }
GtWardleyMapAction >> parent: aParent [
	self model: aParent
]
