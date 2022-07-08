Class {
	#name : #GtSequenceDiagramBuilder,
	#superclass : #Object,
	#instVars : [
		'sequenceDiagram',
		'createdParticipants',
		'messageOwnerStack'
	],
	#category : #'GToolkit-SequenceDiagram-Model'
}

{ #category : #'api - building' }
GtSequenceDiagramBuilder >> actor [
	<return: #TGtSequenceDiagramParticipant>
	| aParticipant |
	aParticipant := GtSequenceDiagramActor new.
	^ createdParticipants add: aParticipant
]

{ #category : #'api - building' }
GtSequenceDiagramBuilder >> build [
	self collectMessageParticipants.

	^ self sequenceDiagram
]

{ #category : #'private - building' }
GtSequenceDiagramBuilder >> collectMessageParticipants [
	"We add to the diagram only participants that are used during a communication."

	| notRegisteredParticipants toAddParticipants |
	notRegisteredParticipants := Set new.

	self sequenceDiagram
		messagesDepthFirstDo: [ :aMessage :aDepth | 
			aMessage
				participantsDo: [ :eachParticipant | 
					(self sequenceDiagram participants includes: eachParticipant)
						ifFalse: [ notRegisteredParticipants add: eachParticipant ] ] ].

	toAddParticipants := createdParticipants
			select: [ :eachParticipant | notRegisteredParticipants includes: eachParticipant ].

	toAddParticipants
		do: [ :eachParticipant | self sequenceDiagram participant: eachParticipant ]
]

{ #category : #'api - building' }
GtSequenceDiagramBuilder >> forAll: rootModels children: aChildrenBlock do: aDoBlock [
	rootModels
		do: [ :eachModel | 
			| aMessage aModelChildren |
			aMessage := aDoBlock cull: eachModel.
			messageOwnerStack push: aMessage.
			aModelChildren := aChildrenBlock cull: eachModel.
			self
				forAll: aModelChildren
				children: aChildrenBlock
				do: aDoBlock.
			messageOwnerStack pop ]
]

{ #category : #accessing }
GtSequenceDiagramBuilder >> initialize [
	super initialize.

	createdParticipants := OrderedCollection new.
	messageOwnerStack := Stack new.
]

{ #category : #'api - building' }
GtSequenceDiagramBuilder >> message [
	<return: #TGtSequenceDiagramMessage>
	| aMessage |
	self
		assert: [ messageOwnerStack isNotEmpty ]
		description: [ 'Sequence diagram must be initialized before any message creation' ].

	aMessage := GtSequenceDiagramSendMessage new.
	messageOwnerStack top message: aMessage.
	^ aMessage
]

{ #category : #'api - building' }
GtSequenceDiagramBuilder >> participant [
	<return: #TGtSequenceDiagramParticipant>
	| aParticipant |
	aParticipant := GtSequenceDiagramClassRole new.
	^ createdParticipants add: aParticipant
]

{ #category : #'api - building' }
GtSequenceDiagramBuilder >> response [
	<return: #TGtSequenceDiagramMessage>
	| aMessage |
	aMessage := GtSequenceDiagramResponseMessage new.
	^ self sequenceDiagram message: aMessage
]

{ #category : #'api - building' }
GtSequenceDiagramBuilder >> selfMessage [
	<return: #TGtSequenceDiagramMessage>
	| aMessage |
	aMessage := GtSequenceDiagramSelfMessage new.
	^ self sequenceDiagram message: aMessage
]

{ #category : #accessing }
GtSequenceDiagramBuilder >> sequenceDiagram [
	^ sequenceDiagram
		ifNil: [ | aDiagram |
			aDiagram := GtSequenceDiagram new.
			self sequenceDiagram: aDiagram.
			aDiagram ]
]

{ #category : #accessing }
GtSequenceDiagramBuilder >> sequenceDiagram: aSequenceDiagram [
	self
		assert: [ sequenceDiagram isNil ]
		description: [ 'Sequence diagram must be initialized only once' ].
	self
		assert: [ messageOwnerStack isEmpty ]
		description: [ 'Sequence diagram must be initialized before message owner stack' ].

	sequenceDiagram := aSequenceDiagram.
	messageOwnerStack push: aSequenceDiagram
]
