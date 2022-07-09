Trait {
	#name : #TGtSequenceDiagramParticipant,
	#category : #'GToolkit-SequenceDiagram-Model'
}

{ #category : #testing }
TGtSequenceDiagramParticipant >> hasModel [
	^ self explicitRequirement
]

{ #category : #accessing }
TGtSequenceDiagramParticipant >> model [
	^ self explicitRequirement
]

{ #category : #accessing }
TGtSequenceDiagramParticipant >> model: aModel [
	self explicitRequirement
]

{ #category : #accessing }
TGtSequenceDiagramParticipant >> name [
	"Return participant name"

	<return: #String>
	^ self explicitRequirement
]

{ #category : #ui }
TGtSequenceDiagramParticipant >> newParticipatElementUsingBuilder: aBuilder viewModel: aViewModel [
	<return: #BlElement>
	^ self explicitRequirement
]
