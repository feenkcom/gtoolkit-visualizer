Class {
	#name : #GtSequenceDiagramParticipantViewModel,
	#superclass : #Object,
	#traits : 'TGtWithSequenceDiagramParticipant + TGtAnnouncer',
	#classTraits : 'TGtWithSequenceDiagramParticipant classTrait + TGtAnnouncer classTrait',
	#instVars : [
		'announcer'
	],
	#category : #'GToolkit-SequenceDiagram-View Models'
}

{ #category : #announcer }
GtSequenceDiagramParticipantViewModel >> announcer [
	<return: #Announcer>
	^ announcer
]

{ #category : #converting }
GtSequenceDiagramParticipantViewModel >> asHeadElement [
	<return: #BlElement>
	^ GtSequenceDiagramClassRoleElement new participantViewModel: self
]

{ #category : #initialization }
GtSequenceDiagramParticipantViewModel >> initialize [
	super initialize.
	announcer := Announcer new
]

{ #category : #'private - notifying' }
GtSequenceDiagramParticipantViewModel >> notifyParticipantChanged [
	self
		announce: (GtSequenceDiagramParticipantChanged new participant: self participant)
]

{ #category : #'api - participant' }
GtSequenceDiagramParticipantViewModel >> onPostParticipantChanged [
	self notifyParticipantChanged
]

{ #category : #printing }
GtSequenceDiagramParticipantViewModel >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]
