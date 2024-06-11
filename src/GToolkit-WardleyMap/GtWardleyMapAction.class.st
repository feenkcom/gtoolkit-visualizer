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
GtWardleyMapAction >> decorateNodeElement: aNodeElement decoratorViewModel: aDecoratorViewModel [
	aNodeElement
		labelContainerDo: [ :aLabelContainer | 
			| anActionContainer aButton |
			anActionContainer := GtWardleyMapUtility ensureRightDecoratorContainerFor: aLabelContainer.
			aButton := self newButton.
			aDecoratorViewModel weak
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

{ #category : #'api - convenience' }
GtWardleyMapAction >> page: aLePage [
	self
		icon: LeIcons lepiterPage;
		tooltip: ('Navigate to the page named {1}' format: { aLePage title });
		action: [ :aButton | aButton phlow spawnTool: (LePagePhlowTool page: aLePage) ]
]

{ #category : #'api - convenience' }
GtWardleyMapAction >> pageNamed: aLePageName [
	self
		icon: LeIcons lepiterPage;
		"label: (self buttonLabelFromString: aLePageName);"
		tooltip: ('Navigate to the page named {1}' format: { aLePageName });
		action: [ :aButton | 
			LeDatabasesRegistry defaultLogicalDatabase
				pageNamed: aLePageName
				ifPresent: [ :aPage | 
					aButton phlow spawnTool: (LePagePhlowTool page: aPage) ]
				ifAbsent: [ 
					| aNotification |
					aNotification := GtNotificationMessage new 
						message: ('Page not found: {1}' format: { aLePageName }).
					aButton showNotification: aNotification ] ]
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
