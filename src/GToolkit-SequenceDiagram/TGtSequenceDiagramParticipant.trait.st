Trait {
	#name : #TGtSequenceDiagramParticipant,
	#category : #'GToolkit-SequenceDiagram-Model'
}

{ #category : #accessing }
TGtSequenceDiagramParticipant >> name [
	"Return participant name"

	<return: #String>
	^ self explicitRequirement
]
