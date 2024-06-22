Class {
	#name : #GtWardleyMapDropdownAction,
	#superclass : #GtWardleyMapAction,
	#instVars : [
		'content',
		'preferredExtent'
	],
	#category : #'GToolkit-WardleyMap-! Models - Decorators'
}

{ #category : #accessing }
GtWardleyMapDropdownAction >> content [
	^ content
]

{ #category : #accessing }
GtWardleyMapDropdownAction >> content: anObject [
	content := anObject
]

{ #category : #accessing }
GtWardleyMapDropdownAction >> decorateNodeElementInContext: aNodeDecoratorContext [
	aNodeDecoratorContext nodeElement
		labelContainerDo: [ :aLabelContainer | 
			| anActionContainer aButton |
			anActionContainer := GtWardleyMapUtility ensureCenterRightOuterDecoratorContainerFor: aLabelContainer.
			aButton := self newButton.
			aNodeDecoratorContext decoratorViewModel weak
				when: GtWardleyMapNodeDecoratorViewModelRemoved
				send: #removeFromParent
				to: aButton.
			aNodeDecoratorContext decoratorViewModel weak
				when: GtWardleyMapNodeLabelModelTextChanged
				send: #removeFromParent
				to: aButton.
			anActionContainer addChild: aButton ]
]

{ #category : #accessing }
GtWardleyMapDropdownAction >> newButton [
	| anAptitude |
	anAptitude := BrGlamorousWithDropdownAptitude
			handle: [ super newButton
					in: [ :theHandle | 
						theHandle aptitude - BrGlamorousButtonExteriorAptitude ];
					margin: BlInsets empty ]
			content: self content.
	preferredExtent ifNotNil: [ anAptitude preferredExtent: preferredExtent ].
	^ super newButton addAptitude: anAptitude
]

{ #category : #accessing }
GtWardleyMapDropdownAction >> preferredExtent [
	^ preferredExtent
]

{ #category : #accessing }
GtWardleyMapDropdownAction >> preferredExtent: anObject [
	preferredExtent := anObject
]
