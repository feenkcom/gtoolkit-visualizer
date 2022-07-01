Class {
	#name : #GtSequenceDiagramSelfMessage,
	#superclass : #GtSequenceDiagramMessage,
	#instVars : [
		'participant'
	],
	#category : #'GToolkit-SequenceDiagram-Model'
}

{ #category : #accessing }
GtSequenceDiagramSelfMessage >> participant [
	<return: #TGtSequenceDiagramParticipant>
	^ participant
]

{ #category : #accessing }
GtSequenceDiagramSelfMessage >> participant: aParticipant [

	participant := aParticipant
]

{ #category : #accessing }
GtSequenceDiagramSelfMessage >> receiver [
	<return: #TGtSequenceDiagramParticipant>
	^ self participant
]

{ #category : #accessing }
GtSequenceDiagramSelfMessage >> sender [
	<return: #TGtSequenceDiagramParticipant>
	^ self participant
]
