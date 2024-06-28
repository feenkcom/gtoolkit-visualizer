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
		'tooltip',
		'elementId'
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

{ #category : #'api - wardley map decorator model' }
GtWardleyMapAction >> decorateEdgeElementInContext: anEdgeDecoratorContext [
	anEdgeDecoratorContext isLabelVisible
		ifTrue: [ anEdgeDecoratorContext
				labelContainerDo: [ :aLabelContainer | 
					| anActionContainer aButton |
					anActionContainer := GtWardleyMapUtility
							ensureCenterRightOuterDecoratorContainerFor: aLabelContainer.
					aButton := self newEdgeButton.
					aButton
						wardleyMapEdgeViewModel: anEdgeDecoratorContext edgeViewModel;
						wardleyMapDecoratorViewModel: anEdgeDecoratorContext decoratorViewModel.
					anActionContainer addChild: aButton ] ]
		ifFalse: [ | anActionContainer aButton |
			anActionContainer := GtWardleyMapUtility
					ensureCenterDecoratorContainerFor: anEdgeDecoratorContext edgeElement.
			aButton := self newEdgeButton.
			aButton
				wardleyMapEdgeViewModel: anEdgeDecoratorContext edgeViewModel;
				wardleyMapDecoratorViewModel: anEdgeDecoratorContext decoratorViewModel.
			anActionContainer addChild: aButton ]
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapAction >> decorateMapElementInContext: aMapDecoratorContext [
	| anActionContainer aButton |
	anActionContainer := GtWardleyMapUtility
			ensureTopRightInnerDecoratorContainerFor: aMapDecoratorContext canvasElement.
	aButton := self newMapButton.
	aButton wardleyMapDecoratorViewModel: aMapDecoratorContext decoratorViewModel.
	anActionContainer addChild: aButton
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapAction >> decorateNodeElementInContext: aNodeDecoratorContext [
	aNodeDecoratorContext
		labelContainerDo: [ :aLabelContainer | 
			| anActionContainer aButton |
			anActionContainer := GtWardleyMapUtility
					ensureCenterRightOuterDecoratorContainerFor: aLabelContainer.
			aButton := self newNodeButton.
			aButton
				wardleyMapNodeViewModel: aNodeDecoratorContext nodeViewModel;
				wardleyMapDecoratorViewModel: aNodeDecoratorContext decoratorViewModel.
			anActionContainer addChild: aButton ]
]

{ #category : #accessing }
GtWardleyMapAction >> elementId [
	<return: #BlElementId or: nil>
	^ elementId
]

{ #category : #accessing }
GtWardleyMapAction >> elementId: anObject [
	elementId := anObject
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
GtWardleyMapAction >> newButton: aButtonClass [
	^ GtWardleyMapActionButtonStencil new
		buttonClass: aButtonClass;
		elementId: self elementId;
		icon: self icon;
		label: self label;
		tooltip: self tooltip;
		aptitude: self aptitude;
		action: self action;
		model: self model;
		asElement
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapAction >> newEdgeButton [
	^ self newButton: GtWardleyMapActionEdgeButton
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapAction >> newMapButton [
	^ self newButton: GtWardleyMapActionButton
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapAction >> newNodeButton [
	^ self newButton: GtWardleyMapActionNodeButton
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
