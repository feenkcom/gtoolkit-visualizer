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
GtWardleyMapDropdownAction >> decorateNodeElement: aNodeElement decoratorViewModel: aDecoratorViewModel [
	aNodeElement
		labelContainerDo: [ :aLabelContainer | 
			| anActionContainer aButton |
			anActionContainer := GtWardleyMapUtility ensureRightDecoratorContainerFor: aLabelContainer.
			aButton := self newButton.
			aDecoratorViewModel weak
				when: GtWardleyMapNodeDecoratorViewModelRemoved
				send: #removeFromParent
				to: aButton.
			aDecoratorViewModel weak
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
