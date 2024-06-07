Class {
	#name : #GtWardleyMapRenameProposition,
	#superclass : #Object,
	#traits : 'TGtWardleyMapDecoratorModel',
	#classTraits : 'TGtWardleyMapDecoratorModel classTrait',
	#instVars : [
		'options',
		'parent',
		'originalLabel'
	],
	#category : #'GToolkit-WardleyMap-! Models - Decorators'
}

{ #category : #'api - wardley map decorator model' }
GtWardleyMapRenameProposition >> decorateNodeElement: aNodeElement decoratorViewModel: aDecoratorViewModel [
	| aHighlightElement proposeAction rejectAction acceptAction |
	aHighlightElement := GtWardleyMapNodePropositionElement new
			highlightColor: BrGlamorousColors failureBackgroundColor;
			wardleyMapNodeViewModel: aNodeElement wardleyMapNodeViewModel;
			wardleyMapDecoratorViewModel: aDecoratorViewModel;
			nodeElement: aNodeElement.

	BlTaskAction
		enqueueElement: aNodeElement
		action: [ aNodeElement parent addChild: aHighlightElement ].

	proposeAction := GtWardleyMapDropdownAction new.
	proposeAction icon: BrGlamorousVectorIcons downwards.
	proposeAction tooltip: 'Proposed names'.
	proposeAction
		content: [ :aButton | 
			BrSimpleList new
				padding: (BlInsets all: 5);
				matchParent;
				items: self options;
				itemStencil: [ BrLabel new hMatchParent beSmallSize hMatchParent
						aptitude: BrGlamorousLabelAptitude + BrGlamorousListItemAptitude;
						when: BlClickEvent
							do: [ :evt | 
								self renameTo: evt currentTarget text asString.
								aButton dispatchEvent: BrDropdownHideWish new ] ];
				itemDataBinder: [ :anItemElement :anItem | anItemElement text: anItem ] ].
	proposeAction
		decorateNodeElement: aNodeElement
		decoratorViewModel: aDecoratorViewModel.


	acceptAction := GtWardleyMapAction new.
	acceptAction icon: BrGlamorousVectorIcons accept.
	acceptAction tooltip: 'Accept rename'.
	acceptAction action: [ self onProposalFinished ].
	acceptAction
		decorateNodeElement: aNodeElement
		decoratorViewModel: aDecoratorViewModel.

	rejectAction := GtWardleyMapAction new.
	rejectAction icon: BrGlamorousVectorIcons cancel.
	rejectAction tooltip: 'Keep old name'.
	rejectAction
		action: [ parent label: originalLabel.
			self onProposalFinished ].
	rejectAction
		decorateNodeElement: aNodeElement
		decoratorViewModel: aDecoratorViewModel
]

{ #category : #accessing }
GtWardleyMapRenameProposition >> onProposalFinished [
	parent ifNil: [ ^ self ].
	parent removeWardleyMapDecoratorModel: self.
]

{ #category : #accessing }
GtWardleyMapRenameProposition >> options [
	^ options
]

{ #category : #accessing }
GtWardleyMapRenameProposition >> options: anObject [
	options := anObject
]

{ #category : #accessing }
GtWardleyMapRenameProposition >> parent: aParent [
	self assert: [ parent isNil ] description: [ 'Only one parent is allowed' ].

	parent := aParent.
	originalLabel := parent label
]

{ #category : #accessing }
GtWardleyMapRenameProposition >> removeParent [
	parent := nil
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapRenameProposition >> renameTo: aString [
	parent label: aString
]
