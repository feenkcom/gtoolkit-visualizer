Class {
	#name : #GtSequenceDiagramParticipantChanged,
	#superclass : #Announcement,
	#instVars : [
		'participant'
	],
	#category : #'GToolkit-SequenceDiagram-Announcements'
}

{ #category : #accessing }
GtSequenceDiagramParticipantChanged >> participant [

	^ participant
]

{ #category : #accessing }
GtSequenceDiagramParticipantChanged >> participant: anObject [

	participant := anObject
]
