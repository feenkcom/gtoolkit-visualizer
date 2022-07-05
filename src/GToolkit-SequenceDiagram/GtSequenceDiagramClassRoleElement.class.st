Class {
	#name : #GtSequenceDiagramClassRoleElement,
	#superclass : #BrVerticalPane,
	#traits : 'TGtWithSequenceDiagramParticipantViewModel',
	#classTraits : 'TGtWithSequenceDiagramParticipantViewModel classTrait',
	#instVars : [
		'labelElement',
		'objectElement'
	],
	#category : #'GToolkit-SequenceDiagram-UI'
}

{ #category : #testing }
GtSequenceDiagramClassRoleElement >> hasInspecteableModel [
	^ self hasParticipantViewModel and: [ self participantViewModel hasModel ]
]

{ #category : #initialization }
GtSequenceDiagramClassRoleElement >> initialize [
	super initialize.
	self initializeChildren.
	self initializeStyle.
	self initializeEventHandlers.
	self initializeAsyncElementFuture.

	self fitContent
]

{ #category : #initialization }
GtSequenceDiagramClassRoleElement >> initializeAsyncElementFuture [
	self
		withAsyncFutureDo: [ :anAsyncElementFuture | 
			anAsyncElementFuture
				whenPending: [ :anElement |  ];
				whenError: [ :theContainer :anError |  ];
				whenSuccess: [ :anElement :aParticipant | 
					self updateElementWithParticipant: aParticipant ] ]
]

{ #category : #initialization }
GtSequenceDiagramClassRoleElement >> initializeChildren [
	objectElement := BrVerticalPane new
			fitContent;
			border: (BlBorder paint: Color black width: 1).

	labelElement := BrLabel new
			fitContent;
			aptitude: (BrGlamorousLabelAptitude new underlineColor: Color black);
			margin: (BlInsets all: 5);
			text: ':?'.

	objectElement addChild: labelElement.
	self addChild: objectElement
]

{ #category : #initialization }
GtSequenceDiagramClassRoleElement >> initializeEventHandlers [
	self when: BlClickEvent do: [ :anEvent | self onMouseClick: anEvent ]
]

{ #category : #initialization }
GtSequenceDiagramClassRoleElement >> initializeStyle [
	self
		aptitude: (BrStyleCommonAptitude new
				hovered: [ :aStyle | aStyle do: [ self styleHovered ] after: [ self styleDefault ] ])
]

{ #category : #'private - event handling' }
GtSequenceDiagramClassRoleElement >> onMouseClick: anEvent [
	self hasInspecteableModel ifFalse: [ ^ self ].

	self phlow spawnObject: self participantViewModel model
]

{ #category : #'private - announcement handling' }
GtSequenceDiagramClassRoleElement >> onParticipantChanged: anAnnouncement [
	self requestElementUpdate
]

{ #category : #'api - participant view model' }
GtSequenceDiagramClassRoleElement >> onParticipantViewModelChanged [
	self requestElementUpdate
]

{ #category : #'private - updating' }
GtSequenceDiagramClassRoleElement >> requestElementUpdate [
	self
		withAsyncFutureDo: [ :anAsyncElementFuture | anAsyncElementFuture future: [ self participantViewModel participant ] ]
]

{ #category : #initialization }
GtSequenceDiagramClassRoleElement >> styleDefault [
	labelElement aptitude
		foreground: Color black;
		underlineColor: Color black.

	objectElement
		border: (BlBorder builder
				paint: Color black;
				width: 1;
				build)
]

{ #category : #'private - styling' }
GtSequenceDiagramClassRoleElement >> styleHovered [
	self hasInspecteableModel ifFalse: [ ^ self ].

	labelElement aptitude
		foreground: BrGlamorousColors hoveredButtonTextColor;
		underlineColor: BrGlamorousColors hoveredButtonBorderColor.

	objectElement
		border: (BlBorder builder
				paint: BrGlamorousColors hoveredButtonBorderColor;
				width: 1;
				build)
]

{ #category : #'api - participant view model' }
GtSequenceDiagramClassRoleElement >> subscribeToParticipantViewModel [
	self participantViewModel weak
		when: GtSequenceDiagramParticipantChanged
		send: #onParticipantChanged:
		to: self
]

{ #category : #'api - participant view model' }
GtSequenceDiagramClassRoleElement >> unsubscribeFromParticipantViewModel [
	self participantViewModel unsubscribe: self
]

{ #category : #'private - updating' }
GtSequenceDiagramClassRoleElement >> updateElementWithParticipant: aParticipant [
	labelElement text: aParticipant name.
	
	aParticipant hasModel ifFalse: [ ^ self ].
]
