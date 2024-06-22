Class {
	#name : #GtWardleyMapAction,
	#superclass : #Object,
	#traits : 'TGtWardleyMapDecoratorModel + TGtOptions',
	#classTraits : 'TGtWardleyMapDecoratorModel classTrait + TGtOptions classTrait',
	#instVars : [
		'label',
		'icon',
		'action',
		'aptitude',
		'model',
		'tooltip'
	],
	#category : #'GToolkit-WardleyMap-! Models - Decorators'
}

{ #category : #'api - decoration' }
GtWardleyMapAction >> action [
	^ action
]

{ #category : #'api - decoration' }
GtWardleyMapAction >> action: anObject [
	action := anObject
]

{ #category : #'api - decoration' }
GtWardleyMapAction >> aptitude [
	^ aptitude
]

{ #category : #'api - decoration' }
GtWardleyMapAction >> aptitude: aBlock [
	aptitude := aBlock
]

{ #category : #private }
GtWardleyMapAction >> buttonLabelFromString: aString [
	aString size <= GtWardleyMapConstants maxButtonLabelCharacters 
		ifTrue: [ ^ aString ].
		
	^ (aString copyFrom: 1 to: GtWardleyMapConstants maxButtonLabelCharacters - 3), '...'
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapAction >> decorateNodeElementInContext: aNodeDecoratorContext [
	aNodeDecoratorContext 
		labelContainerDo: [ :aLabelContainer | 
			| anActionContainer aButton |
			anActionContainer := GtWardleyMapUtility ensureRightDecoratorContainerFor: aLabelContainer.
			aButton := self newButton.
			aNodeDecoratorContext decoratorViewModel weak
				when: GtWardleyMapNodeDecoratorViewModelRemoved
				send: #removeFromParent
				to: aButton.
			anActionContainer addChild: aButton. ]
]

{ #category : #'api - decoration' }
GtWardleyMapAction >> icon [
	^ icon
]

{ #category : #'api - decoration' }
GtWardleyMapAction >> icon: anObject [
	icon := anObject
]

{ #category : #'api - decoration' }
GtWardleyMapAction >> label [
	^ label
]

{ #category : #'api - decoration' }
GtWardleyMapAction >> label: anObject [
	label := anObject
]

{ #category : #'api - decoration' }
GtWardleyMapAction >> model [
	^ model
]

{ #category : #'api - decoration' }
GtWardleyMapAction >> model: anObject [
	model := anObject
]

{ #category : #private }
GtWardleyMapAction >> newButton [
	^ GtWardleyMapActionButtonStencil new
		icon: self icon;
		label: self label;
		tooltip: self tooltip;
		aptitude: self aptitude;
		action: self action;
		model: self model;
		asElement
]

{ #category : #'api - decoration' }
GtWardleyMapAction >> noIcon [
	self icon: nil
]

{ #category : #initialization }
GtWardleyMapAction >> parent: aParent [
	self model: aParent
]

{ #category : #'api - decoration' }
GtWardleyMapAction >> tooltip [
	^ tooltip
]

{ #category : #'api - decoration' }
GtWardleyMapAction >> tooltip: anObject [
	tooltip := anObject
]
