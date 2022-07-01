Class {
	#name : #GtSequenceDiagramParticipantChanged,
	#superclass : #Announcement,
	#instVars : [
		'participant'
	],
	#category : #'GToolkit-SequenceDiagram-Announcments'
}

{ #category : #accessing }
GtSequenceDiagramParticipantChanged >> participant [

	^ participant
]

{ #category : #accessing }
GtSequenceDiagramParticipantChanged >> participant: anObject [

	participant := anObject
]
