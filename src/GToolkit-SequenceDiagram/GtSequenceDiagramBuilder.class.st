Class {
	#name : #GtSequenceDiagramBuilder,
	#superclass : #Object,
	#instVars : [
		'sequenceDiagram',
		'createdParticipants'
	],
	#category : #'GToolkit-SequenceDiagram-Model'
}

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

{ #category : #accessing }
GtSequenceDiagramBuilder >> initialize [
	super initialize.

	createdParticipants := OrderedCollection new
]

{ #category : #'api - building' }
GtSequenceDiagramBuilder >> message [
	<return: #TGtSequenceDiagramMessage>
	| aMessage |
	aMessage := GtSequenceDiagramSendMessage new.
	^ self sequenceDiagram message: aMessage
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
	^ sequenceDiagram ifNil: [ sequenceDiagram := GtSequenceDiagram new ]
]

{ #category : #accessing }
GtSequenceDiagramBuilder >> sequenceDiagram: aSequenceDiagram [
	sequenceDiagram := aSequenceDiagram
]
