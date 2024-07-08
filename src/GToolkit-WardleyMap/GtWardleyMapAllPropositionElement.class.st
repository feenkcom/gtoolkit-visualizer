Class {
	#name : #GtWardleyMapAllPropositionElement,
	#superclass : #BlElement,
	#traits : 'TGtWithWardleyMapViewModel + TGtWithWardleyMapDecoratorViewModel + TBrLayoutResizable',
	#classTraits : 'TGtWithWardleyMapViewModel classTrait + TGtWithWardleyMapDecoratorViewModel classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'mutex',
		'counter',
		'acceptButton',
		'rejectButton',
		'labelElement',
		'updater'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'private - counter' }
GtWardleyMapAllPropositionElement >> counter [
	<return: #Integer>
	^ mutex critical: [ counter ]
]

{ #category : #'private - counter' }
GtWardleyMapAllPropositionElement >> decreaseCounter [
	"Return true if counter was decreased from 1 to 0, false otherwise."

	<return: #Boolean>
	^ mutex
		critical: [
			counter := counter - 1.
			self assert: [ counter >= 0 ].
			counter = 0 ]
]

{ #category : #initialization }
GtWardleyMapAllPropositionElement >> defaultLayout [
	^ BlLinearLayout vertical alignCenterLeft
]

{ #category : #'private - counter' }
GtWardleyMapAllPropositionElement >> increaseCounter [
	"Return true if counter was increased from 0 to 1, false otherwise."

	<return: #Boolean>
	^ mutex
		critical: [ | aReturnValue |
			aReturnValue := counter = 0.
			counter := counter + 1.
			aReturnValue ]
]

{ #category : #initialization }
GtWardleyMapAllPropositionElement >> initialize [
	super initialize.
	mutex := Mutex new.
	counter := 0.

	self initializeUpdater.
	self initiazeLabelElement.
	self initializeAcceptButton.
	self initializeRejectButton.

	self addChild: labelElement.
	self
		addChild: (BrHorizontalPane new
				fitContent;
				addChild: acceptButton;
				addChild: rejectButton).

	self fitContent
]

{ #category : #initialization }
GtWardleyMapAllPropositionElement >> initializeAcceptButton [
	acceptButton := GtWardleyMapActionButtonStencil new
		buttonClass: GtWardleyMapActionButton;
		elementId: GtWardleyMapAllAcceptId;
		icon: BrGlamorousVectorIcons accept;
		label: nil;
		tooltip: 'Accept all';
		action: [ self onAcceptAction ];
		asElement
]

{ #category : #initialization }
GtWardleyMapAllPropositionElement >> initializeRejectButton [
	rejectButton := GtWardleyMapActionButtonStencil new
		buttonClass: GtWardleyMapActionButton;
		elementId: GtWardleyMapAllRejectId;
		icon: BrGlamorousVectorIcons cancel;
		label: nil;
		tooltip: 'Reject all';
		action: [ self onRejectAction ];
		asElement
]

{ #category : #initialization }
GtWardleyMapAllPropositionElement >> initializeUpdater [
	updater := BrElementUpdater new
		element: self selector: #updateElement
]

{ #category : #initialization }
GtWardleyMapAllPropositionElement >> initiazeLabelElement [
	labelElement := BrLabel new
			aptitude: (BrGlamorousLabelAptitude new foreground: self theme button disabledTextColor);
			beTinySize;
			fitContent;
			text: 'Propositions:'
]

{ #category : #'event handling' }
GtWardleyMapAllPropositionElement >> onAcceptAction [
	self wardleyMapDecoratorViewModel wardleyMapDecoratorModel onAcceptAction
]

{ #category : #'event handling' }
GtWardleyMapAllPropositionElement >> onDecoratorAdded: anAnnouncement [
	anAnnouncement decoratorViewModel isActionableProposition ifFalse: [ ^ self ].

	self increaseCounter ifTrue: [ self requestUpdate ]
]

{ #category : #'event handling' }
GtWardleyMapAllPropositionElement >> onDecoratorRemoved: anAnnouncement [
	anAnnouncement decoratorViewModel isActionableProposition ifFalse: [ ^ self ].
	
	self decreaseCounter ifTrue: [ self requestUpdate ]
]

{ #category : #'event handling' }
GtWardleyMapAllPropositionElement >> onEdgeRemoved: anAnnouncement [
	| isWantToUpdate |
	isWantToUpdate := false.
	mutex critical: [ 
		anAnnouncement edgeViewModel wardleyMapDecoratorViewModels
			do: [ :aDecorator | aDecorator isActionableProposition 
				ifTrue: [ isWantToUpdate := isWantToUpdate | self decreaseCounter ] ] ].
	isWantToUpdate ifTrue: [ self requestUpdate ]
]

{ #category : #'event handling' }
GtWardleyMapAllPropositionElement >> onMyDecoratorRemoved: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self removeFromParent ]
]

{ #category : #'event handling' }
GtWardleyMapAllPropositionElement >> onNodeRemoved: anAnnouncement [
	| isWantToUpdate |
	isWantToUpdate := false.
	mutex critical: [ 
		anAnnouncement nodeViewModel wardleyMapDecoratorViewModels
			do: [ :aDecorator | aDecorator isActionableProposition 
				ifTrue: [ isWantToUpdate := isWantToUpdate | self decreaseCounter ] ] ].
	isWantToUpdate ifTrue: [ self requestUpdate ]
]

{ #category : #'event handling' }
GtWardleyMapAllPropositionElement >> onRejectAction [
	self wardleyMapDecoratorViewModel wardleyMapDecoratorModel onRejectAction
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapAllPropositionElement >> onWardleyMapDecoratorViewModelChanged [
	"Is sent when a new wardleyMapDecorator view model is assigned to the element"

	
]

{ #category : #'api - wardley map view model' }
GtWardleyMapAllPropositionElement >> onWardleyMapViewModelChanged [
	"Is sent when a new WardleyMap view model is assigned to the element"
	
	mutex critical: [ 
		counter := 0.
		self wardleyMapViewModel allWardleyMapDecoratorViewModelsDo: [ :aDecoratorViewModel | 
			aDecoratorViewModel isActionableProposition ifTrue: [ 
				counter := counter + 1 ]
		]
	].
	
	self updateElement
]

{ #category : #'private - updating' }
GtWardleyMapAllPropositionElement >> requestUpdate [
	updater ifNotNil: #requestUpdate
]

{ #category : #'event handling' }
GtWardleyMapAllPropositionElement >> subscribeToWardleyMapDecoratorViewModel [
	"Is sent after a new wardleyMapDecorator view model is assigned to the element.
	It is required to unsubscribe from the view model by implementing
	#unsubscribeFromWardleyMapDecoratorViewModel if element subscribes to them"
	
	self wardleyMapDecoratorViewModel weak
		when: GtWardleyMapDecoratorViewModelRemoved send: #onMyDecoratorRemoved: to: self
]

{ #category : #'api - wardley map view model' }
GtWardleyMapAllPropositionElement >> subscribeToWardleyMapViewModel [
	"Is sent after a new WardleyMap view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapViewModel if elements subscribe to them"
	
	self wardleyMapViewModel weak
		when: GtWardleyMapDecoratorViewModelAdded send: #onDecoratorAdded: to: self;
		when: GtWardleyMapNodeDecoratorViewModelAdded send: #onDecoratorAdded: to: self;
		when: GtWardleyMapEdgeDecoratorViewModelAdded send: #onDecoratorAdded: to: self;
		when: GtWardleyMapDecoratorViewModelRemoved send: #onDecoratorRemoved: to: self;
		when: GtWardleyMapNodeDecoratorViewModelRemoved send: #onDecoratorRemoved: to: self;
		when: GtWardleyMapEdgeDecoratorViewModelRemoved send: #onDecoratorRemoved: to: self;
		when: GtWardleyMapNodeViewModelRemoved send: #onNodeRemoved: to: self;
		when: GtWardleyMapEdgeViewModelRemoved send: #onEdgeRemoved: to: self
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapAllPropositionElement >> unsubscribeFromWardleyMapDecoratorViewModel [
	"Is sent before a new wardleyMapDecorator view model is assigned to the element.
	Elements that subscribe to wardleyMapDecorator view model are required to implement this methods"
	
	self wardleyMapDecoratorViewModel unsubscribe: self
]

{ #category : #'api - wardley map view model' }
GtWardleyMapAllPropositionElement >> unsubscribeFromWardleyMapViewModel [
	"Is sent before a new WardleyMap view model is assigned to the element.
	Elements that subscribe to WardleyMap view model in domain model are required to implement this methods"
	
	self wardleyMapViewModel unsubscribe: self
]

{ #category : #'private - updating' }
GtWardleyMapAllPropositionElement >> updateElement [
	self counter isZero
		ifTrue: [ self updateElementAsGone ]
		ifFalse: [ self updateElementAsVisible ]
]

{ #category : #'private - updating' }
GtWardleyMapAllPropositionElement >> updateElementAsGone [
	self counter = 0 ifFalse: [ ^ self ].
	self visibility: BlVisibility gone
]

{ #category : #'private - updating' }
GtWardleyMapAllPropositionElement >> updateElementAsVisible [
	self counter = 0 ifTrue: [ ^ self ].
	self visibility: BlVisibility visible
]
