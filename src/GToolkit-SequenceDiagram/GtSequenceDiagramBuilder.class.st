Class {
	#name : #GtSequenceDiagramBuilder,
	#superclass : #Object,
	#instVars : [
		'sequenceDiagram'
	],
	#category : #'GToolkit-SequenceDiagram-Model'
}

{ #category : #'api - building' }
GtSequenceDiagramBuilder >> build [
	"Everything is ready. Later, we will do some model checks."

	^ self sequenceDiagram
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
	^ self sequenceDiagram participant: aParticipant
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
