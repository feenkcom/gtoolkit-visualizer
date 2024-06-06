Class {
	#name : #GtWardleyMapAction,
	#superclass : #Object,
	#traits : 'TGtWardleyMapDecoratorModel',
	#classTraits : 'TGtWardleyMapDecoratorModel classTrait',
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

{ #category : #'api - wardley map decorator model' }
GtWardleyMapAction >> decorateNodeElement: aNodeElement decoratorViewModel: aDecoratorViewModel [
	aNodeElement
		labelContainerDo: [ :aContainer | 
			| aButton |
			aButton := self newButton.
			aDecoratorViewModel
				when: GtWardleyMapNodeDecoratorViewModelRemoved
				send: #removeFromParent
				to: aButton.
			aContainer addChild: aButton ]
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
	^ GtWardleyMapActionButtonStencil new
		icon: self icon;
		label: self label;
		aptitude: self aptitude;
		action: self action;
		model: self model;
		asElement
]

{ #category : #initialization }
GtWardleyMapAction >> parent: aParent [
	self model: aParent
]
