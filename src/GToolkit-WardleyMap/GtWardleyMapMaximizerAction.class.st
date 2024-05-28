Class {
	#name : #GtWardleyMapMaximizerAction,
	#superclass : #Object,
	#traits : 'TGtWardleyMapDecorator',
	#classTraits : 'TGtWardleyMapDecorator classTrait',
	#instVars : [
		'label',
		'icon',
		'stencil',
		'aptitude',
		'model',
		'preferredBackground'
	],
	#category : #'GToolkit-WardleyMap-Helpers - Actions'
}

{ #category : #accessing }
GtWardleyMapMaximizerAction >> aptitude [
	^ aptitude
]

{ #category : #'api - decoration' }
GtWardleyMapMaximizerAction >> aptitude: aBlock [
	aptitude := aBlock
]

{ #category : #'api - decoration' }
GtWardleyMapMaximizerAction >> decorateNodeElement: aNodeElement [
	aNodeElement labelContainerDo: [ :aContainer | 
		aContainer addChild: self newButton ]
]

{ #category : #accessing }
GtWardleyMapMaximizerAction >> icon [
	^ icon
]

{ #category : #accessing }
GtWardleyMapMaximizerAction >> icon: anObject [
	icon := anObject
]

{ #category : #accessing }
GtWardleyMapMaximizerAction >> label [
	^ label
]

{ #category : #accessing }
GtWardleyMapMaximizerAction >> label: anObject [
	label := anObject
]

{ #category : #accessing }
GtWardleyMapMaximizerAction >> model [
	^ model
]

{ #category : #accessing }
GtWardleyMapMaximizerAction >> model: anObject [
	model := anObject
]

{ #category : #private }
GtWardleyMapMaximizerAction >> newButton [
	^ GtWardleyMapActionButtonStencil new
		icon: self icon;
		label: self label;
		aptitude: self aptitude;
		action: [ :aButton | self onMaximizeFrom: aButton ];
		model: self model;
		asElement
]

{ #category : #private }
GtWardleyMapMaximizerAction >> newContainerInButton: aButton [
	| aContainer aChild anAptitude |
	aChild := self stencil asElement.
	aChild id: GtWardleyMapMaximizerId.
	
	anAptitude := BrGlamorousWithMaximizerAptitude new.
	anAptitude hideMaximizeButton.
	anAptitude / GtWardleyMapMaximizerId.
	self preferredBackground ifNotNil: [ :aBackground | 
		anAptitude preferredBackground: aBackground ].

	aContainer := BlElement new
			visibility: BlVisibility gone;
			addChild: aChild;
			aptitude: anAptitude.

	aButton addChild: aContainer.

	^ aContainer
]

{ #category : #'event handling' }
GtWardleyMapMaximizerAction >> onMaximizeFrom: aButton [ 
	| aContainer |
	aContainer := aButton userData 
		at: self
		ifPresent: [ :theContainerData | theContainerData ] 
		ifAbsentPut: [ self newContainerInButton: aButton ].
		
	aContainer aptitude maximize
]

{ #category : #initialization }
GtWardleyMapMaximizerAction >> parent: aParent [
	self model: aParent
]

{ #category : #accessing }
GtWardleyMapMaximizerAction >> preferredBackground [
	^ preferredBackground ifNil: [ preferredBackground := BrGlamorousColors backdropColor ]
]

{ #category : #accessing }
GtWardleyMapMaximizerAction >> preferredBackground: anObject [
	preferredBackground := anObject
]

{ #category : #accessing }
GtWardleyMapMaximizerAction >> stencil [
	^ stencil
]

{ #category : #accessing }
GtWardleyMapMaximizerAction >> stencil: aStencil [
	stencil := aStencil asStencil
]
