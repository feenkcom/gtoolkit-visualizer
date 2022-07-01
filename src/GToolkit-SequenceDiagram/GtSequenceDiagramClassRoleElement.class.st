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

{ #category : #initialization }
GtSequenceDiagramClassRoleElement >> initialize [
	super initialize.
	self initializeChildren.
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
	labelElement text: aParticipant name
]
