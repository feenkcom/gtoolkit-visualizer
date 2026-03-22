Class {
	#name : #GtWardleyMapRenameProposition,
	#superclass : #Object,
	#traits : 'TGtWardleyMapDecoratorModel',
	#classTraits : 'TGtWardleyMapDecoratorModel classTrait',
	#instVars : [
		'options',
		'parent',
		'originalLabel',
		'dropdownAction',
		'acceptAction',
		'rejectAction'
	],
	#category : #'GToolkit-WardleyMap-! Models - Decorators'
}

{ #category : #'api - wardley map decorator model' }
GtWardleyMapRenameProposition >> decorateNodeElementInContext: aNodeDecoratorContext [
	| aHighlightElement |
	aHighlightElement := GtWardleyMapNodePropositionElement new
			beChangeProposition;
			wardleyMapNodeViewModel: aNodeDecoratorContext nodeViewModel;
			wardleyMapDecoratorViewModel: aNodeDecoratorContext decoratorViewModel;
			nodeElement: aNodeDecoratorContext nodeElement.

	aNodeDecoratorContext canvasElement addChild: aHighlightElement.

	dropdownAction decorateNodeElementInContext: aNodeDecoratorContext.
	acceptAction decorateNodeElementInContext: aNodeDecoratorContext.
	rejectAction decorateNodeElementInContext: aNodeDecoratorContext
]

{ #category : #initialization }
GtWardleyMapRenameProposition >> initialize [
	super initialize.
	dropdownAction := GtWardleyMapDropdownAction new.
	dropdownAction elementId: GtWardleyMapRenameProposalsId.
	dropdownAction icon: BrGlamorousVectorIcons downwards.
	dropdownAction tooltip: 'Proposed names'.
	dropdownAction content: [ self newProposalList ].

	acceptAction := GtWardleyMapAction new.
	acceptAction elementId: GtWardleyMapRenameAcceptId.
	acceptAction icon: BrGlamorousVectorIcons accept.
	acceptAction tooltip: 'Accept rename'.
	acceptAction action: [ self onAcceptAction ].

	rejectAction := GtWardleyMapAction new.
	rejectAction elementId: GtWardleyMapRenameRejectId.
	rejectAction icon: BrGlamorousVectorIcons cancel.
	rejectAction tooltip: 'Keep original name'.
	rejectAction action: [ self onRejectAction ]
]

{ #category : #testing }
GtWardleyMapRenameProposition >> isActionableProposition [
	"Return true if it can be handled by GtWardleyMapAllProposition.
	Such decorator must implement #onAcceptAction and #onRejectAction methods.
	Return false in other cases."

	<return: #Boolean>
	^ true
]

{ #category : #initialization }
GtWardleyMapRenameProposition >> newListItemElement [
	^ BrLabel new fitContent
		aptitude: BrGlamorousLabelAptitude + BrGlamorousListItemAptitude;
		when: BlClickEvent
			do: [ :anEvent | 
				self renameTo: anEvent currentTarget text asString.
				anEvent currentTarget fireEvent: BrDropdownHideWish new ]
]

{ #category : #initialization }
GtWardleyMapRenameProposition >> newProposalList [
	| aContainer aList aTitle |
	aContainer := BrVerticalPane new
			padding: (BlInsets all: 5);
			hFitContentLimited;
			vFitContentLimited.

	originalLabel
		ifNotNil: [ :aName | 
			| aTitle1 aTitle2 |
			aTitle1 := BrLabel new
					margin: (BlInsets
							top: 0
							right: 3
							bottom: 3
							left: 3);
					text: 'Original name:';
					aptitude: (BrGlamorousLabelAptitude new
							foreground: BrGlamorousColors disabledButtonTextColor).
			aTitle2 := self newListItemElement
					id: GtWardleyMapRenameOriginalNameId;
					margin: (BlInsets
							top: 0
							right: 3
							bottom: 3
							left: 3);
					text: aName asString.
			aContainer
				addChildren: {aTitle1.
						aTitle2} ].

	aTitle := BrLabel new
			margin: (BlInsets
					top: 0
					right: 3
					bottom: 3
					left: 3);
			text: 'Proposed names:';
			aptitude: (BrGlamorousLabelAptitude new
					foreground: BrGlamorousColors disabledButtonTextColor).

	aList := BrSimpleList new
			margin: (BlInsets left: 3 right: 3);
			hFitContent;
			vFitContentLimited;
			items: self options;
			itemStencil: [ self newListItemElement ];
			itemDataBinder: [ :anItemElement :anItem :anItemIndex | 
				anItemElement 
					id: (GtWardleyMapRenameProposalId indexed: anItemIndex);
					text: anItem ].


	aContainer
		addChildren: {aTitle.
				aList}.
	^ aContainer
]

{ #category : #'event handling' }
GtWardleyMapRenameProposition >> onAcceptAction [
	self onProposalFinished
]

{ #category : #'event handling' }
GtWardleyMapRenameProposition >> onProposalFinished [
	parent ifNil: [ ^ self ].
	parent removeWardleyMapDecoratorModel: self.
]

{ #category : #'event handling' }
GtWardleyMapRenameProposition >> onRejectAction [
	self onRejectRename
]

{ #category : #'event handling' }
GtWardleyMapRenameProposition >> onRejectRename [
	parent ifNil: [ ^ self ].
	originalLabel ifNotNil: [
		parent label: originalLabel ].
	self onProposalFinished
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

{ #category : #'event handling' }
GtWardleyMapRenameProposition >> renameTo: aString [
	parent ifNil: [ ^ self ].
	parent label: aString
]
