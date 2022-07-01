Class {
	#name : #GtSequenceDiagramViewModel,
	#superclass : #Object,
	#traits : 'TGtWithSequenceDiagram + TGtAnnouncer',
	#classTraits : 'TGtWithSequenceDiagram classTrait + TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'participantViewModels',
		'messageViewModels'
	],
	#category : #'GToolkit-SequenceDiagram-View Models'
}

{ #category : #announcer }
GtSequenceDiagramViewModel >> announcer [
	<return: #Announcer>
	^ announcer
]

{ #category : #'gt - extensions' }
GtSequenceDiagramViewModel >> gtMessagesFor: aView [
	<gtView>
	self messageViewModels ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Messages';
		priority: 11;
		items: [ self messageViewModels ];
		column: 'Index' text: [ :_ :anIndex | anIndex ] width: 40;
		column: 'Depth' text: #depth width: 40;
		column: 'Name' text: #name;
		column: 'Sender' text: [ :aMessage | aMessage senderViewModel ifNotNil: #name ];
		column: 'Receiver' text: [ :aMessage | aMessage receiverViewModel ifNotNil: #name ];
		actionUpdateButton 
]

{ #category : #'gt - extensions' }
GtSequenceDiagramViewModel >> gtParticipantsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Participants';
		priority: 10;
		items: [ self participantViewModels ifNil: [ #() ] ];
		column: 'Name' text: #name;
		actionUpdateButton
]

{ #category : #initalize }
GtSequenceDiagramViewModel >> initialize [
	super initialize.

	announcer := Announcer new
]

{ #category : #accessing }
GtSequenceDiagramViewModel >> messageViewModels [

	^ messageViewModels
]

{ #category : #'private - notifying' }
GtSequenceDiagramViewModel >> notifySequenceDiagramChanged [
	self announce: (GtSequenceDiagramChangedAnnouncement new 
		sequenceDiagram: self sequenceDiagram)
]

{ #category : #'api - sequence diagram' }
GtSequenceDiagramViewModel >> onSequenceDiagramChanged [
	self updateParticipantViewModels.
	self updateMessageViewModels.
	self notifySequenceDiagramChanged
]

{ #category : #'private - accessing' }
GtSequenceDiagramViewModel >> participantViewModelOfParticipant: aParticipant [
	^ self participantViewModels
		detect: [ :eachViewModel | eachViewModel participant = aParticipant ]
]

{ #category : #accessing }
GtSequenceDiagramViewModel >> participantViewModels [
	^ participantViewModels ifNil: [ #() ]
]

{ #category : #'private - updating' }
GtSequenceDiagramViewModel >> updateMessageViewModels [
	messageViewModels := Array
			streamContents: [ :aStream | 
				self sequenceDiagram
					messagesDepthFirstDo: [ :aMessage :aDepth | 
						| aViewModel aSenderViewModel aReceiverViewModel |
						aSenderViewModel := self participantViewModelOfParticipant: aMessage sender.
						aReceiverViewModel := self participantViewModelOfParticipant: aMessage receiver.
						aViewModel := GtSequenceDiagramMessageViewModel new
								senderViewModel: aSenderViewModel;
								receiverViewModel: aReceiverViewModel;
								message: aMessage;
								depth: aDepth.
						aStream nextPut: aViewModel ] ]
]

{ #category : #'private - updating' }
GtSequenceDiagramViewModel >> updateParticipantViewModels [
	participantViewModels := self sequenceDiagram participants
			collect: [ :eachParticipant | GtSequenceDiagramParticipantViewModel new participant: eachParticipant ]
]
