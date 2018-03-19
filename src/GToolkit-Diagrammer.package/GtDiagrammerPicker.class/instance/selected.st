accessing
selected
	self
		assert: [ self hasSelected ]
		description: [ 'Can not access selected object if nothing selected' ].
		
	^ selected