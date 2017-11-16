private - adding / removing
registerButton: anElement

	self
		assert: [ anElement isAttachedToSceneGraph not ]
		description: [ 'Button must be newly created and not attached to the scene graph' ].

	anElement addEventHandler: buttonAddedListener