Class {
	#name : #GtSequenceDiagram,
	#superclass : #Object,
	#instVars : [
		'participants',
		'messages'
	],
	#category : #'GToolkit-SequenceDiagram-Model'
}

{ #category : #'api - building' }
GtSequenceDiagram >> actor [
	<return: #GtSequenceDiagramActor>
	^ self actorNamed: 'Actor'
]

{ #category : #'api - building' }
GtSequenceDiagram >> actorNamed: aName [
	<return: #GtSequenceDiagramActor>
	^ self participant: (GtSequenceDiagramActor new name: aName)
]

{ #category : #'api - building' }
GtSequenceDiagram >> classRoleNamed: aName [
	<return: #GtSequenceDiagramClassRole>
	^ self participant: (GtSequenceDiagramClassRole new name: aName)
]

{ #category : #'api - building' }
GtSequenceDiagram >> from: aSender to: aReceiver [
	<return: #TGtSequenceDiagramMessage>
	| aMessage |
	aMessage := GtSequenceDiagramSynchronousMessage new.
	self messages: (self messages copyWith: aMessage).
	^ aMessage
]

{ #category : #accessing }
GtSequenceDiagram >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		priority: 1;
		stencil: [ 
			GtSequenceDiagramElement new
				sequenceDiagramViewModel: (GtSequenceDiagramViewModel new 
					sequenceDiagram: self);
				margin: (BlInsets all: 10);
				asPannableElement ];
		actionUpdateButton
]

{ #category : #'gt - extensions' }
GtSequenceDiagram >> gtMessagesFor: aView [
	<gtView>
	self messages ifNil: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Messages';
		priority: 11;
		items: [ self messages ];
		children: #messages;
		expandUpTo: 2;
		column: 'Name' text: #name;
		column: 'Sender' text: [ :aMessage | aMessage sender ifNotNil: #name ];
		column: 'Receiver' text: [ :aMessage | aMessage receiver ifNotNil: #name ];
		actionUpdateButton 
]

{ #category : #accessing }
GtSequenceDiagram >> gtParticipantsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Participants';
		priority: 10;
		items: [ self participants ifNil: [ #() ] ];
		column: 'Name' text: #name;
		actionUpdateButton
]

{ #category : #initialization }
GtSequenceDiagram >> initialize [
	super initialize.

	participants := Array empty.
	messages := Array empty.
]

{ #category : #'api - building' }
GtSequenceDiagram >> message: aMessage [
	<return: #TGtSequenceDiagramMessage>
	self messages: (self messages copyWith: aMessage).
	^ aMessage
]

{ #category : #accessing }
GtSequenceDiagram >> messages [

	^ messages
]

{ #category : #accessing }
GtSequenceDiagram >> messages: anObject [

	messages := anObject
]

{ #category : #enumerating }
GtSequenceDiagram >> messagesDepthFirstDo: aBlock [
	self messages
		do: [ :aMessage | 
			aBlock cull: aMessage cull: 1.
			aMessage messagesDepthFirstDo: aBlock depth: 2 ]
]

{ #category : #'api - building' }
GtSequenceDiagram >> participant: aParticipant [
	<return: #TGtSequenceDiagramParticipant>
	self participants: (self participants copyWith: aParticipant).
	^ aParticipant
]

{ #category : #accessing }
GtSequenceDiagram >> participants [

	^ participants
]

{ #category : #accessing }
GtSequenceDiagram >> participants: anObject [

	participants := anObject
]
