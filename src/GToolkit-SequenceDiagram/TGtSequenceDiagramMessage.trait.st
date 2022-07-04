Trait {
	#name : #TGtSequenceDiagramMessage,
	#category : #'GToolkit-SequenceDiagram-Model'
}

{ #category : #'gt - extensions' }
TGtSequenceDiagramMessage >> gtMessagesFor: aView [
	<gtView>
	self messages ifNil: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Messages';
		priority: 10;
		items: [ { self } ];
		children: #messages;
		expandUpTo: 2;
		column: 'Name' text: #name;
		column: 'Sender' text: [ :aMessage | aMessage sender ifNotNil: #name ];
		column: 'Receiver' text: [ :aMessage | aMessage receiver ifNotNil: #name ];
		actionUpdateButton 
]

{ #category : #accessing }
TGtSequenceDiagramMessage >> messages [
	<return: #Collection of: #TGtSequenceDiagramMessage>
	^ #()
]

{ #category : #enumerating }
TGtSequenceDiagramMessage >> messagesDepthFirstDo: aBlock [
	self messagesDepthFirstDo: aBlock depth: 1
]

{ #category : #enumerating }
TGtSequenceDiagramMessage >> messagesDepthFirstDo: aBlock depth: aDepth [
	self messages
		do: [ :aMessage | 
			aBlock cull: aMessage cull: aDepth.
			aMessage messagesDepthFirstDo: aBlock depth: aDepth + 1 ]
]

{ #category : #accessing }
TGtSequenceDiagramMessage >> name [
	<return: #String>
	^ self explicitRequirement
]

{ #category : #enumerating }
TGtSequenceDiagramMessage >> participantsDo: aBlock [
	aBlock cull: self sender.
	self receiver = self sender ifTrue: [ ^ self ].
	aBlock cull: self receiver
]

{ #category : #accessing }
TGtSequenceDiagramMessage >> receiver [
	<return: #TGtSequenceDiagramParticipant>
	^ self explicitRequirement
]

{ #category : #accessing }
TGtSequenceDiagramMessage >> sender [
	<return: #TGtSequenceDiagramParticipant>
	^ self explicitRequirement
]
