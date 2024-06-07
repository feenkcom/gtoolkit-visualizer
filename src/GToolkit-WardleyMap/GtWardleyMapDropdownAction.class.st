Class {
	#name : #GtWardleyMapDropdownAction,
	#superclass : #GtWardleyMapAction,
	#instVars : [
		'content'
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
		labelContainerDo: [ :aContainer | 
			| aButton |
			aButton := self newButton.
			aDecoratorViewModel
				when: GtWardleyMapNodeDecoratorViewModelRemoved
				send: #removeFromParent
				to: aButton.
			aDecoratorViewModel
				when: GtWardleyMapNodeLabelModelTextChanged
				send: #removeFromParent
				to: aButton.
			aContainer addChild: aButton ]
]

{ #category : #accessing }
GtWardleyMapDropdownAction >> newButton [
	| aButton |
	^ aButton := BrButton new beTinySize
			margin: (BlInsets left: 2);
			constraintsDo: [ :c | 
				c linear vertical alignCenter.
				c linear horizontal alignCenter ];
			icon: self icon;
			label: self tooltip;
			aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude
					+ (BrGlamorousWithDropdownAptitude
							handle: [ BrButton new
									aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude
											- BrGlamorousButtonExteriorAptitude;
									icon: self icon ]
							content: [ self content value: aButton ])
]
