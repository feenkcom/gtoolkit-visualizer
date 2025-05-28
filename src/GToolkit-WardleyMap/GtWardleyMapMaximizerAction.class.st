Class {
	#name : #GtWardleyMapMaximizerAction,
	#superclass : #Object,
	#traits : 'TGtWardleyMapDecoratorModel',
	#classTraits : 'TGtWardleyMapDecoratorModel classTrait',
	#instVars : [
		'label',
		'icon',
		'stencil',
		'aptitude',
		'model',
		'preferredBackground',
		'tooltip'
	],
	#category : #'GToolkit-WardleyMap-! Models - Decorators'
}

{ #category : #accessing }
GtWardleyMapMaximizerAction >> aptitude [
	^ aptitude
]

{ #category : #'api - decoration' }
GtWardleyMapMaximizerAction >> aptitude: aBlock [
	aptitude := aBlock
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapMaximizerAction >> decorateNodeElementInContext: aNodeDecoratorContext [
	aNodeDecoratorContext nodeElement
		labelContainerDo: [ :aContainer | 
			| aButton |
			aButton := self newNodeButton.
			aButton
				wardleyMapNodeViewModel: aNodeDecoratorContext nodeViewModel;
				wardleyMapDecoratorViewModel: aNodeDecoratorContext decoratorViewModel.
			aContainer addChild: aButton ]
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
GtWardleyMapMaximizerAction >> newButton: aButtonClass [
	^ GtWardleyMapActionButtonStencil new
		buttonClass: aButtonClass;
		icon: self icon;
		label: self label;
		tooltip: self tooltip;
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

{ #category : #private }
GtWardleyMapMaximizerAction >> newNodeButton [
	^ self newButton: GtWardleyMapActionNodeButton
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
	^ preferredBackground ifNil: [ preferredBackground := BlTheme default default backdropBackground ]
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

{ #category : #private }
GtWardleyMapMaximizerAction >> tooltip [
	^ tooltip
]

{ #category : #accessing }
GtWardleyMapMaximizerAction >> tooltip: aString [ 
	tooltip := aString
]
