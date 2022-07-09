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

{ #category : #testing }
GtSequenceDiagramParticipantViewModel >> hasModel [
	^ self hasParticipant and: [ self participant hasModel ]
]

{ #category : #initialization }
GtSequenceDiagramParticipantViewModel >> initialize [
	super initialize.
	announcer := Announcer new
]

{ #category : #accessing }
GtSequenceDiagramParticipantViewModel >> model [
	^ self participant model
]

{ #category : #converting }
GtSequenceDiagramParticipantViewModel >> newParticipantElementUsingBuilder: aBuilder [
	<return: #BlElement>
	^ self participant newParticipatElementUsingBuilder: aBuilder viewModel: self
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
