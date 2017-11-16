private - adding / removing
addButton: anElement

	self
		assert: [ anElement isAttachedToSceneGraph not ]
		description: [ 'Button must be newly created and not attached to the scene graph' ].

	anElement
		addEventHandlerOn: GtConnectorButtonAddedToSceneGraph
		do: [ self connect: anElement ]