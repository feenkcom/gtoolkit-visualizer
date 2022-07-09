Class {
	#name : #GtSequenceDiagramActorElement,
	#superclass : #BrVerticalPane,
	#traits : 'TGtWithSequenceDiagramParticipantViewModel',
	#classTraits : 'TGtWithSequenceDiagramParticipantViewModel classTrait',
	#instVars : [
		'labelElement',
		'actorElement'
	],
	#category : #'GToolkit-SequenceDiagram-UI'
}

{ #category : #testing }
GtSequenceDiagramActorElement >> hasInspecteableModel [
	^ self hasParticipantViewModel and: [ self participantViewModel hasModel ]
]

{ #category : #initialization }
GtSequenceDiagramActorElement >> initialize [
	super initialize.
	self initializeChildren.
	self initializeStyle.
	self initializeEventHandlers.
	self initializeAsyncElementFuture.

	self fitContent.
	self constraintsDo: [ :c | c grid vertical alignBottom ]
]

{ #category : #initialization }
GtSequenceDiagramActorElement >> initializeAsyncElementFuture [
	self
		withAsyncFutureDo: [ :anAsyncElementFuture | 
			anAsyncElementFuture
				whenPending: [ :anElement |  ];
				whenError: [ :theContainer :anError |  ];
				whenSuccess: [ :anElement :aParticipant | 
					self updateElementWithParticipant: aParticipant ] ]
]

{ #category : #initialization }
GtSequenceDiagramActorElement >> initializeChildren [
	| aScalableActorElement |
	actorElement := BrGlamorousVectorIcons actor asElement.

	aScalableActorElement := actorElement asScalableElement
			height: 42;
			constraintsDo: [ :c | c linear horizontal alignCenter ].

	labelElement := BrLabel new
			fitContent;
			aptitude: BrGlamorousLabelAptitude new;
			text: 'Actor';
			constraintsDo: [ :c | c linear horizontal alignCenter ].

	self addChild: aScalableActorElement.
	self addChild: labelElement
]

{ #category : #initialization }
GtSequenceDiagramActorElement >> initializeEventHandlers [
	self when: BlClickEvent do: [ :anEvent | self onMouseClick: anEvent ]
]

{ #category : #initialization }
GtSequenceDiagramActorElement >> initializeStyle [
	self
		aptitude: (BrStyleCommonAptitude new
				hovered: [ :aStyle | aStyle do: [ self styleHovered ] after: [ self styleDefault ] ])
]

{ #category : #'private - event handling' }
GtSequenceDiagramActorElement >> onMouseClick: anEvent [
	self hasInspecteableModel ifFalse: [ ^ self ].

	self phlow spawnObject: self participantViewModel model
]

{ #category : #'private - announcement handling' }
GtSequenceDiagramActorElement >> onParticipantChanged: anAnnouncement [
	self requestElementUpdate
]

{ #category : #'api - participant view model' }
GtSequenceDiagramActorElement >> onParticipantViewModelChanged [
	self requestElementUpdate
]

{ #category : #'private - updating' }
GtSequenceDiagramActorElement >> requestElementUpdate [
	self
		withAsyncFutureDo: [ :anAsyncElementFuture | anAsyncElementFuture future: [ self participantViewModel participant ] ]
]

{ #category : #initialization }
GtSequenceDiagramActorElement >> styleDefault [
	labelElement aptitude
		foreground: Color black.

	actorElement
		border: (BlBorder builder
				paint: Color black;
				width: 1;
				build)
]

{ #category : #'private - styling' }
GtSequenceDiagramActorElement >> styleHovered [
	self hasInspecteableModel ifFalse: [ ^ self ].

	labelElement aptitude
		foreground: BrGlamorousColors hoveredButtonTextColor.

	actorElement
		border: (BlBorder builder
				paint: BrGlamorousColors hoveredButtonBorderColor;
				width: 1;
				build)
]

{ #category : #'api - participant view model' }
GtSequenceDiagramActorElement >> subscribeToParticipantViewModel [
	self participantViewModel weak
		when: GtSequenceDiagramParticipantChanged
		send: #onParticipantChanged:
		to: self
]

{ #category : #'api - participant view model' }
GtSequenceDiagramActorElement >> unsubscribeFromParticipantViewModel [
	self participantViewModel unsubscribe: self
]

{ #category : #'private - updating' }
GtSequenceDiagramActorElement >> updateElementWithParticipant: aParticipant [
	labelElement text: aParticipant name.
	
	aParticipant hasModel ifFalse: [ ^ self ].
]
