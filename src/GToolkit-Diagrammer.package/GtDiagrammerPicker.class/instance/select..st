enumerating
select: anEntity
	self
		assert: [ anEntity isNotNil ]
		description: [ 'Selected entity must not be nil' ].

	selected = anEntity
		ifTrue: [ ^ self ].

	selected := anEntity.
	self initializeSelection